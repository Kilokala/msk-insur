<?
require($_SERVER["DOCUMENT_ROOT"]."/bitrix/header.php");
$APPLICATION->SetTitle("Акции");
?><?$APPLICATION->IncludeComponent(
	"rm:shares",
	"",
	Array(
		"IBLOCK_TYPE" => "content",
		"IBLOCK_ID" => "3",
		"ITEMS_LIMIT" => "10"
	),
false
);?> <?require($_SERVER["DOCUMENT_ROOT"]."/bitrix/footer.php");?>