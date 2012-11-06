<?if (!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED !== true) {
	die();
}

/**
 * @var array $arResult
 * @var array $arParams
 */

$count = count($arResult);

echo '<div class="bSideMenu">';

$isFirst = true;
foreach ($arResult as $k => $item) {
	$class = 'bSideMenu__eItem';
	if ($isFirst) {
		$class .= ' bSideMenu__eItem__mPosition_first';
		$isFirst = false;
	}
	if ($item['SELECTED']) {
		$class .= ' bSideMenu__eItem__mState_active';
	}
	if ($k + 1 === $count) {
		$class .= ' bSideMenu__eItem__mPosition_last';
	}
	echo'<div class="' . $class . '"><a href="' . $item['LINK'] . '" class="bSideMenu__eItemLink">' . $item['TEXT']
		. '</a></div>';
}

echo '</div>';