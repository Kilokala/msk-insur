<?
if (!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED !== true) {
	die();
}

?>
<div class="bFeatures">
	<?
	foreach ($arResult['ITEMS'] as $item) {
		$alt = htmlspecialchars($item['NAME']);

		$item['NAME'] = mb_strlen($item['~NAME']) <= 16 ? (
			'<span class="bFeatures__eBottomText">' . $item['NAME'] . '</span>') : $item['NAME'];

		$imgClass = 'bFeatures__eImage__mPosition_center';
		if ($item['DETAIL_PICTURE']['HEIGHT'] > $item['DETAIL_PICTURE']['WIDTH']) {
			$imgClass = 'bFeatures__eImage__mPosition_center_bottom';
			if ($item['DETAIL_PICTURE']['WIDTH'] > 80) {
				$imgClass = 'bFeatures__eImage__mPosition_bottom';
			}
		}

		?>
        <div class="bFeatures__eItem">
            <div class="bFeatures__eTopLine">
                <div class="bFeatures__eText"><?=$item['DETAIL_TEXT']?></div>
                <img src="<?=$item['DETAIL_PICTURE']['SRC']?>"
                     class="bFeatures__eImage <?=$imgClass?>" alt="<?=$alt?>">
            </div>
            <div class="bFeatures__eBottomLine">
				<?=$item['NAME']?>
            </div>
        </div>
		<?
	}
	?>
</div><!-- .bFeatures -->
<?

//debug($arResult);