<?
define("ADMIN_MODULE_NAME", "clouds");

/*.require_module 'standard';.*/
/*.require_module 'pcre';.*/
/*.require_module 'bitrix_main_include_prolog_admin_before';.*/
require_once($_SERVER["DOCUMENT_ROOT"]."/bitrix/modules/main/include/prolog_admin_before.php");

if(!$USER->CanDoOperation("clouds_browse"))
	$APPLICATION->AuthForm(GetMessage("ACCESS_DENIED"));

/*.require_module 'bitrix_clouds_include';.*/
if(!CModule::IncludeModule('clouds'))
	$APPLICATION->AuthForm(GetMessage("ACCESS_DENIED"));

IncludeModuleLangFile(__FILE__);

$obBucket = new CCloudStorageBucket(intval($_GET["bucket"]));
if(!$obBucket->Init())
	$APPLICATION->AuthForm(GetMessage("ACCESS_DENIED"));

$PHPchunkSize = 1024*1024; // 1M later TODO return_bytes(ini_get('post_max_size'))
$CLOchunkSize = $obBucket->GetService()->GetMinUploadPartSize();

$message = /*.(CAdminMessage).*/null;
$path = (string)$_GET["path"];
$sTableID = "tbl_clouds_file_list";
$lAdmin = new CAdminList($sTableID);

