<? if (!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED !== true) {
	die();
}

$arParams['IBLOCK_ID'] = (int)$arParams['IBLOCK_ID'];

if ($arParams["IBLOCK_ID"] < 1) {
	ShowError("IBLOCK_ID IS NOT DEFINED");

	return false;
}

if (!CModule::IncludeModule("iblock")) {
	$this->AbortResultCache();
	ShowError("IBLOCK_MODULE_NOT_INSTALLED");

	return false;
}

$arResult = array(
	'MESSAGE' => '',
	'TYPES' => array()
);

if ($_GET['mes'] === 'ok') {
	$arResult['MESSAGE']
		= '<p class="bTextItem bTextItem__mType_subtitle">Ваша заявка успешно сохранена. Скоро с Вами свяжется наш менеджер.</p>';
}

$rs = CIBlockPropertyEnum::GetList(array("SORT" => "ASC", "VALUE" => "ASC"), array('PROPERTY_ID' => 1));
while ($ar = $rs->Fetch()) {
	$arResult['TYPES'][(int)$ar['ID']] = $ar['VALUE'];
}

if (isset($_POST['form_send'])) {

	$_POST['name'] = strip_tags($_POST['name']);
	$_POST['sname'] = strip_tags($_POST['sname']);
	$_POST['phone'] = strip_tags($_POST['phone']);
	if (isset($_POST['type'])) {
		$_POST['type'] = intval($_POST['type']);
	}

	$err = false;
	if (empty($_POST['name'])) {
		$err = true;
	}
	if (empty($_POST['sname'])) {
		$err = true;
	}
	if (empty($_POST['phone'])) {
		$err = true;
	}
	if (isset($_POST['type']) && !array_key_exists($_POST['type'], $arResult['TYPES'])) {
		$err = true;
	}

	if (!$err) {
		$fields = array(
			'ACTIVE_FROM' => ConvertTimeStamp(false, 'FULL'),
			'NAME' => $_POST['sname'] . ' ' . $_POST['name'],
			'CODE' => $_POST['phone'],
			'IBLOCK_ID' => $arParams["IBLOCK_ID"],
			'ACTIVE' => 'Y',
			'PROPERTY_VALUES' => array('STATUS' => 11, 'TYPE' => 10)
		);

		if (isset($_POST['type'])) {
			$fields['PROPERTY_VALUES']['TYPE'] = $_POST['type'];
		}

		$el = new CIBlockElement();
		$ID = $el->Add($fields);
		if ($ID > 0) {
			LocalRedirect('?mes=ok');
		} else {
			$arResult['MESSAGE']
				= '<p class="bTextItem bTextItem__mType_subtitle" style="color:red;">Ошибка сохранения заявки.</p>';
		}
	} else {
		$arResult['MESSAGE']
			= '<p class="bTextItem bTextItem__mType_subtitle" style="color:red;">Для расчета необходимо заполнить все поля формы.</p>';
	}
}

$this->IncludeComponentTemplate();