<?
if(!$USER->IsAdmin())
	return;

IncludeModuleLangFile($_SERVER["DOCUMENT_ROOT"]."/bitrix/modules/main/options.php");
IncludeModuleLangFile(__FILE__);

$arAllOptions = Array(
	Array("use_htmledit", GetMessage("IBLOCK_USE_HTMLEDIT"), "N", Array("checkbox", "Y")),
	Array("show_xml_id", GetMessage("IBLOCK_SHOW_LOADING_CODE"), "N", Array("checkbox", "Y")),
	Array("path2rss", GetMessage("IBLOCK_PATH2RSS"), "/upload/", Array("text", 30)),
	Array("combined_list_mode", GetMessage("IBLOCK_COMBINED_LIST_MODE"), "N", Array("checkbox", "Y")),
	Array("iblock_menu_max_sections", GetMessage("IBLOCK_MENU_MAX_SECTIONS"), "50", Array("text", 5)),
	Array("event_log_iblock", GetMessage("IBLOCK_EVENT_LOG"), "Y", Array("checkbox", "Y")),
);
$aTabs = array(
	array("DIV" => "edit1", "TAB" => GetMessage("MAIN_TAB_SET"), "ICON" => "ib_settings", "TITLE" => GetMessage("MAIN_TAB_TITLE_SET")),
);
$tabControl = new CAdminTabControl("tabControl", $aTabs);

if($REQUEST_METHOD=="POST" && strlen($Update.$Apply.$RestoreDefaults)>0 && check_bitrix_sessid())
{
	if(strlen($RestoreDefaults)>0)
	{
		COption::RemoveOption("iblock");
	}
	else
	{
		foreach($arAllOptions as $arOption)
		{
			$name=$arOption[0];
			$val=$_REQUEST[$name];
			if($arOption[2][0]=="checkbox" && $val!="Y")
				$val="N";
			COption::SetOptionString("iblock", $name, $val, $arOption[1]);
		}
	}
	if(strlen($Update)>0 && strlen($_REQUEST["back_url_settings"])>0)
		LocalRedirect($_REQUEST["back_url_settings"]);
	else
		LocalRedirect($APPLICATION->GetCurPage()."?mid=".urlencode($mid)."&lang=".urlencode(LANGUAGE_ID)."&back_url_settings=".urlencode($_REQUEST["back_url_settings"])."&".$tabControl->ActiveTabParam());
}


$tabControl->Begin();
?>
<form method="post" action="<?echo $APPLICATION->GetCurPage()?>?mid=<?=urlencode($mid)?>&amp;lang=<?echo LANGUAGE_ID?>">
<?$tabControl->BeginNextTab();?>
	<?
	foreach($arAllOptions as $arOption):
		$val = COption::GetOptionString("iblock", $arOption[0], $arOption[2]);
		$type = $arOption[3];
	?>
	<tr>
		<td valign="top" width="50%"><?
			if($type[0]=="checkbox")
				echo "<label for=\"".htmlspecialchars($arOption[0])."\">".$arOption[1]."</label>";
			else
				echo $arOption[1];?>:</td>
		<td valign="top" width="50%">
			<?if($type[0]=="checkbox"):?>
				<input type="checkbox" id="<?echo htmlspecialchars($arOption[0])?>" name="<?echo htmlspecialchars($arOption[0])?>" value="Y"<?if($val=="Y")echo" checked";?>>
			<?elseif($type[0]=="text"):?>
				<input type="text" size="<?echo $type[1]?>" maxlength="255" value="<?echo htmlspecialchars($val)?>" name="<?echo htmlspecialchars($arOption[0])?>">
			<?elseif($type[0]=="textarea"):?>
				<textarea rows="<?echo $type[1]?>" cols="<?echo $type[2]?>" name="<?echo htmlspecialchars($arOption[0])?>"><?echo htmlspecialchars($val)?></textarea>
			<?endif?>
		</td>
	</tr>
	<?endforeach?>
<?$tabControl->Buttons();?>
	<input type="submit" name="Update" value="<?=GetMessage("MAIN_SAVE")?>" title="<?=GetMessage("MAIN_OPT_SAVE_TITLE")?>">
	<input type="submit" name="Apply" value="<?=GetMessage("MAIN_OPT_APPLY")?>" title="<?=GetMessage("MAIN_OPT_APPLY_TITLE")?>">
	<?if(strlen($_REQUEST["back_url_settings"])>0):?>
		<input type="button" name="Cancel" value="<?=GetMessage("MAIN_OPT_CANCEL")?>" title="<?=GetMessage("MAIN_OPT_CANCEL_TITLE")?>" onclick="window.location='<?echo htmlspecialchars(CUtil::addslashes($_REQUEST["back_url_settings"]))?>'">
		<input type="hidden" name="back_url_settings" value="<?=htmlspecialchars($_REQUEST["back_url_settings"])?>">
	<?endif?>
	<input type="submit" name="RestoreDefaults" title="<?echo GetMessage("MAIN_HINT_RESTORE_DEFAULTS")?>" OnClick="return confirm('<?echo AddSlashes(GetMessage("MAIN_HINT_RESTORE_DEFAULTS_WARNING"))?>')" value="<?echo GetMessage("MAIN_RESTORE_DEFAULTS")?>">
	<?=bitrix_sessid_post();?>
<?$tabControl->End();?>
</form>