$arID = $lAdmin->GroupAction();
$action = isset($_REQUEST["action"]) && is_string($_REQUEST["action"])? "$_REQUEST[action]": "";
if($USER->CanDoOperation("clouds_upload") && is_array($arID))
{
	foreach($arID as $ID)
	{
		if(strlen($ID) <= 0)
			continue;

		switch($action)
		{
		case "delete":
			if(substr($ID, 0, 1) === "F")
			{
				$file_size = $obBucket->GetFileSize($path.substr($ID, 1));
				if(!$obBucket->DeleteFile($path.substr($ID, 1)))
				{
					$e = $APPLICATION->GetException();
					if(is_object($e))
						$lAdmin->AddUpdateError($e->GetString(), $ID);
				}
				else
				{
					$obBucket->DecFileCounter($file_size);
				}
			}
			elseif(substr($ID, 0, 1) === "D")
			{
				$arFiles = $obBucket->ListFiles($path.substr($ID, 1), true);
				foreach($arFiles["file"] as $i => $file)
				{
					if(!$obBucket->DeleteFile($path.substr($ID, 1)."/".$file))
					{
						$e = $APPLICATION->GetException();
						$lAdmin->AddUpdateError($e->GetString(), $ID);
						break;
					}
					else
					{
						$obBucket->DecFileCounter($arFiles["file_size"][$i]);
					}
				}
			}
			break;
		case "chunk_upload":
			require_once($_SERVER["DOCUMENT_ROOT"]."/bitrix/modules/main/include/prolog_admin_js.php");
			$strError = "";
			$bytes = 0;
			$fileSize = doubleval($_REQUEST["file_size"]);
			$tempDir = CTempFile::GetDirectoryName(6, "clouds_ipload");
			$absPath = $tempDir."tmp_name";

			if(isset($_REQUEST["file_name"]))
			{
				$filePath = CCloudStorage::translit($_REQUEST["file_name"]);
				$filePath = "/".$_REQUEST["path_to_upload"]."/".$filePath;
				$filePath = preg_replace("#[\\\\\\/]+#", "/", $filePath);

				//TODO: make it once
				if($obBucket->FileExists($filePath))
					$strError = GetMessage("CLO_STORAGE_FILE_EXISTS_ERROR");
			}

			if(isset($_REQUEST["chunk_start"]))
			{
				CheckDirPath($tempDir);

				// read contents from the input stream
				$inputHandler = fopen('php://input', "rb");
				// create a temp file where to save data from the input stream
				$fileHandler = fopen($absPath, "ab");
				// save data from the input stream
				while(!feof($inputHandler))
					fwrite($fileHandler, fread($inputHandler, 1024*1024));

//if($_SESSION["ttt"] > 5) $strError = GetMessage("CLO_STORAGE_FILE_OPEN_ERROR");
			}
			else
			{
				@unlink($absPath);
			}

			if($strError == "")
			{
				if($fileSize <= $CLOchunkSize)
				{
					if(!file_exists($absPath))
					{
						$moveResult = CCloudStorage::FILE_PARTLY_UPLOADED;
						?><script>
							readFileChunk(0, <?echo $PHPchunkSize-1?>);
						</script><?
					}
					elseif(filesize($absPath) < $fileSize)
					{
						$bytes = filesize($absPath);
						$moveResult = CCloudStorage::FILE_PARTLY_UPLOADED;
						?><script>
							readFileChunk(<?echo $bytes?>, <?echo min($fileSize-1, $bytes+$PHPchunkSize-1)?>);
						</script><?
					}
					else
					{
						$ar = CFile::MakeFileArray($absPath);

						if(!is_array($ar) || !isset($ar["tmp_name"]))
						{
							$strError = GetMessage("CLO_STORAGE_FILE_UNKNOWN_ERROR", array("#CODE#" => "e11"));
						}
						else
						{
							$res = $obBucket->SaveFile($filePath, $ar);
							if($res)
							{
								$bytes = $fileSize;
								$moveResult = CCloudStorage::FILE_MOVED;
								$obBucket->IncFileCounter($fileSize);
							}
							else
							{
								$strError = GetMessage("CLO_STORAGE_FILE_UNKNOWN_ERROR", array("#CODE#" => "e12"));
							}
							@unlink($absPath);
						}
					}
				}
				else
				{
					$obUpload = new CCloudStorageUpload($filePath);

					if(!$obUpload->isStarted())
					{
						if($obUpload->Start($obBucket->ID, $fileSize, $_REQUEST["file_type"]))
						{
							$moveResult = CCloudStorage::FILE_PARTLY_UPLOADED;
							?><script>
								readFileChunk(0, <?echo $PHPchunkSize-1?>);
							</script><?
						}
						else
							$strError = GetMessage("CLO_STORAGE_FILE_UNKNOWN_ERROR", array("#CODE#" => "e01"));
					}
					else
					{
						$pos = $obUpload->getPos();
						if($pos > $fileSize)
						{
							if($obUpload->Finish())
							{
								$bytes = $fileSize;
								$obBucket->IncFileCounter($fileSize);
								@unlink($absPath);
								$moveResult = CCloudStorage::FILE_MOVED;
							}
							else
							{
								$strError = GetMessage("CLO_STORAGE_FILE_UNKNOWN_ERROR", array("#CODE#" => "e02"));
							}
						}
						else
						{
							if(!file_exists($absPath))
							{
								$moveResult = CCloudStorage::FILE_PARTLY_UPLOADED;
								?><script>
									readFileChunk(<?echo $pos?>, <?echo $pos + $PHPchunkSize-1?>);
								</script><?
							}
							elseif(
								filesize($absPath) < $obUpload->getPartSize()
								&& ($pos + filesize($absPath) < $fileSize)
							)
							{
								$bytes = $pos + filesize($absPath);
								$moveResult = CCloudStorage::FILE_PARTLY_UPLOADED;
								?><script>
									readFileChunk(<?echo $bytes?>, <?echo min($fileSize-1, $bytes+$PHPchunkSize-1)?>);
								</script><?
							}
							else
							{
								$part = file_get_contents($absPath);
								$bytes = $pos + filesize($absPath);
								$moveResult = CCloudStorage::FILE_SKIPPED;
								while($obUpload->hasRetries())
								{
									if($obUpload->Next($part))
									{
										$moveResult = CCloudStorage::FILE_PARTLY_UPLOADED;
										break;
									}
								}

								if($moveResult == CCloudStorage::FILE_SKIPPED)
									$strError = GetMessage("CLO_STORAGE_FILE_UNKNOWN_ERROR", array("#CODE#" => "e03"));
								else
								{
									?><script>
										readFileChunk(<?echo $obUpload->getPos()?>, <?echo min($fileSize-1, $obUpload->getPos()+$PHPchunkSize-1)?>);
									</script><?
									@unlink($absPath);
								}
							}
						}
					}
				}

			}

			if($strError != "")
			{
				$e = $APPLICATION->GetException();
				if(!is_object($e))
					$e = new CApplicationException($strError);

				$message = new CAdminMessage(GetMessage("CLO_STORAGE_FILE_UPLOAD_ERROR"), $e);
			}

			if(is_object($message))
			{
				echo $message->Show();
				$message = null;
			}
			elseif($moveResult == CCloudStorage::FILE_PARTLY_UPLOADED)
			{
				CAdminMessage::ShowMessage(array(
					"MESSAGE"=>GetMessage("CLO_STORAGE_FILE_UPLOAD_IN_PROGRESS"),
					"DETAILS"=>GetMessage("CLO_STORAGE_FILE_UPLOAD_PROGRESS", array(
						"#bytes#" => CFile::FormatSize($bytes),
						"#file_size#" => CFile::FormatSize($fileSize),
					)).'<br /><br /><input type="button" value="'.GetMessage("CLO_STORAGE_FILE_STOP").'" onclick="window.location = \''.CUtil::AddSlashes("/bitrix/admin/clouds_file_list.php?lang=".urlencode(LANGUAGE_ID)."&bucket=".urlencode($obBucket->ID)."&path=".urlencode($path)).'\'">',
					"HTML"=>true,
					"TYPE"=>"OK",
				));
			}
			else
			{
				CAdminMessage::ShowMessage(array(
					"MESSAGE"=>GetMessage("CLO_STORAGE_FILE_UPLOAD_DONE"),
					"DETAILS"=>GetMessage("CLO_STORAGE_FILE_UPLOAD_PROGRESS", array(
						"#bytes#" => CFile::FormatSize($bytes),
						"#file_size#" => CFile::FormatSize($fileSize),
					)),
					"HTML"=>true,
					"TYPE"=>"OK",
				));
				?><script>
					<?=$sTableID?>.GetAdminList('<?echo CUtil::JSEscape($APPLICATION->GetCurPage().'?lang='.urlencode(LANGUAGE_ID).'&bucket='.urlencode($obBucket->ID).'&path='.urlencode($path))?>');
				</script><?
			}

			require($_SERVER["DOCUMENT_ROOT"].BX_ROOT."/modules/main/include/epilog_admin_js.php");
		case "upload":
			$strError = "";
			$io = CBXVirtualIo::GetInstance();

			if($ID === "Fnew")
			{
				if(isset($_FILES["upload"]) && $_FILES["upload"]["error"] == 0)
				{
					$filePath = CCloudStorage::translit($_FILES["upload"]["name"]);
					$filePath = "/".$_REQUEST["path_to_upload"]."/".$filePath;
					$filePath = preg_replace("#[\\\\\\/]+#", "/", $filePath);

					$f = $io->GetFile($_FILES["upload"]["tmp_name"]);
				}
				else
				{
					break;
				}
			}
			else
			{
				//TODO check for ../../../
				$filePath = CCloudStorage::translit(substr($ID, 1));
				$filePath = "/".$path."/".$filePath;
				$filePath = preg_replace("#[\\\\\\/]+#", "/", $filePath);

				$f = $io->GetFile(preg_replace("#[\\\\\\/]+#", "/", $_SERVER["DOCUMENT_ROOT"]."/".$path."/".substr($ID, 1)));
			}

			if(
				substr($ID, 0, 1) !== "F"
				|| $obBucket->ACTIVE !== "Y"
				|| $obBucket->READ_ONLY !== "N"
			)
				break;

			if($obBucket->FileExists($filePath))
			{
				$message = new CAdminMessage(GetMessage("CLO_STORAGE_FILE_UPLOAD_ERROR"), new CApplicationException(GetMessage("CLO_STORAGE_FILE_EXISTS_ERROR")));
				break;
			}

			$fp = $f->Open("rb");
			if(!is_resource($fp))
			{
				$message = new CAdminMessage(GetMessage("CLO_STORAGE_FILE_UPLOAD_ERROR"), new CApplicationException(GetMessage("CLO_STORAGE_FILE_OPEN_ERROR")));
				break;
			}

			$bytes = 0;
			$fileSize = $f->GetFileSize();
			if($fileSize > $obBucket->GetService()->GetMinUploadPartSize())
			{
				$obUpload = new CCloudStorageUpload($filePath);

				if(!$obUpload->isStarted())
				{
					if($obUpload->Start($obBucket->ID, $fileSize, CFile::GetContentType($io->GetPhysicalName($f->GetPathWithName()))))
						$moveResult = CCloudStorage::FILE_PARTLY_UPLOADED;
					else
						$strError = GetMessage("CLO_STORAGE_FILE_UNKNOWN_ERROR", array("#CODE#" => "e01"));
				}
				else
				{
					$pos = $obUpload->getPos();
					if($pos > $fileSize)
					{
						if($obUpload->Finish())
						{
							$bytes = $fileSize;
							$obBucket->IncFileCounter($fileSize);
							@unlink($io->GetPhysicalName($f->GetPathWithName()));
							$moveResult = CCloudStorage::FILE_MOVED;
						}
						else
						{
							$strError = GetMessage("CLO_STORAGE_FILE_UNKNOWN_ERROR", array("#CODE#" => "e02"));
						}
					}
					else
					{
						fseek($fp, $pos);
						$part = fread($fp, $obUpload->getPartSize());
						$bytes = $pos + $part;
						$moveResult = CCloudStorage::FILE_SKIPPED;
						while($obUpload->hasRetries())
						{
							if($obUpload->Next($part))
							{
								$moveResult = CCloudStorage::FILE_PARTLY_UPLOADED;
								break;
							}
						}

						if($moveResult == CCloudStorage::FILE_SKIPPED)
							$strError = GetMessage("CLO_STORAGE_FILE_UNKNOWN_ERROR", array("#CODE#" => "e03"));
					}
				}
			}
			else
			{
				$ar = CFile::MakeFileArray($io->GetPhysicalName($f->GetPathWithName()));
				if(!is_array($ar) || !isset($ar["tmp_name"]))
				{
					$strError = GetMessage("CLO_STORAGE_FILE_UNKNOWN_ERROR", array("#CODE#" => "e11"));
				}
				else
				{
					$res = $obBucket->SaveFile($filePath, $ar);
					if($res)
					{
						$bytes = $fileSize;
						$moveResult = CCloudStorage::FILE_MOVED;
						$obBucket->IncFileCounter($fileSize);
						@unlink($io->GetPhysicalName($f->GetPathWithName()));
					}
					else
					{
						$strError = GetMessage("CLO_STORAGE_FILE_UNKNOWN_ERROR", array("#CODE#" => "e12"));
					}
				}
			}

			$lAdmin->BeginPrologContent();

			if($strError != "")
			{
				$e = $APPLICATION->GetException();
				if(!is_object($e))
					$e = new CApplicationException($strError);

				$message = new CAdminMessage(GetMessage("CLO_STORAGE_FILE_UPLOAD_ERROR"), $e);
			}

			if(is_object($message))
			{
				echo $message->Show();
				$message = null;
			}
			elseif($moveResult == CCloudStorage::FILE_PARTLY_UPLOADED)
			{
				CAdminMessage::ShowMessage(array(
					"MESSAGE"=>GetMessage("CLO_STORAGE_FILE_UPLOAD_IN_PROGRESS"),
					"DETAILS"=>GetMessage("CLO_STORAGE_FILE_UPLOAD_PROGRESS", array(
						"#bytes#" => CFile::FormatSize($bytes),
						"#file_size#" => CFile::FormatSize($fileSize),
					)).'<br /><br /><input type="button" value="'.GetMessage("CLO_STORAGE_FILE_STOP").'" onclick="window.location = \''.CUtil::JSEscape("/bitrix/admin/clouds_file_list.php?lang=".urlencode(LANGUAGE_ID)."&bucket=".urlencode($obBucket->ID)."&path=".urlencode($path)).'\'">',
					"HTML"=>true,
					"TYPE"=>"OK",
				));
			}
			else
			{
				CAdminMessage::ShowMessage(array(
					"MESSAGE"=>GetMessage("CLO_STORAGE_FILE_UPLOAD_DONE"),
					"DETAILS"=>GetMessage("CLO_STORAGE_FILE_UPLOAD_PROGRESS", array(
						"#bytes#" => CFile::FormatSize($bytes),
						"#file_size#" => CFile::FormatSize($fileSize),
					)),
					"HTML"=>true,
					"TYPE"=>"OK",
				));
			}
			$lAdmin->EndPrologContent();

			if($moveResult == CCloudStorage::FILE_PARTLY_UPLOADED)
			{
				$lAdmin->BeginEpilogContent();
				echo '<script>BX.ready(function(){', $lAdmin->ActionDoGroup($ID, "upload", "bucket=".urlencode($obBucket->ID)."&path=".urlencode($path)), '});</script>';
				$lAdmin->EndEpilogContent();
			}
			break;
		default:
			break;
		}
	}
}

