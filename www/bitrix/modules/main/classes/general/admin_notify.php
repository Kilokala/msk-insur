<?
IncludeModuleLangFile(__FILE__);

class CAdminNotify
{
	public static function Add($arFields)
	{
		global $DB, $CACHE_MANAGER;
		$err_mess = (self::err_mess()).'<br />Function: Add<br />Line: ';

		if (!self::CheckFields($arFields))
			return false;

		if (!is_set($arFields['ENABLE_CLOSE']))
			$arFields['ENABLE_CLOSE'] = 'Y';

		if (is_set($arFields['TAG']) && strlen(trim($arFields['TAG']))>0)
		{
			$arFields['TAG'] = trim($arFields['TAG']);
			self::DeleteByTag($arFields['TAG']);
		}
		else
		{
			$arFields['TAG'] = "";
		}

		$arFields_i = Array(
			'MODULE_ID'	=> is_set($arFields['MODULE_ID'])? trim($arFields['MODULE_ID']): "",
			'TAG'	=> $arFields['TAG'],
			'MESSAGE'	=> trim($arFields['MESSAGE']),
			'ENABLE_CLOSE'	=> $arFields['ENABLE_CLOSE'],
		);
		$ID = $DB->Add('b_admin_notify', $arFields_i, Array('MESSAGE'));

		$CACHE_MANAGER->Clean("admin_notify_list");
		return $ID;
	}

	private static function CheckFields($arFields)
	{
		$aMsg = array();

		if(is_set($arFields, 'MODULE_ID') && trim($arFields['MODULE_ID'])=='')
			$aMsg[] = array('id'=>'MODULE_ID', 'text'=>GetMessage('MAIN_AN_ERROR_MODULE_ID'));
		if(is_set($arFields, 'TAG') && trim($arFields['TAG'])=='')
			$aMsg[] = array('id'=>'TAG', 'text'=>GetMessage('MAIN_AN_ERROR_TAG'));
		if(!is_set($arFields, 'MESSAGE') || trim($arFields['MESSAGE'])=='')
			$aMsg[] = array('id'=>'MESSAGE', 'text'=>GetMessage('MAIN_AN_ERROR_MESSAGE'));
		if(is_set($arFields, 'ENABLE_CLOSE') && !($arFields['ENABLE_CLOSE'] == 'Y' || $arFields['ENABLE_CLOSE'] == 'N'))
			$aMsg[] = array('id'=>'ENABLE_CLOSE', 'text'=>GetMessage('MAIN_AN_ERROR_ENABLE_CLOSE'));

		if(!empty($aMsg))
		{
			$e = new CAdminException($aMsg);
			$GLOBALS['APPLICATION']->ThrowException($e);
			return false;
		}

		return true;
	}

	public static function Delete($ID)
	{
		global $DB, $CACHE_MANAGER;
		$err_mess = (self::err_mess()).'<br />Function: Delete<br />Line: ';

		$strSql = "DELETE FROM b_admin_notify WHERE ID = ".intval($ID);
		$DB->Query($strSql, false, $err_mess.__LINE__);

		$CACHE_MANAGER->Clean("admin_notify_list");
		return true;
	}

	public static function DeleteByModule($moduleId)
	{
		global $DB, $CACHE_MANAGER;
		$err_mess = (self::err_mess()).'<br />Function: DeleteByModule<br />Line: ';

		$strSql = "DELETE FROM b_admin_notify WHERE MODULE_ID = '".$DB->ForSQL($moduleId)."'";
		$DB->Query($strSql, false, $err_mess.__LINE__);

		$CACHE_MANAGER->Clean("admin_notify_list");
		return true;
	}

	public static function DeleteByTag($tagId)
	{
		global $DB, $CACHE_MANAGER;
		$err_mess = (self::err_mess()).'<br />Function: DeleteByTag<br />Line: ';

		$strSql = "DELETE FROM b_admin_notify WHERE TAG like '%".$DB->ForSQL($tagId)."%'";
		$DB->Query($strSql, false, $err_mess.__LINE__);

		$CACHE_MANAGER->Clean("admin_notify_list");
		return true;
	}

