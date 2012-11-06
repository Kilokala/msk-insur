<?
if (!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED!==true) die();

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
            <h1>Вакансии</h1>
			<?
			foreach($arResult['ITEMS'] as $item){
				?>
                <div class="bVacancy">
                    <div class="bVacancy__eTitle" id="job-<?=$item['ID']?>">
                        <span class="bVacancy__eTitleText"><?=$item['NAME']?></span>
                    </div>
                    <div class="bVacancy__eTextWrapper">
                        <div class="bVacancy__eText">
                            <p class="bTextItem"><?=$item['DETAIL_TEXT']?></p>
                        </div><!-- .bVacancy__eText -->
                        <div class="bLines">
                            <div class="bLines__eDarkLine"></div>
                            <div class="bLines__eLightLine"></div>
                        </div>
                    </div><!-- .bVacancy__eTextWrapper -->
                </div><!-- .bVacancy -->
				<?
			}
			?>
        </div><!-- .bRightColBg -->

    </div><!-- .bContent__eRightCol -->
    <div class="bContent__eClear"></div>
</div><!-- .bContent -->

<?

if(isset($_GET['ID'])){
	$ID = (int)$_GET['ID'];
	?>
	<script type="text/javascript">
        jQuery(function($){
            $('#job-<?=$ID?>').trigger('click');
		});
	</script>
	<?
}

//debug($arResult);