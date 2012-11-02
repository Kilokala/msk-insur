<?if(!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED!==true)die();
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

	<title><?$APPLICATION->ShowTitle()?></title>

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
	<script type="text/javascript" src="//yandex.st/share/share.js" charset="utf-8"></script>
</head>
<body>

<?$APPLICATION->ShowPanel()?>