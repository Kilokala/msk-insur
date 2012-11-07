<?
if (!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED !== true) {
	die();
}

$count = count($arResult['ITEMS'])

?>

<div class="bBanner">
    <div class="bSliderControls">
		<?
		$isActive = true;
		for ($i = 0; $i < $count; $i++) {
			$class = 'bSliderControls__eBullet';
			if ($isActive) {
				$isActive = false;
				$class .= ' bSliderControls__eBullet__mState_active';
			}
			echo '<div class="' . $class . '"></div>';
		}
		?>
    </div>
	<?
	foreach ($arResult['ITEMS'] as $item) {
		?>
        <div class="bBanner__eAd">
            <div class="bBanner__eAdText"><?=$item['NAME']?></div>
            <div class="bBanner__eAdText bBanner__eAdText__mFont_big">
				<?=str_replace(
				array('<b>', '</b>'),
				array('<span class="bBanner__eAdText__mFont_bold">', '</span>'),
				$item['DETAIL_TEXT']
			)?>
				<?
				if (!empty($item['CODE'])) {
					echo'<a href="' . $item['CODE'] . '" target="_blank">'
						. '<img src="/images/profound.png" class="bAd__eLink" width="82" height="23" alt=""></a>';
				}
				?>
            </div>
        </div>
		<?
	}
	?>
    <div class="bBanner__eVisibleSlider">
        <div class="bBanner__eLine"><?
			foreach ($arResult['ITEMS'] as $item) {
				echo'<img src="' . $item['DETAIL_PICTURE']['SRC']
					. '" class="bBanner__eImage" width="938" height="300">';
			}
			?></div>
    </div>
</div><!-- .bBanner -->

<?

//debug($arParams);
//debug($arResult);
