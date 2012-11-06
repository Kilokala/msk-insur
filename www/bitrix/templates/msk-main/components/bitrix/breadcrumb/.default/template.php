<?
if(!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED!==true)die();

if(empty($arResult))
	return '';

ob_start();

$strReturn = '<ul class="breadcrumb-navigation">';



$strReturn .= '</ul>';
?>

<div class="bBreadcrumbs">
	<div class="bBreadcrumbs__eFirstStep">
		<div class="bBreadcrumbs__eFirstStepText"><a href="/">Главная</a></div>
		<div class="bBreadcrumbs__eFirstStepArrow"></div>
	</div>
	
<?php 
foreach($arResult as $item){
	
	?>
	<div class="bBreadcrumbs__eSecondStepWrapper">
		<div class="bBreadcrumbs__eSecondStep">
			<div class="bBreadcrumbs__eSecondStepText"><a href="<?=$item['LINK']?>"><?=$item['TITLE']?></a></div>
			<div class="bBreadcrumbs__eSecondStepArrow"></div>
		</div>
		<div class="bBreadcrumbs__eArrowWhite"></div>
		<div class="bBreadcrumbs__eArrowBlackWrapper">
			<div class="bBreadcrumbs__eArrowBlackBg"></div>
			<div class="bBreadcrumbs__eArrowBlack"></div>
		</div>
	</div>
	<?
}
?>
</div>
<!-- .bBreadcrumbs -->

<?php 

return ob_get_clean();