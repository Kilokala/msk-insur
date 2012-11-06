<?
require($_SERVER["DOCUMENT_ROOT"]."/bitrix/header.php");
$APPLICATION->SetTitle("Контакты");
?>

<div class="bContent">
    <div class="bContent__eRightCol bContent__eRightCol__mWidth_full">
        <div class="bRightColBg bRightColBg__mTopSpace_disable">
            <h1>Контакты</h1>
            <div class="bContacts">
                <?$APPLICATION->IncludeComponent(
					"bitrix:main.include",
					"",
					Array(
						"AREA_FILE_SHOW" => "file",
						"PATH" => "/contacts/inc.map.php",
						"EDIT_TEMPLATE" => ""
					),
					false
				);?>
				<div class="bAddress">
					<?$APPLICATION->IncludeComponent(
						"bitrix:main.include",
						"",
						Array(
							"AREA_FILE_SHOW" => "file",
							"PATH" => "/contacts/inc.address.php",
							"EDIT_TEMPLATE" => ""
						),
						false
					);?>
                </div>
                <div class="bAddress">

					<?$APPLICATION->IncludeComponent(
						"bitrix:main.include",
						"",
						Array(
							"AREA_FILE_SHOW" => "file",
							"PATH" => "/contacts/inc.contacts.php",
							"EDIT_TEMPLATE" => ""
						),
						false
					);?>
                </div>
            </div>
            <div class="bContent__eClear"></div>
        </div><!-- .bRightColBg -->
    </div><!-- .bContent__eRightCol -->
    <div class="bContent__eClear"></div>
</div><!-- .bContent -->

<?require($_SERVER["DOCUMENT_ROOT"]."/bitrix/footer.php");?>