	public static function GetHtml()
	{
		global $CACHE_MANAGER;
		$arNotify = false;

		if($CACHE_MANAGER->Read(86400, "admin_notify_list"))
			$arNotify = $CACHE_MANAGER->Get("admin_notify_list");

		if($arNotify === false)
		{
			$arNotify = Array();
			$CBXSanitizer = new CBXSanitizer;
			$CBXSanitizer->AddTags(array(
				'a' => array('href','style'),
				'b' => array(), 'u' => array(),
				'i' => array(), 'br' => array(),
				'span' => array('style'),
			));
			$dbRes = self::GetList();
			while ($ar = $dbRes->Fetch())
			{
				$ar["MESSAGE"] = $CBXSanitizer->SanitizeHtml($ar['MESSAGE']);
				$arNotify[] = $ar;
			}
			$CACHE_MANAGER->Set("admin_notify_list", $arNotify);
		}

		$html = "";
		foreach ($arNotify as $value)
		{
			$html .= '<div class="bx-panel-notification">'.
						'<div class="bx-panel-notification-close">'.($value['ENABLE_CLOSE'] == 'Y'? '<a style="cursor: pointer;" onclick="BX.admin.panel.hideNotify(this)" data-id="'.intval($value['ID']).'"  data-ajax="Y"></a>': '').'</div>'.
						'<div class="bx-panel-notification-text">'.$value['MESSAGE'].'</div>'.
					'</div>';
		}

		return $html;
	}

	public static function GetList($arSort=array(), $arFilter=array())
	{
		global $DB;

		$arSqlSearch = Array();
		$strSqlSearch = '';
		$err_mess = (self::err_mess()).'<br />Function: GetList<br />Line: ';

		if (is_array($arFilter))
		{
			$filter_keys = array_keys($arFilter);
			for ($i=0, $ic=count($filter_keys); $i<$ic; $i++)
			{
				$val = $arFilter[$filter_keys[$i]];
				if (strlen($val)<=0 || $val=='NOT_REF') continue;
				switch(strtoupper($filter_keys[$i]))
				{
					case 'ID':
						$arSqlSearch[] = GetFilterQuery('AN.ID', $val, 'N');
					break;
					case 'MODULE_ID':
						$arSqlSearch[] = GetFilterQuery('AN.MODULE_ID', $val);
					break;
					case 'TAG':
						$arSqlSearch[] = GetFilterQuery('AN.TAG', $val);
					break;
					case 'MESSAGE':
						$arSqlSearch[] = GetFilterQuery('AN.MESSAGE', $val);
					break;
					case 'ENABLE_CLOSE':
						$arSqlSearch[] = ($val=='Y') ? "AN.ENABLE_CLOSE='Y'" : "AN.ENABLE_CLOSE='N'";
					break;
				}
			}
		}

		$sOrder = '';
		foreach($arSort as $key=>$val)
		{
			$ord = (strtoupper($val) <> 'ASC'? 'DESC':'ASC');
			switch (strtoupper($key))
			{
				case 'ID':		$sOrder .= ', AN.ID '.$ord; break;
				case 'MODULE_ID':	$sOrder .= ', AN.MODULE_ID '.$ord; break;
				case 'ENABLE_CLOSE':	$sOrder .= ', AN.ENABLE_CLOSE '.$ord; break;
			}
		}

		if (strlen($sOrder)<=0)
			$sOrder = 'AN.ID DESC';

		$strSqlOrder = ' ORDER BY '.TrimEx($sOrder,',');
		$strSqlSearch = GetFilterSqlSearch($arSqlSearch);

		$strSql = "
			SELECT AN.ID, AN.MODULE_ID, AN.TAG, AN.MESSAGE, AN.ENABLE_CLOSE
			FROM b_admin_notify AN
			WHERE ".$strSqlSearch." ".$strSqlOrder;
		$res = $DB->Query($strSql, false, $err_mess.__LINE__);

		return $res;
	}

	private static function err_mess()
	{
		return '<br />Class: CAdminNotify<br />File: '.__FILE__;
	}
}

?>
