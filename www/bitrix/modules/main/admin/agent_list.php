<?php
##############################################
# Bitrix Site Manager                        #
# Copyright (c) 2002-2007 Bitrix             #
# http://www.bitrixsoft.com                  #
# mailto:admin@bitrixsoft.com                #
##############################################

require_once($_SERVER["DOCUMENT_ROOT"]."/bitrix/modules/main/include/prolog_admin_before.php");
require_once($_SERVER["DOCUMENT_ROOT"].BX_ROOT."/modules/main/prolog.php");
define("HELP_FILE", "utilities/agent_list.php");

if(!$USER->CanDoOperation('view_other_settings'))
	$APPLICATION->AuthForm(GetMessage("ACCESS_DENIED"));

$isAdmin = $USER->CanDoOperation('edit_php');

IncludeModuleLangFile(__FILE__);

$sTableID = "tbl_agent_list";
$oSort = new CAdminSorting($sTableID, "SORT", "asc");
$lAdmin = new CAdminList($sTableID, $oSort);

$arFilterFields = Array(
	"find",
	"find_type",
	"find_id",
	"find_active",
	"find_module_id",
	"find_is_period",
	"find_user_id",
	"find_name",
	"find_last_exec",
	"find_next_exec",
	"find_is_period"
);
function CheckFilter($FilterArr) // �������� ��������� �����
{
	foreach($FilterArr as $f)
		global $$f;

	$str = "";
	if(strlen(trim($find_last_exec))>0)
	{
		$date_1_ok = false;
		$date1_stm = MkDateTime(FmtDate($find_last_exec,"D.M.Y"),"d.m.Y");
		if (!$date1_stm && strlen(trim($find_last_exec))>0)
			$str.= GetMessage("MAIN_AGENT_WRONG_LAST_EXEC")."<br>";
		else $date_1_ok = true;
	}

	if(strlen(trim($find_next_exec))>0)
	{
		$date_1_ok = false;
		$date1_stm = MkDateTime(FmtDate($find_next_exec,"D.M.Y"),"d.m.Y");
		if (!$date1_stm && strlen(trim($find_next_exec))>0)
			$str.= GetMessage("MAIN_AGENT_WRONG_NEXT_EXEC")."<br>";
		else $date_1_ok = true;
	}

	if(strlen($str)>0)
	{
		global $lAdmin;
		$lAdmin->AddFilterError($str);
		return false;
	}

	return true;
}


$arFilter = Array();
$lAdmin->InitFilter($arFilterFields);
InitSorting();

if(CheckFilter($arFilterFields))
{
	$arFilter = Array(
		"ID"		=> ($find != '' && $find_type == "id" ? $find : $find_id),
		"MODULE_ID"	=> ($find != '' && $find_type == "module_id" ? $find : $find_module_id),
		"USER_ID"	=> ($find != '' && $find_type == "user_id" ? $find : $find_user_id),
		"NAME"	=> ($find != '' && $find_type == "name" ? $find : $find_name),
		"ACTIVE"	=> $find_active,
		"IS_PERIOD"	=> $find_is_period,
		"LAST_EXEC"	=> $find_last_exec,
		"NEXT_EXEC"	=> $find_next_exec,
		"IS_PERIOD"	=> $find_is_period
		);
}

if($lAdmin->EditAction() && $isAdmin)
{
	foreach($FIELDS as $ID=>$arFields)
	{
		$DB->StartTransaction();
		$ID = IntVal($ID);

		if(!$lAdmin->IsUpdated($ID))
			continue;

		$APPLICATION->ResetException();
		if(!CAgent::Update($ID, $arFields))
		{
			$e = $APPLICATION->GetException();
			$lAdmin->AddUpdateError(GetMessage("SAVE_ERROR").$ID.": ".$e->GetString(), $ID);
			$DB->Rollback();
		}
		$DB->Commit();
	}
}


if(($arID = $lAdmin->GroupAction()) && $isAdmin)
{
	if($_REQUEST['action_target']=='selected')
	{
		$arID = Array();
		$rsData = CAgent::GetList(array($by => $order), $arFilter);
		while($arRes = $rsData->Fetch())
			$arID[] = $arRes['ID'];
	}

	foreach ($arID as $ID)
	{
		$ID = IntVal($ID);
		if($ID<=0)
			continue;

		switch ($_REQUEST['action'])
		{
			case "delete":
				@set_time_limit(0);
				if(!CAgent::Delete($ID))
					$lAdmin->AddGroupError(GetMessage("DELETE_ERROR"), $ID);
			break;
			case "activate":
				CAgent::Update($ID, array("ACTIVE" => "Y"));
			break;
			case "deactivate":
				CAgent::Update($ID, array("ACTIVE" => "N"));
			break;
		}
	}
}


