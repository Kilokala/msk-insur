<? if(!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED!==true)die();

CPageOption::SetOptionString("main", "nav_page_in_session", "N");

$arParams['ANCHOR'] = '#newsList';
$arParams['SECTION'] = (int)$_GET['SECTION'];
$arParams['IBLOCK_ID'] = (int)$arParams['IBLOCK_ID'];
$arParams['ITEMS_LIMIT'] = (int)$arParams['ITEMS_LIMIT'];

if($arParams['IBLOCK_ID'] < 1) {
	ShowError('IBLOCK_ID IS NOT DEFINED');
	return false;
}

if($arParams['ITEMS_LIMIT'] <= 0) {
	$arParams['ITEMS_LIMIT'] = 10;
}

$arResult = array(
		'SECTIONS' => array(
				array(
						'ID' => 0,
						'NAME' => 'Все новости'
				)
		),
		'ITEMS' => array(),
		'NAV_STRING' => false,
);

$arNavParams = array();

if ($arParams["ITEMS_LIMIT"] > 0) {
	$arNavParams['nPageSize'] = $arParams['ITEMS_LIMIT'];
}

$arNavigation = CDBResult::GetNavParams($arNavParams);

if(!CModule::IncludeModule("iblock")) {
	$this->AbortResultCache();
	ShowError("IBLOCK_MODULE_NOT_INSTALLED");
	return false;
}

$arSort= array("SORT" => "ASC", "DATE_ACTIVE_FROM" => "DESC", "ID" => "DESC");
$arFilter = array("IBLOCK_ID" => $arParams["IBLOCK_ID"], "ACTIVE" => "Y");

$rsSection = CIBlockSection::GetList($arSort, $arFilter);
while($arSection = $rsSection->Fetch()){
	$arResult['SECTIONS'][] = $arSection;
}

if($arParams['SECTION'] > 0){
	$arFilter['SECTION_ID'] = $arParams['SECTION'];
}

$rsElement = CIBlockElement::GetList($arSort, $arFilter, false, $arNavParams);

while($obElement = $rsElement->GetNextElement()) {

	$arElement = $obElement->GetFields();
	if ($arElement['PREVIEW_PICTURE']) {
		$arElement['PREVIEW_PICTURE'] = CFile::GetFileArray($arElement['PREVIEW_PICTURE']);
	}
	//$arElement["PROPERTIES"] = $obElement->GetProperties();

	$arResult['ITEMS'][] = $arElement;
}

$rsElement->add_anchor = $arParams['ANCHOR'];
$rsElement->nPageWindow = 5;
$arResult['NAV_STRING'] = $rsElement->GetPageNavStringEx($navComponentObject, '');

$this->IncludeComponentTemplate();