$arHeaders = array(
	array(
		"id" => "FILE_NAME",
		"content" => GetMessage("CLO_STORAGE_FILE_NAME"),
		"default" => true,
	),
	array(
		"id" => "FILE_SIZE",
		"content" => GetMessage("CLO_STORAGE_FILE_SIZE"),
		"align" => "right",
		"default" => true,
	),
);

$lAdmin->AddHeaders($arHeaders);

$arData = /*.(array[int][string]string).*/array();
$arFiles = $obBucket->ListFiles($path);

if($path != "/")
	$arData[] = array("ID" => "D..", "TYPE" => "dir", "NAME" => "..", "SIZE" => "");
if(is_array($arFiles))
{
	foreach($arFiles["dir"] as $i => $dir)
		$arData[] = array("ID" => "D".$dir, "TYPE" => "dir", "NAME" => $dir, "SIZE" => '');
	foreach($arFiles["file"] as $i => $file)
		$arData[] = array("ID" => "F".$file, "TYPE" => "file", "NAME" => $file, "SIZE" => $arFiles["file_size"][$i]);
}
else
{
	$e = $APPLICATION->GetException();
	if(is_object($e))
		$message = new CAdminMessage(GetMessage("CLO_STORAGE_FILE_LIST_ERROR"), $e);
}

