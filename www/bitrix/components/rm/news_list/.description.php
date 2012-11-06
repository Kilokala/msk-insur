<?
if (!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED!==true) die();

$arComponentDescription = array(
	"NAME" => "Список новостей",
	"DESCRIPTION" => "",
	"ICON" => "/images/icon.gif",
	"SORT" => 10,
	"CACHE_PATH" => "Y",
	"PATH" => array(
		"ID" => "rm",
		"CHILD" => array(
			"ID" => "rm_news",
			"NAME" => "Новости",
		),
	),
	"COMPLEX" => "N",
);

?>