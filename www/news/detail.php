<?
require($_SERVER["DOCUMENT_ROOT"]."/bitrix/header.php");
$APPLICATION->SetTitle("Новость детально");
?><?$APPLICATION->IncludeComponent("rm:news_detail", ".default", array(
		"IBLOCK_TYPE" => "content",
		"IBLOCK_ID" => "1",
		"ITEM_ID" => $_REQUEST['ID']
	),
	false
);?><?require($_SERVER["DOCUMENT_ROOT"]."/bitrix/footer.php");?>