$total_size = 0;

$rsData = new CDBResult;
$rsData->InitFromArray($arData);
$rsData = new CAdminResult($rsData, $sTableID);
$rsData->NavStart();
$lAdmin->NavText($rsData->GetNavPrint(''));

while(is_array($arRes = $rsData->NavNext()))
{
	$row =& $lAdmin->AddRow($arRes["ID"], $arRes);

	if($arRes["TYPE"] === "dir")
	{
		if($arRes["NAME"] === "..")
		{
			$row->bReadOnly = true;
			$row->AddViewField("FILE_NAME", '<div class="clouds_menu_icon_folder_up"></div><a href="'.htmlspecialchars('clouds_file_list.php?lang='.urlencode(LANGUAGE_ID).'&bucket='.urlencode($obBucket->ID).'&path='.urlencode(preg_replace('#([^/]+)/$#', '', $path))).'">'.htmlspecialcharsex($arRes["NAME"]).'</a>');
			$row->AddViewField("FILE_SIZE", '&nbsp;');
		}
		else
		{
			$row->AddViewField("FILE_NAME", '<div class="clouds_menu_icon_folder"></div><a href="'.htmlspecialchars('clouds_file_list.php?lang='.urlencode(LANGUAGE_ID).'&bucket='.urlencode($obBucket->ID).'&path='.urlencode($path.$arRes["NAME"].'/')).'">'.htmlspecialcharsex($arRes["NAME"]).'</a>');
			if($_GET["size"] === "y")
			{
				$arDirFiles = $obBucket->ListFiles($path.$arRes["NAME"]."/", true);
				$size = array_sum($arDirFiles["file_size"]);
				$row->AddViewField("FILE_SIZE", CFile::FormatSize((float)$size));
				$total_size += $size;
			}
			else
			{
				$row->AddViewField("FILE_SIZE", '&nbsp;');
			}
		}
	}
	else
	{
		$row->AddViewField("FILE_NAME", '<a href="'.htmlspecialchars($obBucket->GetFileSRC(array("URN" => $path.$arRes["NAME"]))).'">'.htmlspecialcharsex($arRes["NAME"]).'</a>');
		$row->AddViewField("FILE_SIZE", CFile::FormatSize((float)$arRes["SIZE"]));
		$total_size += $arRes["SIZE"];
	}

	$arActions = /*.(array[int][string]string).*/array();

	if($USER->CanDoOperation("clouds_upload"))
		$arActions[] = array(
			"ICON"=>"delete",
			"TEXT"=>GetMessage("CLO_STORAGE_FILE_DELETE"),
			"ACTION"=>"if(confirm('".GetMessage("CLO_STORAGE_FILE_DELETE_CONF")."')) ".$lAdmin->ActionDoGroup($arRes["ID"], "delete", 'bucket='.urlencode($obBucket->ID).'&path='.urlencode($path))
		);

	if(!empty($arActions))
		$row->AddActions($arActions);
}

