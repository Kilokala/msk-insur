<?
if (!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED!==true) die();

?>
<div class="bPartners">
    <div class="bPartners__eTitle">Наши<br>партнеры</div>
    <div class="bPartnersSliderWrapper">
        <img src="/images/partners_left.gif" class="bPartnersSlider__eArrowLeft" width="17" height="57" alt="">
        <img src="/images/partners_right.gif" class="bPartnersSlider__eArrowRight" width="17" height="57" alt="">
        <div class="bPartnersSlider">
            <div class="bPartnersSlider__eLine">
				<?
				foreach($arResult['ITEMS'] as $item){
					$alt = htmlspecialchars($item['NAME']);
					echo '<img src="'.$item['DETAIL_PICTURE']['SRC'].'" class="bPartnersSlider__eImage" width="55" height="57" alt="'.$alt.'">';
				}
				?>
            </div>
        </div>
    </div>
</div><!-- .bPartners -->
<?

//debug($arResult);
