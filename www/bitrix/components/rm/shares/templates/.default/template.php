<?
if (!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED!==true) die();

?>

<div class="bContent">
    <div class="bContent__eRightCol bContent__eRightCol__mWidth_full">
        <div class="bRightColBg">
            <h1>Акции</h1>
			<?
			foreach($arResult['ITEMS'] as $item){
				$alt = htmlspecialchars($item['NAME']);
				?>
                <div class="bLines bLines__mSideSpace_disable">
                    <div class="bLines__eDarkLine"></div>
                    <div class="bLines__eLightLine"></div>
                </div>
                <div class="bShareItem">
                    <div class="bShareItem__eLeft">
                        <img src="<?=$item['DETAIL_PICTURE']['SRC']?>" class="bShareItem__eImage" alt="<?=$alt?>" />
                    </div>
                    <div class="bShareItem__eRight">
                        <p class="bShareItem__eShareTitle">
                            <?=$item['NAME']?>
                        </p>
                        <p class="bShareItem__eShareText">
							<?=$item['DETAIL_TEXT']?>
                        </p>
                    </div>
                    <div class="bNewsItem__eText"></div>
                </div><!-- .bNewsItem -->
				<?
			}
			?>
        </div><!-- .bRightColBg -->
        <?=$arResult['NAV_STRING']?>
    </div><!-- .bContent__eRightCol -->
    <div class="bContent__eClear"></div>
</div><!-- .bContent -->

<?

//debug($arResult);

?>