$arFooter = array(
	array(
		"title" => GetMessage("MAIN_ADMIN_LIST_SELECTED"),
		"value" => $path === "/"? $rsData->SelectedRowsCount(): $rsData->SelectedRowsCount()-1, // W/O ..
	),
	array(
		"title" => GetMessage("MAIN_ADMIN_LIST_CHECKED"),
		"value" => 0,
		"counter" => true,
	),
);
if($total_size > 0)
{
	$arFooter[] = array(
		"title" => GetMessage("CLO_STORAGE_FILE_SIZE").":",
		"value" => CFile::FormatSize($total_size),
	);
}
$lAdmin->AddFooter($arFooter);

$arGroupActions = array();

if($USER->CanDoOperation("clouds_upload"))
	$arGroupActions["delete"] = GetMessage("MAIN_ADMIN_LIST_DELETE");

$lAdmin->AddGroupActionTable($arGroupActions);

$chain = $lAdmin->CreateChain();
$arPath = explode("/", $path);
$curPath = "/";
foreach($arPath as $dir)
{
	if($dir != "")
	{
		$curPath .= $dir."/";
		$url = "clouds_file_list.php?lang=".urlencode(LANGUAGE_ID)."&bucket=".urlencode($obBucket->ID)."&path=".urlencode($curPath);
		$chain->AddItem(array(
			"TEXT" => htmlspecialcharsex($dir),
			"LINK" => htmlspecialchars($url),
			"ONCLICK" => $lAdmin->ActionAjaxReload($url).';return false;',
		));
	}
}
$lAdmin->ShowChain($chain);

