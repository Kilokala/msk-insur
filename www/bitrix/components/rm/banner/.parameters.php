<?
if (!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED !== true) {
	die();
}

if (!CModule::IncludeModule("iblock")) {
	return;
}

$arTypesEx = CIBlockParameters::GetIBlockTypes(Array("-" => " "));

$arIBlocks = Array();
$db_iblock = CIBlock::GetList(
	Array("SORT" => "ASC"),
	Array(
		"SITE_ID" => $_REQUEST["site"],
		"TYPE" => ($arCurrentValues["IBLOCK_TYPE"] != "-" ? $arCurrentValues["IBLOCK_TYPE"] : "")
	)
);
while ($arRes = $db_iblock->Fetch()) {
	$arIBlocks[$arRes["ID"]] = $arRes["NAME"];
}

$arSections = Array();
$db_sections = CIBlockSection::GetList(
	Array("SORT" => "ASC"),
	Array(
		"SITE_ID" => $_REQUEST["site"],
		"IBLOCK_ID" => (!empty($arCurrentValues["IBLOCK_ID"]) ? $arCurrentValues["IBLOCK_ID"] : "")
	)
);
while ($arRes = $db_sections->Fetch()) {
	$arSections[$arRes["ID"]] = $arRes["NAME"];
}

$arComponentParameters = array(
	"GROUPS" => array(),
	"PARAMETERS" => array(

		"IBLOCK_TYPE" => Array(
			"PARENT" => "BASE",
			"NAME" => "Тип инфоблока",
			"TYPE" => "LIST",
			"VALUES" => $arTypesEx,
			"DEFAULT" => "news",
			"REFRESH" => "Y",
		),
		"IBLOCK_ID" => Array(
			"PARENT" => "BASE",
			"NAME" => "Инфоблок",
			"TYPE" => "LIST",
			"VALUES" => $arIBlocks,
			"DEFAULT" => '={$_REQUEST["ID"]}',
			"ADDITIONAL_VALUES" => "Y",
			"REFRESH" => "Y",
		),
		"SECTION_ID" => Array(
			"PARENT" => "BASE",
			"NAME" => "Площадка",
			"TYPE" => "LIST",
			"VALUES" => $arSections,
			"DEFAULT" => '={$_REQUEST["SECTION_ID"]}',
		),
		"ITEMS_LIMIT" => Array(
			"PARENT" => "BASE",
			"NAME" => "Количество баннеров",
			"TYPE" => "STRING",
			"DEFAULT" => "10",
		),

	),
);
?>