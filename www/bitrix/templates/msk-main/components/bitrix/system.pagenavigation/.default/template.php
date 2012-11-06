<?
if(!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED!==true)die();

$anchor = false;
if(!empty($arResult['add_anchor'])){
	$anchor = $arResult['add_anchor'];
}

if(!$arResult["NavShowAlways"])
{
	if ($arResult["NavRecordCount"] == 0 || ($arResult["NavPageCount"] == 1 && $arResult["NavShowAll"] == false))
		return;
}
?>
<div class="bColBottom">
	<?
	$strNavQueryString = ($arResult["NavQueryString"] != "" ? $arResult["NavQueryString"]."&amp;" : "");
	$strNavQueryStringFull = ($arResult["NavQueryString"] != "" ? "?".$arResult["NavQueryString"] : "");

	// to show always first and last pages
	$arResult["nStartPage"] = 1;
	$arResult["nEndPage"] = $arResult["NavPageCount"];

	$sPrevHref = '';
	if ($arResult["NavPageNomer"] > 1){
		$bPrevDisabled = false;
		if ($arResult["bSavePage"] || $arResult["NavPageNomer"] > 2){
			$sPrevHref = $arResult["sUrlPath"].'?'.$strNavQueryString.'PAGEN_'.$arResult["NavNum"].'='.($arResult["NavPageNomer"]-1).$anchor;
		}else{
			$sPrevHref = $arResult["sUrlPath"].$strNavQueryStringFull.$anchor;
		}
	}else{
		$bPrevDisabled = true;
	}

	$sNextHref = '';
	if ($arResult["NavPageNomer"] < $arResult["NavPageCount"]){
		$bNextDisabled = false;
		$sNextHref = $arResult["sUrlPath"].'?'.$strNavQueryString.'PAGEN_'.$arResult["NavNum"].'='.($arResult["NavPageNomer"]+1).$anchor;
	}else{
		$bNextDisabled = true;
	}

	echo '<div class="bPageNumWrapper bPageNumWrapper__mArrow_left">';
	if($bPrevDisabled){
		echo '<span class="bPageNumWrapper__eNumberText"><</span>';
	}else{
		echo '<a href="'.$sPrevHref.'" class="bPageNumWrapper__eNumberText"><</a>';
	}
	echo '</div>';

	$bFirst = true;
	$bPoints = false;
	do{
		if ($arResult["nStartPage"] <= 2 || $arResult["nEndPage"]-$arResult["nStartPage"] <= 1 || abs($arResult['nStartPage']-$arResult["NavPageNomer"])<=2){

			if ($arResult["nStartPage"] == $arResult["NavPageNomer"]){
				echo '<div class="bPageNumWrapper bPageNumWrapper__mState_active"><div class="bPageNumWrapper__eNumber"><span class="bPageNumWrapper__eNumberText">'.$arResult["nStartPage"].'</span></div></div>';
			}else{
				if($arResult["nStartPage"] == 1 && $arResult["bSavePage"] == false){
					$href = $arResult["sUrlPath"].$strNavQueryStringFull.$anchor;
				}else{
					$href = $arResult["sUrlPath"].'?'.$strNavQueryString.'PAGEN_'.$arResult["NavNum"].'='.$arResult["nStartPage"].$anchor;
				}
				echo '<div class="bPageNumWrapper"><div class="bPageNumWrapper__eNumber"><a href="'.$href.'" class="bPageNumWrapper__eNumberText">'.$arResult["nStartPage"].'</a></div></div>';
			}
			$bFirst = false;
			$bPoints = true;
		}else{
			if ($bPoints){
				echo '<div class="bPageNumWrapper" style="text-align:center;"><span class="bPageNumWrapper__eNumberText">...</span></div>';
				$bPoints = false;
			}
		}
		$arResult["nStartPage"]++;
	} while($arResult["nStartPage"] <= $arResult["nEndPage"]);

	?>

	<?php 

	echo '<div class="bPageNumWrapper bPageNumWrapper__mArrow_right">';
	if($bNextDisabled){
		echo '<span class="bPageNumWrapper__eNumberText">></span>';
	}else{
		echo '<a href="'.$sNextHref.'" class="bPageNumWrapper__eNumberText">></a>';
	}
	echo '</div>';

	?>

</div>
<!-- .bColBottom -->