$aContext = array(
	array(
		"TEXT" => GetMessage("CLO_STORAGE_FILE_SHOW_DIR_SIZE"),
		"LINK" => "/bitrix/admin/clouds_file_list.php?lang=".urlencode(LANGUAGE_ID).'&bucket='.urlencode($obBucket->ID).'&path='.urlencode($path).'&size=y',
		"TITLE" => GetMessage("CLO_STORAGE_FILE_SHOW_DIR_SIZE_TITLE"),
		"ICON" => "btn_list",
	),
);
if(
	$obBucket->ACTIVE === "Y"
	&& $obBucket->READ_ONLY === "N"
	&& $USER->CanDoOperation("clouds_upload")
)
{
	$aContext[] = array(
		"TEXT" => GetMessage("CLO_STORAGE_FILE_UPLOAD"),
		"LINK" => "javascript:show_upload_form()",
		"TITLE" => GetMessage("CLO_STORAGE_FILE_UPLOAD_TITLE"),
		"ICON" => "btn_upload",
	);
}
$lAdmin->AddAdminContextMenu($aContext, /*$bShowExcel=*/false);

$lAdmin->BeginPrologContent();


if(is_object($message))
	echo $message->Show();
$lAdmin->EndPrologContent();

$lAdmin->CheckListMode();

$APPLICATION->SetTitle($obBucket->BUCKET);

require($_SERVER["DOCUMENT_ROOT"]."/bitrix/modules/main/include/prolog_admin_after.php");

if($USER->CanDoOperation("clouds_upload")):

CUtil::InitJSCore(array('fx'));

$aTabs = array(
	array(
		"DIV" => "edit1",
		"TAB" => GetMessage("CLO_STORAGE_FILE_UPLOAD"),
		"ICON"=>"main_user_edit",
		"TITLE"=>GetMessage("CLO_STORAGE_FILE_UPLOAD_TITLE"),
	),
);
$tabControl = new CAdminTabControl("tabControl", $aTabs, true, true);
?>
<script>

function show_upload_form()
{
	(new BX.fx({
		start: 0,
		finish: 200,
		time: 0.5,
		type: 'accelerated',
		callback: function(res){
			BX('upload_form', true).style.height = res+'px';
		},
		callback_start: function(){
			BX('upload_form', true).style.height = '0px';
			BX('upload_form', true).style.overflow = 'hidden';
			BX('upload_form', true).style.display = 'block';
		},
		callback_complete: function(){
			BX('upload_form', true).style.height = 'auto';
			BX('upload_form', true).style.overflow = 'auto';
		}
	})).start();
}
function hide_upload_form()
{
	BX('upload_form').style.display='none';
	return;
}
function get_upload_url(additional_args)
{
	var result = 'clouds_file_list.php?'
		+ 'action=chunk_upload'
		+ '&ID=Fnew'
		+ '&lang=<?echo urlencode(LANGUAGE_ID)?>'
		+ '&path=<?echo urlencode($path)?>'
		+ '&path_to_upload=' + BX('path_to_upload').value
		+ '&<?echo bitrix_sessid_get()?>'
		+ '&bucket=<?echo CUtil::JSEscape($obBucket->ID)?>'
	;
	if(additional_args)
	{
		for(x in additional_args)
			result += '&' + x + '=' + additional_args[x];
	}
	return result;
}

