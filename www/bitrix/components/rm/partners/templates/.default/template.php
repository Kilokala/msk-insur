<?
if (!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED!==true) die();

?>
<div class="bContent">
    <div class="bContent__eRightCol bContent__eRightCol__mWidth_full">
        <div class="bRightColBg bRightColBg__mTopSpace_disable">
			<?
			foreach($arResult['ITEMS'] as $item){
				echo '<a href="'.$item['CODE'].'" target="_blank" class="bPartnersItem" style="background: url('.$item['DETAIL_PICTURE']['SRC'].') 0 0 no-repeat;"></a>';
			}
			?>
            <div class="bContent__eClear"></div>
        </div><!-- .bRightColBg -->
    </div><!-- .bContent__eRightCol -->
    <div class="bContent__eClear"></div>
</div><!-- .bContent -->
<?

//debug($arResult);
