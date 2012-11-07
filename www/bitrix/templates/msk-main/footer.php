<?if(!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED!==true) die();?>
		<div class="bFooter">
			<div class="bFooterLinks">
				<?$APPLICATION->IncludeComponent("bitrix:menu", "bottom", array(
					"ROOT_MENU_TYPE" => "bottom",
					"MENU_CACHE_TYPE" => "N",
					"MENU_CACHE_TIME" => "3600",
					"MENU_CACHE_USE_GROUPS" => "Y",
					"MENU_CACHE_GET_VARS" => array(
					),
					"MAX_LEVEL" => "1",
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
			</div>
			<div class="bFooterCopyright">
				<div class="bFooterCopyright__eRights">&copy;&nbsp;2012 Все права защищены. Страховой Сервис Москва.</div>
				<div class="bFooterCopyright__eDev">Design: Kostabravo.ru</div>
				<div class="bFooterCopyright__eClear"></div>
			</div>
		</div><!-- .bFooter -->
	</div><!-- .bLayout -->
	
</body>
</html>