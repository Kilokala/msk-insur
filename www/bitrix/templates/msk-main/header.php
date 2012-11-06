<?
if(!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED!==true)die();

/**
 * @var CMain $APPLICATION
 */

IncludeTemplateLangFile(__FILE__);
?><!DOCTYPE html>
<html>
<head>
	<script src="http://code.jquery.com/jquery-1.8.2.min.js"></script>
	<script src="/js/insurance.js"></script>
	<script src="/js/jquery.selectBox.js"></script>
	<script src="/js/jquery.customForm.js"></script>
	
	<?$APPLICATION->ShowHead();?>
	<meta name="SKYPE_TOOLBAR" content="SKYPE_TOOLBAR_PARSER_COMPATIBLE" />

	<title><?$APPLICATION->ShowTitle()?> / <?=COption::GetOptionString('main', 'site_name')?></title>

	<link href="/favicon.ico" type="image/x-icon" rel="icon" />
	<link rel="stylesheet" type="text/css" href="/css/select.box.css" />

	<!--[if gte IE 9]>
		<style type="text/css">
			.gradient {
				filter: none;
			}
		</style>
	<![endif]-->
	<script type="text/javascript">
		$(document).ready(function() {
			$("select").selectBox();
		});
	</script>
	<!--script type="text/javascript" src="//yandex.st/share/share.js" charset="utf-8"></script-->
</head>
<body>

<?$APPLICATION->ShowPanel()?>

	<div class="bLayout">
		<div class="bHeader">
			<a href="/" class="bHeader__eLogoLink"><img src="/images/logo.jpg" width="227" height="50" alt="Страховой Сервис «Москва»" class="bHeader__eLogo"></a>
			<span class="bHeader__eHeaderText">Мы&nbsp;продаем<br>сервис!</span>
			<span class="bHeader__ePhone">+ 7&nbsp;800 2000&nbsp;600</span>
			<div class="bEnter">
				<img src="/images/enter_l.gif" class="bEnter__eLeftEdge" width="9" height="23" alt="">
				<div class="bEnter__eEnterWrapper">
					<img src="/images/enterArrow.png" class="bEnter__eEnterArrow" width="5" height="8" alt="">
					<span class="bEnter__eEnterText">Вход</span>
				</div>
				<img src="/images/enter_c.gif" class="bEnter__eCenterImg" width="8" height="23" alt="">
				<div class="bEnter__eRegistrationWrapper">
					<img src="/images/registerArrow.png" class="bEnter__eRegistrationArrow" width="5" height="8" alt="">
					<span class="bEnter__eRegistrationText">Регистрация</span>
				</div>
				<img src="/images/enter_r.gif" class="bEnter__eRightEdge" width="3" height="23" alt="">
			</div><!-- .Enter -->
		</div><!-- .bHeader -->
		<?$APPLICATION->IncludeComponent("bitrix:menu", ".default", array(
			"ROOT_MENU_TYPE" => "top",
			"MENU_CACHE_TYPE" => "N",
			"MENU_CACHE_TIME" => "3600",
			"MENU_CACHE_USE_GROUPS" => "Y",
			"MENU_CACHE_GET_VARS" => array(
			),
			"MAX_LEVEL" => "2",
			"CHILD_MENU_TYPE" => "left",
			"USE_EXT" => "N",
			"DELAY" => "N",
			"ALLOW_MULTI_SELECT" => "N",
			"URL_FB" => "http://facebook.com",
			"URL_VK" => "http://vk.com",
			"URL_TW" => "http://twitter.com"
			),
			false
		);?>
		<div class="bBanner">
			<div class="bSliderControls">
				<div class="bSliderControls__eBullet bSliderControls__eBullet__mState_active"></div>
				<div class="bSliderControls__eBullet"></div>
				<div class="bSliderControls__eBullet"></div>
				<div class="bSliderControls__eBullet"></div>
			</div>
			<div class="bBanner__eAd">
				<div class="bBanner__eAdText">с&nbsp;10&nbsp;по&nbsp;20&nbsp;мая</div>
				<div class="bBanner__eAdText bBanner__eAdText__mFont_big">
					Всем&nbsp;девушкам КАСКО&nbsp;дешевле на&nbsp;<span class="bBanner__eAdText__mFont_bold">15&nbsp;%</span>
					<a href="#"><img src="/images/profound.png" class="bAd__eLink" width="82" height="23" alt=""></a>
				</div>
			</div>
			<div class="bBanner__eVisibleSlider">
				<div class="bBanner__eLine">
					<img src="/images/banner_image1.jpg" class="bBanner__eImage" width="938" height="300" alt="">
					<img src="/images/banner_image1.jpg" class="bBanner__eImage" width="938" height="300" alt="">
					<img src="/images/banner_image1.jpg" class="bBanner__eImage" width="938" height="300" alt="">
					<img src="/images/banner_image1.jpg" class="bBanner__eImage" width="938" height="300" alt="">
					<img src="/images/banner_image1.jpg" class="bBanner__eImage" width="938" height="300" alt="">
				</div>
			</div>
		</div><!-- .bBanner -->
		<?$APPLICATION->IncludeComponent(
			"bitrix:breadcrumb",
			"",
			Array(
				"START_FROM" => "0",
				"PATH" => "",
				"SITE_ID" => SITE_ID
			),
		false
		);?> 