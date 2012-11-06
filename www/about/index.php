<?
require($_SERVER["DOCUMENT_ROOT"]."/bitrix/header.php");
$APPLICATION->SetTitle("О компании");
?>

<div class="bContent">
    <div class="bContent__eLeftCol">
		<?$APPLICATION->IncludeComponent("bitrix:menu", "side", array(
				"ROOT_MENU_TYPE" => "left",
				"MENU_CACHE_TYPE" => "N",
				"MENU_CACHE_TIME" => "3600",
				"MENU_CACHE_USE_GROUPS" => "Y",
				"MENU_CACHE_GET_VARS" => array(
				),
				"MAX_LEVEL" => "1",
				"CHILD_MENU_TYPE" => "left",
				"USE_EXT" => "N",
				"DELAY" => "N",
				"ALLOW_MULTI_SELECT" => "N",
			),
			false
		);?>
		<?$APPLICATION->IncludeComponent(
			"bitrix:main.include",
			"",
			Array(
				"AREA_FILE_SHOW" => "file",
				"PATH" => "/features.php",
				"EDIT_TEMPLATE" => ""
			),
			false
		);?>
    </div><!-- .bContent__eLeftCol -->
    <div class="bContent__eRightCol">
        <div class="bRightColBg">
			<?$APPLICATION->IncludeComponent(
				"bitrix:main.include",
				"",
				Array(
					"AREA_FILE_SHOW" => "file",
					"PATH" => "/about/index_text.php",
					"EDIT_TEMPLATE" => ""
				),
				false
			);?>
        </div><!-- .bRightColBg -->
    </div><!-- .bContent__eRightCol -->
    <div class="bContent__eClear"></div>
</div><!-- .bContent -->

<?require($_SERVER["DOCUMENT_ROOT"]."/bitrix/footer.php");?>