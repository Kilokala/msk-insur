<?
require($_SERVER["DOCUMENT_ROOT"]."/bitrix/header.php");
$APPLICATION->SetTitle("Вакансии");
?><?$APPLICATION->IncludeComponent(
	"rm:jobs",
	"",
	Array(
		"IBLOCK_TYPE" => "content",
		"IBLOCK_ID" => "2",
		"ITEMS_LIMIT" => "100"
	),
false
);?><?require($_SERVER["DOCUMENT_ROOT"]."/bitrix/footer.php");?>