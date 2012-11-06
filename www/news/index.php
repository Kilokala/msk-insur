<?
require($_SERVER["DOCUMENT_ROOT"]."/bitrix/header.php");
$APPLICATION->SetTitle("Новости");
?><?$APPLICATION->IncludeComponent("rm:news_list", ".default", array(
	"IBLOCK_TYPE" => "content",
	"IBLOCK_ID" => "1",
	"ITEMS_LIMIT" => "10"
	),
	false
);?><?require($_SERVER["DOCUMENT_ROOT"]."/bitrix/footer.php");?>