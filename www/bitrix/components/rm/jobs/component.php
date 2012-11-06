<? if (!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED !== true) {
	die();
}

CPageOption::SetOptionString("main", "nav_page_in_session", "N");

$arParams['IBLOCK_ID'] = (int)$arParams['IBLOCK_ID'];

if ($arParams["IBLOCK_ID"] < 1) {
	ShowError("IBLOCK_ID IS NOT DEFINED");

	return false;
}

if (!CModule::IncludeModule("iblock")) {
	$this->AbortResultCache();
	ShowError("IBLOCK_MODULE_NOT_INSTALLED");

	return false;
}

$arSort = array("SORT" => "ASC", "DATE_ACTIVE_FROM" => "DESC", "ID" => "DESC");
$arFilter = array("IBLOCK_ID" => $arParams["IBLOCK_ID"], "ACTIVE" => "Y", "ACTIVE_DATE" => "Y");

$rsElement = CIBlockElement::GetList($arSort, $arFilter);

while ($obElement = $rsElement->GetNextElement()) {

	$arElement = $obElement->GetFields();
	if ($arElement["PREVIEW_PICTURE"]) {
		$arElement["PREVIEW_PICTURE"] = CFile::GetFileArray($arElement["PREVIEW_PICTURE"]);
	}
	//$arElement["PROPERTIES"] = $obElement->GetProperties();

	$arResult["ITEMS"][] = $arElement;
}

$this->IncludeComponentTemplate();
