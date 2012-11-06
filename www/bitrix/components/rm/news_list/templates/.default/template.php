<?
if (!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED!==true) die();

?>

<a name="newsList"></a>
<div
	class="bContent">
	<div class="bContent__eLeftCol">
		<div class="bSideMenu">
			<?php 
			foreach($arResult['SECTIONS'] as $section){
				if($arParams['SECTION'] == $section['ID']){
					echo '<div class="bSideMenu__eItem bSideMenu__eItem__mPosition_first bSideMenu__eItem__mState_active">';
					echo $section['NAME'].'</div>';
				}else{
					echo '<div class="bSideMenu__eItem">';
					echo '<a href="?SECTION='.$section['ID'].$arParams['ANCHOR'].'" class="bSideMenu__eItemLink">';
					echo $section['NAME'].'</a></div>';
				}
			}
			?>
		</div>
		<?$APPLICATION->IncludeComponent(
				"bitrix:main.include",
				"",
				Array(
				"AREA_FILE_SHOW" => "file",
				"PATH" => "/features.php",
				"EDIT_TEMPLATE" => ""
			),
				false
		);?>
	</div>
	<!-- .bContent__eLeftCol -->
	<div class="bContent__eRightCol">
		<div class="bRightColBg">
			<?
			foreach($arResult['ITEMS'] as $item){
			$alt = htmlspecialchars($item['NAME']);
			?>
			<div class="bNewsItem">
				<div class="bNewsItem__eLeft">
					<a href="/news/detail.php?ID=<?=$item['ID']?>"> <img
						src="<?=$item['PREVIEW_PICTURE']['SRC']?>"
						class="bNewsItem__eImage" alt="<?=$alt?>" />
					</a>
				</div>
				<div class="bNewsItem__eRight">
					<p class="bNewsItem__eNewsTitle">
						<?=$item['NAME']?>
					</p>
					<a href="/news/detail.php?ID=<?=$item['ID']?>"
						class="bNewsItem__eNewsDate"> <?=$item['ACTIVE_FROM']?>
					</a>
					<p class="bNewsItem__eNewsText">
						<?=$item['PREVIEW_TEXT']?>
						<a href="/news/detail.php?ID=<?=$item['ID']?>"><img
							src="/images/news_arrow.png" width="12" height="14" alt="" /> </a>
					</p>
				</div>
				<div class="bNewsItem__eText"></div>
			</div>
			<!-- .bNewsItem -->
			<?
		}
		?>
		</div>
		<?php echo $arResult['NAV_STRING']; ?>
		<!-- .bRightColBg -->
	</div>
	<!-- .bContent__eRightCol -->
	<div class="bContent__eClear"></div>
</div>
<!-- .bContent -->

<?

//debug($arResult);

?>