$agentList = CAgent::GetList(array($by => $order), $arFilter);
$rsData = new CAdminResult($agentList, $sTableID);
$rsData->NavStart(20);
$lAdmin->NavText($rsData->GetNavPrint(GetMessage("MAIN_AGENT_LIST_PAGE")));
$lAdmin->AddHeaders(array(
	array("id"=>"ID", "content"=>GetMessage("MAIN_AGENT_ID"), "sort"=>"ID", "default"=>true),
	array("id"=>"MODULE_ID","content"=>GetMessage("MAIN_AGENT_MODULE_ID"), "sort"=>"MODULE_ID", "default"=>true),
	array("id"=>"USER_ID", "content"=>GetMessage("MAIN_AGENT_USER_ID"), "sort"=>"USER_ID", "default"=>true),
	array("id"=>"SORT", "content"=>GetMessage("MAIN_AGENT_SORT"), "sort"=>"SORT"),
	array("id"=>"NAME", "content"=>GetMessage("MAIN_AGENT_NAME"), "sort"=>"NAME", "default"=>true),
	array("id"=>"ACTIVE", "content"=>GetMessage("MAIN_AGENT_ACTIVE"), "sort"=>"ACTIVE", "default"=>true),
	array("id"=>"LAST_EXEC", "content"=>GetMessage("MAIN_AGENT_LAST_EXEC"), "sort"=>"LAST_EXEC", "default"=>true),
	array("id"=>"NEXT_EXEC", "content"=>GetMessage("MAIN_AGENT_NEXT_EXEC"), "sort"=>"NEXT_EXEC", "default"=>true),
	array("id"=>"AGENT_INTERVAL", "content"=>GetMessage("MAIN_AGENT_INTERVAL"), "sort"=>"AGENT_INTERVAL", "default"=>true),
	array("id"=>"IS_PERIOD", "content"=>GetMessage("MAIN_AGENT_PERIOD"), "sort"=>"IS_PERIOD")
));
while($db_res = $rsData->NavNext(true, "a_"))
{
	$row =& $lAdmin->AddRow($a_ID,$db_res);
	$row->AddField("ID", $a_ID);
	$row->AddField("MODULE_ID",$a_MODULE_ID);
	$row->AddField("USER_ID", ($a_USER_ID > 0 ) ? "<a href=\"/bitrix/admin/user_edit.php?ID=".$a_USER_ID."&lang=".LANG."\">[".$a_USER_ID."] ".$a_USER_NAME." ".$a_LAST_NAME." (".$a_LOGIN.")</a>" : GetMessage("MAIN_AGENT_SYSTEM_USER"));
	$row->AddInputField("SORT");
	$row->AddInputField("NAME");
	$row->AddCheckField("ACTIVE");
	$row->AddField("LAST_EXEC", $a_LAST_EXEC);
	$row->AddField("NEXT_EXEC", $a_NEXT_EXEC);
	$row->AddInputField("AGENT_INTERVAL");
	$row->AddCheckField("IS_PERIOD", ($a_IS_PERIOD == "Y") ? GetMessage("MAIN_AGENT_PERIOD_YES") : GetMessage("MAIN_AGENT_PERIOD_NO"));

	$arActions = array();
	$arActions[] = array(
		"ICON" => "edit",
		"TEXT" => GetMessage("MAIN_AGENT_EDIT"),
		"ACTION" => $lAdmin->ActionRedirect("agent_edit.php?ID=".$a_ID),
		"DEFAULT" => true
		);

	$arActions[] = array(
		"ICON" => "",
		"TEXT" => GetMessage("MAIN_AGENT_ACTIVATE"),
		"ACTION" => $lAdmin->ActionDoGroup($a_ID, "activate"),
		);
	$arActions[] = array(
		"ICON" => "",
		"TEXT" => GetMessage("MAIN_AGENT_DEACTIVATE"),
		"ACTION" => $lAdmin->ActionDoGroup($a_ID, "deactivate"),
		);

	$arActions[] = array("SEPARATOR" => true);
	$arActions[] = array(
		"ICON" => "delete",
		"TEXT" => GetMessage("MAIN_AGENT_DELETE"),
		"ACTION" => "if(confirm('".GetMessage('MAIN_AGENT_ALERT_DELETE')."')) ".$lAdmin->ActionDoGroup($a_ID, "delete")
	);

	$row->AddActions($arActions);

}
// "������" ������
$lAdmin->AddFooter(
array(
	array(
		"title" => GetMessage("MAIN_ADMIN_LIST_SELECTED"),
		"value" => $rsData->SelectedRowsCount()
	),
	array(
		"counter" => true,
		"title" => GetMessage("MAIN_ADMIN_LIST_CHECKED"),
		"value" => "0"
		),
	)
);

$lAdmin->AddGroupActionTable(
	array(
		"delete" => GetMessage("MAIN_ADMIN_LIST_DELETE"),
		"activate"=>GetMessage("MAIN_AGENT_ACTIVATE"),
		"deactivate"=>GetMessage("MAIN_AGENT_DEACTIVATE")
	)
);
$aContext = array(
	array(
		"TEXT"	=> GetMessage("MAIN_AGENT_ADD_AGENT"),
		"LINK"	=> "agent_edit.php?lang=".LANG,
		"TITLE"	=> GetMessage("MAIN_AGENT_ADD_AGENT_TITLE"),
		"ICON"	=> "btn_new"
	),
);
$lAdmin->AddAdminContextMenu($aContext);

