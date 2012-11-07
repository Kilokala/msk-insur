<? if (!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED !== true) {
	die();
}

CPageOption::SetOptionString("main", "nav_page_in_session", "N");

$arParams["SECTION_ID"] = (int)$arParams["SECTION_ID"];
$arParams["IBLOCK_ID"] = (int)$arParams["IBLOCK_ID"];
$arParams["ITEMS_LIMIT"] = (int)$arParams["ITEMS_LIMIT"];

if ($arParams["IBLOCK_ID"] < 1) {
	ShowError("IBLOCK_ID IS NOT DEFINED");

	return false;
}

if ($arParams["ITEMS_LIMIT"] <= 0) {
	$arParams["ITEMS_LIMIT"] = 10;
}

$arNavParams = array();

if ($arParams["ITEMS_LIMIT"] > 0) {
	$arNavParams = array(
		"nPageSize" => $arParams["ITEMS_LIMIT"],
	);
}

$arNavigation = CDBResult::GetNavParams($arNavParams);

if (!CModule::IncludeModule("iblock")) {
	$this->AbortResultCache();
	ShowError("IBLOCK_MODULE_NOT_INSTALLED");

	return false;
}

$arSort = array("SORT" => "ASC", "DATE_ACTIVE_FROM" => "DESC", "ID" => "DESC");
$arFilter = array("IBLOCK_ID" => $arParams["IBLOCK_ID"], "ACTIVE" => "Y", "ACTIVE_DATE" => "Y");
if($arParams["SECTION_ID"] > 0){
	$arFilter['SECTION_ID'] = $arParams["SECTION_ID"];
}

$rsElement = CIBlockElement::GetList($arSort, $arFilter, false, $arNavParams);

while ($obElement = $rsElement->GetNextElement()) {

	$arElement = $obElement->GetFields();
	if ($arElement["DETAIL_PICTURE"]) {
		$arElement["DETAIL_PICTURE"] = CFile::GetFileArray($arElement["DETAIL_PICTURE"]);
	}
	//$arElement["PROPERTIES"] = $obElement->GetProperties();

	$arResult["ITEMS"][] = $arElement;
}

$this->IncludeComponentTemplate();
