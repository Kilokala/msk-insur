<? if (!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED !== true) {
	die();
}

/**
 * @var CMain $APPLICATION
 */

CPageOption::SetOptionString("main", "nav_page_in_session", "N");

$APPLICATION->AddHeadScript('/js/lightbox.js');
$APPLICATION->SetAdditionalCSS('/css/lightbox.css');

$arParams['IBLOCK_ID'] = (int)$arParams['IBLOCK_ID'];
$arParams['ITEM_ID'] = (int)$arParams['ITEM_ID'];

if ($arParams["IBLOCK_ID"] < 1) {
	ShowError("IBLOCK_ID IS NOT DEFINED");

	return false;
}

$arResult = array(
	'SECTIONS' => array(),
	'ITEM' => false
);

if (!CModule::IncludeModule("iblock")) {
	$this->AbortResultCache();
	ShowError("IBLOCK_MODULE_NOT_INSTALLED");

	return false;
}

if($arParams['ITEM_ID'] <= 0){
	LocalRedirect('/404.php');
}

$rsElement = CIBlockElement::GetByID($arParams['ITEM_ID']);

if ($rsElement->SelectedRowsCount() <= 0) {
	LocalRedirect('/404.php');
}

$obElement = $rsElement->GetNextElement();
$arElement = $obElement->GetFields();
if ($arElement["PREVIEW_PICTURE"]) {
	$arElement["PREVIEW_PICTURE"] = CFile::GetFileArray($arElement["PREVIEW_PICTURE"]);
}
if ($arElement["DETAIL_PICTURE"]) {
	$arElement["DETAIL_PICTURE"] = CFile::GetFileArray($arElement["DETAIL_PICTURE"]);
}
//$arElement["PROPERTIES"] = $obElement->GetProperties();

if((int)$arElement['IBLOCK_ID'] !== (int)$arParams['IBLOCK_ID']){
	LocalRedirect('/404.php');
}

$arFilter = array("IBLOCK_ID" => $arParams["IBLOCK_ID"], "ACTIVE" => "Y");
$rsSection = CIBlockSection::GetList($arSort, $arFilter);
while($arSection = $rsSection->Fetch()){
	$arResult['SECTIONS'][$arSection['ID']] = $arSection;
}

$APPLICATION->SetTitle($arElement['NAME']);

$arResult['ITEM'] = $arElement;

$this->IncludeComponentTemplate();