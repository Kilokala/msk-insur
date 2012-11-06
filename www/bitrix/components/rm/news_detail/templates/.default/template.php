<?
if (!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED !== true) {
	die();
}

$item = $arResult['ITEM'];

$timestamp = MakeTimeStamp($item['ACTIVE_FROM']);


?>
<div class="bContent">
    <div class="bContent__eLeftCol">
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
    </div>
    <!-- .bContent__eLeftCol -->
    <div class="bContent__eRightCol bContent__eRightCol__mPosition_left">
        <div class="bRightColBg">
            <div class="bArticleTop">
                <a rel="lightbox" href="<?=$item['DETAIL_PICTURE']['SRC']?>">
				<img src="<?=$item['PREVIEW_PICTURE']['SRC']?>" class="bArticleTop__eImg" alt=""/></a>

                <div class="bArticleTop__eRight">
                    <div class="bArticleTop__eDateTitle">
                        <div class="bArticleTop__eDate">
                            <span class="bArticleTop__eDay"><?=FormatDate('d', $timestamp)?></span>
                            <span class="bArticleTop__eYear"><?=FormatDate('F Y', $timestamp)?></span>
                        </div>
                        <span class="bArticleTop__eNewsText"><?=strtolower($arResult['SECTIONS'][$item['IBLOCK_SECTION_ID']]['NAME'])?></span>
                    </div>
                    <h1 class="bArticleTop__Title"><?=$item['NAME']?></h1>

                    <p class="bArticleTop__Text"><?=$item['PREVIEW_TEXT']?></p>
                </div>
            </div>
            <p class="bTextItem"><?=$item['DETAIL_TEXT']?></p>
        </div>
        <!-- .bRightColBg -->
    </div>
    <!-- .bContent__eRightCol -->
    <div class="bContent__eClear"></div>
</div><!-- .bContent -->
<?

//debug($arResult);