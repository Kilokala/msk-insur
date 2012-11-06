<?if (!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED !== true) {
	die();
}

/**
 * @var array $arResult
 * @var array $arParams
 */

$items = array();
$lastKey = 0;
foreach ($arResult as $k => $item) {
	if ((int)$item['DEPTH_LEVEL'] === 1) {
		$item['CHILDREN'] = array();
		$items[] = $item;
		$lastKey = count($items) - 1;
	} else {
		$items[$lastKey]['CHILDREN'][] = $item;
	}
}

$count = count($items);

echo '<div class="bMenu"><img src="/images/menu_l.gif" class="bMenu__eLeft" width="3" height="42" alt="">';

foreach ($items as $k => $item) {
	echo'<div class="bMenu__eItem"><a href="' . $item['LINK'] . '" class="bMenu__eItemLink">' . $item['TEXT'] . '</a>';
	if (!empty($item['CHILDREN'])) {
		echo '<div class="bSubMenu">';
		foreach ($item['CHILDREN'] as $children) {
			if ($children['LINK'] === $item['LINK']) {
				continue;
			}
			echo '<a href="' . $children['LINK'] . '" class="bSubMenu__eItem">' . $children['TEXT'] . '</a>';
		}
		echo '</div>';
	}
	echo '</div>';
	if ($k + 1 < $count) {
		echo '<img class="bMenu__eSplitter" src="/images/menu_splitter.png" width="2" height="28">';
	}
}

?>

<div class="bMenu__eSocial">
    <a href="<?=$arParams['URL_FB']?>" target="_blank">
		<img src="/images/fb_grey.png" class="bMenu_eSocialImg" width="14" height="14" alt=""></a>
    <a href="<?=$arParams['URL_VK']?>" target="_blank">
		<img src="/images/vk_grey.png" class="bMenu_eSocialImg" width="14" height="14" alt=""></a>
    <a href="<?=$arParams['URL_TW']?>" target="_blank">
		<img src="/images/twitter_grey.png" class="bMenu_eSocialImg" width="14" height="14" alt=""></a>
</div>

<?

echo '</div>';