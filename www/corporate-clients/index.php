<?
require($_SERVER["DOCUMENT_ROOT"]."/bitrix/header.php");
$APPLICATION->SetTitle("Корпоративным клиентам");
?><?$APPLICATION->IncludeComponent("rm:form_order", ".default", array(
	"IBLOCK_TYPE" => "content",
	"IBLOCK_ID" => "5",
	),
	false
);?> <?require($_SERVER["DOCUMENT_ROOT"]."/bitrix/footer.php");?>