function chunk_upload(opt_Chunk, file, opt_startByte)
{
	var data = new ArrayBuffer(opt_Chunk.length);
	var ui8a = new Uint8Array(data, 0);
	for (var i = 0; i < opt_Chunk.length; i++)
		ui8a[i] = (opt_Chunk.charCodeAt(i) & 0xff);
	var bb = new (window.MozBlobBuilder || window.WebKitBlobBuilder || window.BlobBuilder)();
	bb.append(data);

	ShowWaitWindow();

	BX.ajax({
		'method': 'POST',
		'dataType': 'html',
		'url': get_upload_url({
			file_name: file.name,
			file_size: file.size,
			file_type: file.type,
			chunk_start: opt_startByte
		}),
		'data': bb.getBlob(),
		'onsuccess': function(result){
			BX('upload_progress').innerHTML = result;
			var href = BX('stop_button');
			if(!href)
			{
				CloseWaitWindow();
				BX('start_upload_button').enabled = true;
			}
		},
		'preparePost': false
	});
}

function start_upload()
{
	if (!window.File || !window.FileReader || !window.FileList || !window.Blob)
	{
		BX('editform').submit();
		return;
	}

	var files = BX('upload').files;
	if (!files || !files.length)
		return;

	var file = files[0];

	ShowWaitWindow();
	BX('start_upload_button').enabled = false;

	BX.ajax.post(
		get_upload_url(),
		{file_name: file.name, file_size: file.size, file_type: file.type},
		function(result){
			BX('upload_progress').innerHTML = result;
			var href = BX('stop_button');
			if(!href)
			{
				CloseWaitWindow();
				BX('start_upload_button').disabled = false;
			}
		}
	);

}

function readFileChunk(opt_startByte, opt_stopByte)
{
	var files = BX('upload').files;
	if (!files || !files.length)
		return;

	var file = files[0];
	var start = parseInt(opt_startByte) || 0;
	var stop = parseInt(opt_stopByte) || file.size - 1;

	var reader = new FileReader();
	reader.onloadend = function(evt)
	{
		if (evt.target.readyState == FileReader.DONE)
			chunk_upload(evt.target.result, file, start);
	};

	if (file.webkitSlice)
		var blob = file.webkitSlice(start, stop + 1);
	else if (file.mozSlice)
		var blob = file.mozSlice(start, stop + 1);

	reader.readAsBinaryString(blob);
}
</script>
<div id="upload_form" style="display:none;height:200px;">
<div id="upload_progress"></div>
<form method="POST" action="<?echo htmlspecialchars($APPLICATION->GetCurPageParam())?>"  enctype="multipart/form-data" name="editform" id="editform">
<?
$tabControl->Begin();
$tabControl->BeginNextTab();
?>
<tr><td><?echo GetMessage("CLO_STORAGE_FILE_PATH_INPUT")?>:</td><td><input type="text" id="path_to_upload" name="path_to_upload" size="45" value="<?echo htmlspecialchars($path)?>"></td></tr>
<tr><td><?echo GetMessage("CLO_STORAGE_FILE_UPLOAD_INPUT")?>:</td><td><input type="file" id="upload" name="upload"></td></tr>
<?$tabControl->Buttons(false);?>
<input type="hidden" name="action" value="upload">
<input type="hidden" name="ID" value="Fnew">
<?echo bitrix_sessid_post();?>
<input type="hidden" name="lang" value="<?echo LANGUAGE_ID?>">
<input type="button" id="start_upload_button" onclick="start_upload();" value="<?echo GetMessage("CLO_STORAGE_FILE_UPLOAD_BTN")?>">
<input type="button" value="<?echo GetMessage("CLO_STORAGE_FILE_CANCEL_BTN")?>" onclick="hide_upload_form()">
<?
$tabControl->End();
?>
</form>
</div>
<?

endif;

$lAdmin->DisplayList();

require($_SERVER["DOCUMENT_ROOT"]."/bitrix/modules/main/include/epilog_admin.php");
?>