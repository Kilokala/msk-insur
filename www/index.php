<?
require($_SERVER['DOCUMENT_ROOT'].'/bitrix/header.php');
$APPLICATION->SetTitle("Главная");
$APPLICATION->SetPageProperty("NOT_SHOW_NAV_CHAIN", "Y");
?> <?$APPLICATION->IncludeComponent(
	"rm:form_order",
	"main",
	Array(
		"IBLOCK_TYPE" => "content",
		"IBLOCK_ID" => "5"
	)
);?><?$APPLICATION->IncludeComponent(
	"rm:partners",
	"main",
	Array(
		"IBLOCK_TYPE" => "content",
		"IBLOCK_ID" => "4"
	)
);?><?$APPLICATION->IncludeComponent("rm:news_list", "main", array(
	"IBLOCK_TYPE" => "content",
	"IBLOCK_ID" => "1",
	"ITEMS_LIMIT" => "3"
	),
	false
);?> <?
require($_SERVER['DOCUMENT_ROOT'].'/bitrix/footer.php');
?>