$APPLICATION->SetTitle(GetMessage("MAIN_AGENT_PAGE_TITLE"));
$lAdmin->CheckListMode();

require($_SERVER["DOCUMENT_ROOT"].BX_ROOT."/modules/main/include/prolog_admin_after.php");
?>
<form name="find_form" method="GET" action="<?echo $APPLICATION->GetCurPage()?>?">
<input type="hidden" name="lang" value="<?echo LANG?>">
<?
$oFilter = new CAdminFilter(
	$sTableID."_filter",
	array(
		GetMessage("MAIN_AGENT_FLT_ID"),
		GetMessage("MAIN_AGENT_FLT_MODULE_ID"),
		GetMessage("MAIN_AGENT_FLT_USER_ID"),
		GetMessage("MAIN_AGENT_FLT_NAME"),
		GetMessage("MAIN_AGENT_FLT_ACTIVE"),
		GetMessage("MAIN_AGENT_FLT_LAST_EXEC"),
		GetMessage("MAIN_AGENT_FLT_NEXT_EXEC"),
		GetMessage("MAIN_AGENT_FLT_IS_PERIOD")
	)
);

$oFilter->Begin();
?>
<tr>
	<td><b><?=GetMessage("MAIN_AGENT_FLT_SEARCH")?></b></td>
	<td nowrap>
		<input type="text" size="25" name="find" value="<?echo htmlspecialcharsbx($find)?>" title="<?=GetMessage("MAIN_AGENT_FLT_SEARCH_TITLE")?>">
		<select name="find_type">
			<option value="id"<?if($find_type=="id") echo " selected"?>><?=GetMessage("MAIN_AGENT_FLT_ID")?></option>
			<option value="module_id"<?if($find_type=="module_id") echo " selected"?>><?=GetMessage("MAIN_AGENT_FLT_MODULE_ID")?></option>
			<option value="user_id"<?if($find_type=="user_id") echo " selected"?>><?=GetMessage("MAIN_AGENT_FLT_USER_ID")?></option>
			<option value="name"<?if($find_type=="name") echo " selected"?>><?=GetMessage("MAIN_AGENT_FLT_NAME")?></option>
		</select>
	</td>
</tr>
<tr>
	<td><?echo GetMessage("MAIN_AGENT_FLT_ID")?></td>
	<td><input type="text" name="find_id" size="47" value="<?echo htmlspecialcharsbx($find_id)?>"></td>
</tr>
<tr>
	<td><?echo GetMessage("MAIN_AGENT_FLT_MODULE_ID")?></td>
	<td><input type="text" name="find_module_id" size="47" value="<?echo htmlspecialcharsbx($find_module_id)?>"></td>
</tr>
<tr>
	<td><?echo GetMessage("MAIN_AGENT_FLT_USER_ID")?></td>
	<td><input type="text" name="find_user_id" size="47" value="<?echo htmlspecialcharsbx($find_user_id)?>"></td>
</tr>
<tr>
	<td><?echo GetMessage("MAIN_AGENT_FLT_NAME")?></td>
	<td><input type="text" name="find_name" size="47" value="<?echo htmlspecialcharsbx($find_name)?>"></td>
</tr>
<tr>
	<td><?echo GetMessage("MAIN_AGENT_FLT_ACTIVE")?></td>
	<td><?
		$arr = array("reference"=>array(GetMessage("MAIN_YES"), GetMessage("MAIN_NO")), "reference_id"=>array("Y","N"));
		echo SelectBoxFromArray("find_active", $arr, htmlspecialcharsbx($find_active), GetMessage('MAIN_ALL'));
		?>
	</td>
</tr>
<tr>
	<td><?echo GetMessage("MAIN_AGENT_FLT_LAST_EXEC")." (".CLang::GetDateFormat("SHORT")."):"?></td>
	<td><?echo CalendarDate("find_last_exec", htmlspecialcharsbx($find_last_exec), "find_form")?></td>
</tr>
<tr>
	<td><?echo GetMessage("MAIN_AGENT_FLT_NEXT_EXEC")." (".CLang::GetDateFormat("SHORT")."):"?></td>
	<td><?echo CalendarDate("find_next_exec", htmlspecialcharsbx($find_next_exec), "find_form")?></td>
</tr>
<tr>
	<td><?echo GetMessage("MAIN_AGENT_FLT_IS_PERIOD")?></td>
	<td><?
		$arr = array("reference"=>array(GetMessage("MAIN_YES"), GetMessage("MAIN_NO")), "reference_id"=>array("Y","N"));
		echo SelectBoxFromArray("find_is_period", $arr, htmlspecialcharsbx($find_is_period), GetMessage('MAIN_ALL'));
		?>
	</td>
</tr>

<?
$oFilter->Buttons(array("table_id"=>$sTableID, "url"=>$APPLICATION->GetCurPage(), "form"=>"find_form"));
$oFilter->End();
?>
</form>
<?

$lAdmin->DisplayList();

require($_SERVER["DOCUMENT_ROOT"].BX_ROOT."/modules/main/include/epilog_admin.php");
?>

