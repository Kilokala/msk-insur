<?
if (!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED !== true) {
	die();
}

function nm($name, $len=70){
	$name = strip_tags($name);
	if(mb_strlen($name) <= $len){
		return $name;
	}else{
		return mb_substr($name, 0, $len).'...';
	}
}

?>

<div class="bNews">
    <div class="bLatestNews">
        <div class="bLatestNews__eTitle">Актуальные новости</div>
		<?
		$count = count($arResult['ITEMS']);
		foreach ($arResult['ITEMS'] as $k => $item) {
			$class = $k % 2 === 0 ? 'bLatestNews__eItem' : 'bLatestNews__eItem bLatestNews__eItem__mColor_light';
			if ($k + 1 === $count) {
				$class .= ' bLatestNews__eItem__mBorder_round';
			}
			// href=/news/detail.php?ID={$item['ID']}
			?>

            <div class="<?=$class?>">
                <a href="/news/detail.php?ID=<?=$item['ID']?>">
					<?=nm($item['NAME'],55)?>
				</a>
            </div>

			<?
		}
		?>
    </div>
	<?$APPLICATION->IncludeComponent(
		"rm:banner",
		"features_horizontal",
		Array(
			"IBLOCK_TYPE" => "content",
			"IBLOCK_ID" => "6",
			'SECTION_ID' => '5',
			"ITEMS_LIMIT" => "3"
		),
		false
	);?>
</div><!-- .bNews -->

<?

//debug($arResult);