<?if (!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED !== true) {
	die();
}

/**
 * @var array $arResult
 * @var array $arParams
 */

$count = count($arResult);

?>

<div class="bFooterLinks__eSocial">
    <span class="bFooterLinks__eSocialText">Социальные сети</span>
    <a href="<?=$arParams['URL_FB']?>" class="bFooterLinks__eSocialLink">
		<img src="/images/facebook.png" class="bFooterLinks__eSocialImage" width="16" height="16" alt=""></a>
    <a href="<?=$arParams['URL_VK']?>" class="bFooterLinks__eSocialLink">
		<img src="/images/vk.png" class="bFooterLinks__eSocialImage" width="16" height="16" alt=""></a>
    <a href="<?=$arParams['URL_TW']?>" class="bFooterLinks__eSocialLink">
		<img src="/images/twitter.png" class="bFooterLinks__eSocialImage" width="16" height="16" alt=""></a>
</div>

<?

echo '<div class="bFooterLinks__eMenu">';

foreach ($arResult as $k => $item) {
	echo'<a href="' . $item['LINK'] . '" class="bFooterLinks__eMenuLink">' . $item['TEXT'] . '</a>';
}

echo '</div>';