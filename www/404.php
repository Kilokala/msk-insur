<?
require($_SERVER['DOCUMENT_ROOT'].'/bitrix/header.php');
$APPLICATION->SetTitle("Ошибка 404");
$APPLICATION->SetPageProperty("NOT_SHOW_NAV_CHAIN", "Y");
?>

<style type="text/css">
	div.page404{
		padding: 10px 0;
		font-family: Arial, sans-serif;
	}
</style>

<div class="page404">
<h1>Страница не найдена</h1>
<p>Попробуйте перейдите на <a href="/">главную</a> и начать поиск информации заново.</p>
</div>
<?
require($_SERVER['DOCUMENT_ROOT'].'/bitrix/footer.php');
?>