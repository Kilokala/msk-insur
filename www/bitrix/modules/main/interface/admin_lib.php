<?
if(!defined("B_PROLOG_INCLUDED") || B_PROLOG_INCLUDED!==true) die();
IncludeModuleLangFile(__FILE__);

define("ADMIN_THEMES_PATH", "/bitrix/themes");

class CAdminPage
{
	var $aModules = array();
	var $bInit = false;

	function CAdminPage()
	{
	}

	function Init()
	{
		if($this->bInit)
			return;
		$this->bInit = true;

		$module_list = CModule::GetList();
		while($module = $module_list->Fetch())
			$this->aModules[] = $module["ID"];
	}

	function ShowPopupCSS()
	{
		$this->Init();

		$arCSS = array_merge(
			$this->GetModulesCSS($_REQUEST['from_module']),
			$GLOBALS["APPLICATION"]->GetCSSArray()
		);

		$s = '<script type="text/javascript" bxrunfirst>'."\n";
		for ($i = 0, $cnt = count($arCSS); $i < $cnt; $i++)
			$s .= 'top.BX.loadCSS(\''.CUtil::JSEscape($arCSS[$i]).'\');'."\n";
		$s .= '</script>';
		return $s;
	}

	function ShowCSS()
	{
		$this->Init();

		$arCSS = array_merge(array(
				ADMIN_THEMES_PATH.'/'.ADMIN_THEME_ID.'/compatible.css',
				ADMIN_THEMES_PATH.'/'.ADMIN_THEME_ID.'/adminstyles.css',
			),
			$this->GetModulesCSS(),
			$GLOBALS["APPLICATION"]->GetCSSArray()
		);

		$s = '';
		foreach($arCSS as $css)
			$s .= '<link rel="stylesheet" type="text/css" href="'.CUtil::GetAdditionalFileURL($css).'">'."\n";
		return $s;
	}

	function GetModulesCSS($module_id='')
	{
		global $CACHE_MANAGER;
		$rel_theme_path = ADMIN_THEMES_PATH."/".ADMIN_THEME_ID."/";
		$abs_theme_path = $_SERVER["DOCUMENT_ROOT"].$rel_theme_path;

		if($module_id <> '' && $this->aModules[$module_id] <> '')
		{
			if(file_exists($abs_theme_path.$module_id.".css"))
				return array($rel_theme_path.$module_id.'.css');
		}

		if($CACHE_MANAGER->Read(36000000, ADMIN_THEME_ID, "modules_css"))
			$time_cached = $CACHE_MANAGER->Get(ADMIN_THEME_ID);
		else
			$time_cached = '';

		//check modification time
		$time_fact = '';
		foreach($this->aModules as $module)
		{
			$fname = $abs_theme_path.$module.".css";
			if(file_exists($fname))
				$time_fact .= filemtime($fname);
		}

		$css_file = $abs_theme_path."modules.css";

		if($time_fact !== $time_cached)
		{
			//parse css files to create summary modules css
			$sCss = '';
			foreach($this->aModules as $module)
			{
				$fname = $abs_theme_path.$module.".css";
				if(file_exists($fname))
					$sCss .= file_get_contents($fname)."\n";
			}

			//create summary modules css
			file_put_contents($css_file, $sCss);

			if($time_cached !== '')
			{
				$CACHE_MANAGER->Clean(ADMIN_THEME_ID, "modules_css");
				$CACHE_MANAGER->Read(36000000, ADMIN_THEME_ID, "modules_css");
			}

			$CACHE_MANAGER->Set(ADMIN_THEME_ID, $time_fact);
		}

		if(file_exists($css_file))
			return array($rel_theme_path.'modules.css');
		else
			return array();
	}

	function ShowScript()
	{
		//PHP-depended variables
		$aUserOpt = CUserOptions::GetOption("global", "settings");
		$s = "
<script type=\"text/javascript\">
var phpVars = {
	'ADMIN_THEME_ID': '".CUtil::JSEscape(ADMIN_THEME_ID)."',
	'LANGUAGE_ID': '".CUtil::JSEscape(LANGUAGE_ID)."',
	'FORMAT_DATE': '".CUtil::JSEscape(FORMAT_DATE)."',
	'FORMAT_DATETIME': '".CUtil::JSEscape(FORMAT_DATETIME)."',
	'opt_context_ctrl': ".($aUserOpt["context_ctrl"] == "Y"? "true":"false").",
	'cookiePrefix': '".CUtil::JSEscape(COption::GetOptionString("main", "cookie_name", "BITRIX_SM"))."',
	'titlePrefix': '".CUtil::JSEscape(COption::GetOptionString("main", "site_name", $_SERVER["SERVER_NAME"]))." - ',
	'bitrix_sessid': '".bitrix_sessid()."',
	'messHideMenu': '".CUtil::JSEscape(GetMessage("admin_lib_hide_menu"))."',
	'messShowMenu': '".CUtil::JSEscape(GetMessage("admin_lib_show_menu"))."',
	'messHideButtons': '".CUtil::JSEscape(GetMessage("admin_lib_less_buttons"))."',
	'messShowButtons': '".CUtil::JSEscape(GetMessage("admin_lib_more_buttons"))."',
	'messFilterInactive': '".CUtil::JSEscape(GetMessage("admin_lib_filter_clear"))."',
	'messFilterActive': '".CUtil::JSEscape(GetMessage("admin_lib_filter_set"))."',
	'messFilterLess': '".CUtil::JSEscape(GetMessage("admin_lib_filter_less"))."',
	'messLoading': '".CUtil::JSEscape(GetMessage("admin_lib_loading"))."',
	'messMenuLoading': '".CUtil::JSEscape(GetMessage("admin_lib_menu_loading"))."',
	'messMenuLoadingTitle': '".CUtil::JSEscape(GetMessage("admin_lib_loading_title"))."',
	'messNoData': '".CUtil::JSEscape(GetMessage("admin_lib_no_data"))."',
	'messExpandTabs': '".CUtil::JSEscape(GetMessage("admin_lib_expand_tabs"))."',
	'messCollapseTabs': '".CUtil::JSEscape(GetMessage("admin_lib_collapse_tabs"))."',
	'messPanelFixOn': '".CUtil::JSEscape(GetMessage("admin_lib_panel_fix_on"))."',
	'messPanelFixOff': '".CUtil::JSEscape(GetMessage("admin_lib_panel_fix_off"))."',
	'messPanelCollapse': '".CUtil::JSEscape(GetMessage("admin_lib_panel_hide"))."',
	'messPanelExpand': '".CUtil::JSEscape(GetMessage("admin_lib_panel_show"))."'
};
</script>
<script type=\"text/javascript\" src=\"".CUtil::GetAdditionalFileURL("/bitrix/js/main/utils.js", true)."\"></script>
<script type=\"text/javascript\" src=\"".CUtil::GetAdditionalFileURL("/bitrix/js/main/admin_tools.js", true)."\"></script>
<script type=\"text/javascript\" src=\"".CUtil::GetAdditionalFileURL("/bitrix/js/main/popup_menu.js", true)."\"></script>
<script type=\"text/javascript\" src=\"".CUtil::GetAdditionalFileURL("/bitrix/js/main/admin_search.js", true)."\"></script>
<script type=\"text/javascript\" src=\"".CUtil::GetAdditionalFileURL("/bitrix/js/main/hot_keys.js", true)."\"></script>
";

		if (!defined('BX_PUBLIC_MODE') || BX_PUBLIC_MODE != 1)
			CUtil::InitJSCore(array('ajax', 'window', 'admin'));

		return $s;
	}

	function ShowSectionIndex($menu_id, $module_id=false, $mode=false)
	{
		if($mode === false)
		{
			if(isset($_REQUEST["show_mode"]))
			{
				$_SESSION["ADMIN_SHOW_MODE"] = $_REQUEST["show_mode"];
				CUserOptions::SetOption("view_mode", "pages", $_SESSION["ADMIN_SHOW_MODE"]);
			}
			elseif(!isset($_SESSION["ADMIN_SHOW_MODE"]))
				$_SESSION["ADMIN_SHOW_MODE"] = CUserOptions::GetOption("view_mode", "pages");

			if(!in_array($_SESSION["ADMIN_SHOW_MODE"], array("icon", "list", "table")))
				$_SESSION["ADMIN_SHOW_MODE"] = "icon";

			if($_REQUEST["mode"] <> "list")
			{
				echo '<div id="index_page_result_div">';

				$sTableID = "module_index_table";
				$page = $GLOBALS["APPLICATION"]->GetCurPage();
				$param = DeleteParam(array("show_mode", "mode"));
				echo '
	<script>
	var '.$sTableID.' = new JCAdminList("'.$sTableID.'");
	jsUtils.addEvent(window, "unload", function(){'.$sTableID.'.Destroy(true);});

	function LoadIndex(mode)
	{
		'.$sTableID.'.Destroy(false);
		jsUtils.LoadPageToDiv("'.$page.'?show_mode="+mode+"&mode=list'.($param<>""? "&".$param:"").'", "index_page_result_div");
	}
	</script>
	';
			}

			$aContext = array(
				array(
					"TEXT"=>GetMessage("admin_lib_index_view"),
					"TITLE"=>GetMessage("admin_lib_index_view_title"),
					"MENU"=>array(
						array(
							"ICON"=>($_SESSION["ADMIN_SHOW_MODE"] == "icon"? "checked":""),
							"TEXT"=>GetMessage("admin_lib_index_view_icon"),
							"TITLE"=>GetMessage("admin_lib_index_view_icon_title"),
							"ACTION"=>"LoadIndex('icon');"
						),
						array(
							"ICON"=>($_SESSION["ADMIN_SHOW_MODE"] == "list"? "checked":""),
							"TEXT"=>GetMessage("admin_lib_index_view_list"),
							"TITLE"=>GetMessage("admin_lib_index_view_list_title"),
							"ACTION"=>"LoadIndex('list');"
						),
						array(
							"ICON"=>($_SESSION["ADMIN_SHOW_MODE"] == "table"? "checked":""),
							"TEXT"=>GetMessage("admin_lib_index_view_table"),
							"TITLE"=>GetMessage("admin_lib_index_view_table_title"),
							"ACTION"=>"LoadIndex('table');"
						),
					),
				),
			);
			$context = new CAdminContextMenu($aContext);
			$context->Show();

			$mode = $_SESSION["ADMIN_SHOW_MODE"];
		}

		if($module_id === false)
			$this->Init();

		$GLOBALS["adminMenu"]->Init(($module_id !== false? array($module_id) : $this->aModules));
		$GLOBALS["adminMenu"]->ShowSubmenu($menu_id, $mode);

		if($_REQUEST["mode"] <> "list")
			echo '</div>';
	}

	function ShowSound()
	{
		global $USER, $APPLICATION;
		$res = '';
		if($USER->IsAuthorized() && !isset($_COOKIE[COption::GetOptionString("main", "cookie_name", "BITRIX_SM").'_SOUND_LOGIN_PLAYED']))
		{
			$aUserOptGlobal = CUserOptions::GetOption("global", "settings");
			if($aUserOptGlobal["sound"] == 'Y')
			{
				if($aUserOptGlobal["sound_login"] == '')
					$aUserOptGlobal["sound_login"] = "/bitrix/sounds/main/bitrix_tune.mp3";

				ob_start();
				$APPLICATION->IncludeComponent("bitrix:player",	"",
					Array(
						"PLAYER_TYPE" => "flv",
						"PATH" => htmlspecialcharsbx($aUserOptGlobal["sound_login"]),
						"WIDTH" => "1",
						"HEIGHT" => "1",
						"CONTROLBAR" => "none",
						"AUTOSTART" => "Y",
						"REPEAT" => "N",
						"VOLUME" => "90",
						"MUTE" => "N",
						"HIGH_QUALITY" => "Y",
						"BUFFER_LENGTH" => "2",
						"PROVIDER"=>"sound",
					),
					null, array("HIDE_ICONS"=>"Y")
				);
				$res = ob_get_contents();
				ob_end_clean();

				$res = '
<script type="text/javascript" src="'.CUtil::GetAdditionalFileURL('/bitrix/components/bitrix/player/mediaplayer/flvscript.js', true).'"></script>
<div style="position:absolute; top:-1000px; left:-1000px;">
'.$res.'
</div>
';
			}
		}
		return $res;
	}
}

/* Left tree-view menu */
class CAdminMenu
{
	var $aGlobalMenu, $aActiveSections=array(), $aOpenedSections=array();
	var $bInit = false;

	function CAdminMenu()
	{
	}

	function Init($modules)
	{
		global $APPLICATION, $USER, $DB, $MESS;

		if($this->bInit)
			return;
		$this->bInit = true;

		$aOptMenu = CUserOptions::GetOption("admin_menu", "pos", array());
		$this->AddOpenedSections($aOptMenu["sections"]);

		$aModuleMenu = array();
		foreach($modules as $module)
		{
			$module = _normalizePath($module);

			//trying to include file menu.php in the /admin/ folder of the current module
			$fname = $_SERVER["DOCUMENT_ROOT"].BX_ROOT."/modules/".$module."/admin/menu.php";
			if(file_exists($fname))
			{
				$menu = CAdminMenu::_IncludeMenu($fname);
				if(is_array($menu) && !empty($menu))
				{
					if(isset($menu["parent_menu"]) && $menu["parent_menu"] <> "")
					{
						//one section
						$aModuleMenu[] = $menu;
					}
					else
					{
						//multiple sections
						foreach($menu as $submenu)
							$aModuleMenu[] = $submenu;
					}
				}
			}
		}

		//additional user menu
		if(file_exists($_SERVER["DOCUMENT_ROOT"].BX_ROOT."/admin/.left.menu.php"))
			include($_SERVER["DOCUMENT_ROOT"].BX_ROOT."/admin/.left.menu.php");
		if(is_array($aMenuLinks) && !empty($aMenuLinks))
		{
			$bWasSeparator = false;
			$menu = array();
			foreach($aMenuLinks as $module_menu)
			{
				if($module_menu[3]["SEPARATOR"] == "Y")
				{
					//first level
					if(!empty($menu))
						$aModuleMenu[] = $menu;

					$menu = array(
						"parent_menu" => "global_menu_services",
						"icon" => "default_menu_icon",
						"page_icon" => "default_page_icon",
						"items_id"=>$module_menu[3]["SECTION_ID"],
						"items"=>array(),
						"sort"=>$module_menu[3]["SORT"],
						"text" => $module_menu[0],
					);
					$bWasSeparator = true;
				}
				elseif($bWasSeparator && $module_menu[3]["SECTION_ID"] == "")
				{
					//section items
					$menu["items"][] = array(
						"text" => $module_menu[0],
						"title"=>$module_menu[3]["ALT"],
						"url" => $module_menu[1],
						"more_url"=>$module_menu[2],
					);
				}
				elseif($module_menu[3]["SECTION_ID"] == "" || $module_menu[3]["SECTION_ID"] == "statistic" || $module_menu[3]["SECTION_ID"] == "sale")
				{
					//item in root
					$aModuleMenu[] = array(
						"parent_menu" => ($module_menu[3]["SECTION_ID"] == "statistic"? "global_menu_statistics" : ($module_menu[3]["SECTION_ID"] == "sale"? "global_menu_store":"global_menu_services")),
						"icon" => "default_menu_icon",
						"page_icon" => "default_page_icon",
						"sort"=>$module_menu[3]["SORT"],
						"text" => $module_menu[0],
						"title"=>$module_menu[3]["ALT"],
						"url" => $module_menu[1],
						"more_url"=>$module_menu[2],
					);
				}
				else
				{
					//item in section
					foreach($aModuleMenu as $i=>$section)
					{
						if($section["section"] == $module_menu[3]["SECTION_ID"])
						{
							if(!is_array($aModuleMenu[$i]["items"]))
								$aModuleMenu[$i]["items"] = array();

							$aModuleMenu[$i]["items"][] = array(
								"text" => $module_menu[0],
								"title"=>$module_menu[3]["ALT"],
								"url" => $module_menu[1],
								"more_url"=>$module_menu[2],
							);
							break;
						}
					}
				}
			}
			if(!empty($menu))
				$aModuleMenu[] = $menu;
		}

		$this->aGlobalMenu = array(
			"global_menu_content" => array(
				"icon" => "button_content",
				"page_icon" => "content_title_icon",
				"index_icon" => "content_page_icon",
				"text" => GetMessage("admin_lib_menu_content"),
				"title" => GetMessage("admin_lib_menu_content_title"),
				"url" => "content_index.php?lang=".LANGUAGE_ID,
				"sort" => 100,
				"items_id" => "global_menu_content",
				"help_section" => "content",
				"items" => array()
			),
			"global_menu_services" => array(
				"icon" => "button_services",
				"page_icon" => "services_title_icon",
				"index_icon" => "services_page_icon",
				"text" => GetMessage("admin_lib_menu_services"),
				"title" => GetMessage("admin_lib_menu_service_title"),
				"url" => "services_index.php?lang=".LANGUAGE_ID,
				"sort" => 200,
				"items_id" => "global_menu_services",
				"help_section" => "service",
				"items" => array()
			),
			"global_menu_store" => array(
				"icon" => "button_store",
				"page_icon" => "store_title_icon",
				"index_icon" => "store_page_icon",
				"text" => GetMessage("admin_lib_menu_store"),
				"title" => GetMessage("admin_lib_menu_store_title"),
				"url" => "store_index.php?lang=".LANGUAGE_ID,
				"sort" => 300,
				"items_id" => "global_menu_store",
				"help_section" => "store",
				"items" => array()
			),
			"global_menu_statistics" => array(
				"icon" => "button_statistics",
				"page_icon" => "statistics_title_icon",
				"index_icon" => "statistics_page_icon",
				"text" => GetMessage("admin_lib_menu_stat"),
				"title" => GetMessage("admin_lib_menu_stat_title"),
				"url" => "webanalytics_index.php?lang=".LANGUAGE_ID,
				"sort" => 400,
				"items_id" => "global_menu_statistics",
				"help_section" => "statistic",
				"items" => array()
			),
			"global_menu_settings" => array(
				"icon" => "button_settings",
				"page_icon" => "settings_title_icon",
				"index_icon" => "settings_page_icon",
				"text" => GetMessage("admin_lib_menu_settings"),
				"title" => GetMessage("admin_lib_menu_settings_title"),
				"url" => "all_settings_index.php?lang=".LANGUAGE_ID,
				"sort" => 500,
				"items_id" => "global_menu_settings",
				"help_section" => "settings",
				"items" => array()
			),
		);

		//User defined global sections
		$bSort = false;
		$events = GetModuleEvents("main", "OnBuildGlobalMenu");
		while($arEvent = $events->Fetch())
		{
			$bSort = true;
			$arRes = ExecuteModuleEventEx($arEvent, array(&$this->aGlobalMenu, &$aModuleMenu));
			if(is_array($arRes))
				$this->aGlobalMenu = array_merge($this->aGlobalMenu, $arRes);
		}
		if($bSort)
			uasort($this->aGlobalMenu, array($this, '_sort'));

		foreach($aModuleMenu as $menu)
			$this->aGlobalMenu[$menu["parent_menu"]]["items"][] = $menu;

		$sort_func = array($this, '_sort');
		foreach($this->aGlobalMenu as $key => $menu)
			if(empty($menu["items"]))
				unset($this->aGlobalMenu[$key]);
			else
				usort($this->aGlobalMenu[$key]["items"], $sort_func);

		foreach($this->aGlobalMenu as $key=>$menu)
			if($this->_SetActiveItems($this->aGlobalMenu[$key]))
				break;
	}

	function _sort($a, $b)
	{
		if($a["sort"] == $b["sort"])
			return 0;
		return ($a["sort"] < $b["sort"]? -1 : 1);
	}

	function _IncludeMenu($fname)
	{
		global $APPLICATION, $USER, $DB, $MESS;
		$menu =  include($fname);
		if(is_array($menu) && !empty($menu))
			return $menu;

		if(is_array($aModuleMenuLinks) && !empty($aModuleMenuLinks))
		{
			$menu = array();
			$n = 0;
			foreach($aModuleMenuLinks as $module_menu)
			{
				if($n == 0)
				{
					//first level
					$menu = array(
						"parent_menu" => "global_menu_services",
						"icon" => "default_menu_icon",
						"page_icon" => "default_page_icon",
						"items_id"=>"sect_".md5($fname),
						"items"=>array(),
						"sort"=>$module_menu[3]["SORT"],
						"text" => $module_menu[0],
						"url" => $module_menu[1],
					);
				}
				else
				{
					//section items
					$menu["items"][] = array(
						"text" => $module_menu[0],
						"title"=>$module_menu[3]["ALT"],
						"url" => $module_menu[1],
						"more_url"=>$module_menu[2],
					);
				}
				$n++;
			}
			return $menu;
		}
		return false;
	}

	function _SetActiveItems(&$aMenu, $aSections=array())
	{
		$bSubmenu = (isset($aMenu["items"]) && is_array($aMenu["items"]) && !empty($aMenu["items"]));
		if($bSubmenu)
			$aSections[$aMenu["items_id"]] = array(
				"items_id"=>$aMenu["items_id"],
				"page_icon"=>isset($aMenu["page_icon"])? $aMenu["page_icon"]: null,
				"text"=>$aMenu["text"],
				"url"=>$aMenu["url"],
				"skip_chain"=>isset($aMenu["skip_chain"])? $aMenu["skip_chain"]: null,
				"help_section"=>isset($aMenu["help_section"])? $aMenu["help_section"]: null,
			);

		$bSelected = false;
		$bMoreUrl = (isset($aMenu["more_url"]) && is_array($aMenu["more_url"]) && !empty($aMenu["more_url"]));
		if($aMenu["url"] <> "" || $bMoreUrl)
		{
			$cur_page = $GLOBALS["APPLICATION"]->GetCurPage();

			$all_links = array();
			if($aMenu["url"] <> "")
				$all_links[] = $aMenu["url"];
			if($bMoreUrl)
				$all_links = array_merge($all_links, $aMenu["more_url"]);

			$n = count($all_links);
			for($j = 0; $j < $n; $j++)
			{
				//"/admin/"
				//"/admin/index.php"
				//"/admin/index.php?module=mail"
				if(empty($all_links[$j]))
					continue;

				if(strpos($all_links[$j], "/bitrix/admin/") !== 0)
					$tested_link = "/bitrix/admin/".$all_links[$j];
				else
					$tested_link = $all_links[$j];

				if(strlen($tested_link) > 0 && strpos($cur_page, $tested_link) === 0) //
				{
					$bSelected = true;
					break;
				}

				if(($pos = strpos($tested_link, "?"))!==false) //
				{
					if(substr($tested_link, 0, $pos)==$cur_page)
					{
						$left = substr($tested_link, 0, $pos);
						$right = substr($tested_link, $pos+1);
						$params = explode("&", $right);
						$bOK = true;

						for($k=0; $k<count($params); $k++)
						{
							$eqpos=strpos($params[$k], "=");
							$varvalue="";
							if($eqpos===false)
								$varname = $params[$k];
							elseif($eqpos==0)
								continue;
							else
							{
								$varname = substr($params[$k], 0, $eqpos);
								$varvalue = urldecode(substr($params[$k], $eqpos+1));
							}

							$globvarvalue = isset($_REQUEST[$varname]) ? $_REQUEST[$varname] : "";
							if($globvarvalue != $varvalue)
							{
								$bOK = false;
								break;
							}
						} //for($k=0; $k<count($params); $k++)

						if($bOK)
						{
							$bSelected = true;
							break;
						}
					}//if(substr($tested_link, 0, $pos)==$cur_page)
				} //if(($pos = strpos($tested_link, "?"))!==false)
			} //for($j = 0; $j<count($all_links); $j++)
		}

		$bSelectedInside = false;
		if($bSubmenu)
		{
			foreach($aMenu["items"] as $key=>$submenu)
				if($this->_SetActiveItems($aMenu["items"][$key], $aSections))
				{
					$bSelectedInside = true;
					break;
				}
		}

		if($bSelected && !$bSelectedInside)
		{
			if(!$bSubmenu)
			{
				$aSections["_active"] = array(
					"page_icon"=>$aMenu["page_icon"],
					"text"=>$aMenu["text"],
					"url"=>$aMenu["url"],
					"skip_chain"=>$aMenu["skip_chain"],
					"help_section"=>$aMenu["help_section"],
				);
			}
			$aMenu["_active"] = true;
			$this->aActiveSections = $aSections;
		}

		return $bSelected || $bSelectedInside;
	}

	function Show($aMenu, $level=0)
	{
		$bSubmenu = (isset($aMenu["items"]) && is_array($aMenu["items"]) && !empty($aMenu["items"]));
		$bSectionActive = isset($aMenu["items_id"]) && (in_array($aMenu["items_id"], array_keys($this->aActiveSections)) || $this->IsSectionActive($aMenu["items_id"]));

		echo '
<div class="menuline">
<table cellspacing="0"><tr>
';
		for($i=0; $i<$level; $i++)
			echo '<td><div class="menuindent"></div></td>'."\n";

		if(isset($aMenu["dynamic"]) && $aMenu["dynamic"] == true && !$bSectionActive)
			echo '<td><div class="sign signplus" onclick="JsAdminMenu.ToggleDynSection(this, \''.htmlspecialcharsbx(CUtil::addslashes($aMenu["module_id"])).'\', \''.htmlspecialcharsbx(CUtil::addslashes($aMenu["items_id"])).'\', '.($level+1).')"></div></td>';
		else
			echo '<td><div class="sign '.($bSubmenu? ($bSectionActive? 'signminus':'signplus'):'signdot').'"'.($bSubmenu? "onclick=\"JsAdminMenu.ToggleSection(this, '".$aMenu["items_id"]."', ".($level+1).")\"":"").'></div></td>';

		if(isset($aMenu["icon"]) && $aMenu["icon"] <> "")
			echo '<td class="menuicon">'.(isset($aMenu["icon"]) && $aMenu["icon"] <> ""? '<a id="'.$aMenu["icon"].'"></a>':'').'</td>';

		if(isset($aMenu["url"]) && $aMenu["url"] <> "")
			echo '<td class="menutext menutext-no-url'.(isset($aMenu["readonly"]) && $aMenu["readonly"] == true? ' menutext-readonly':'').'"><a href="'.$aMenu["url"].'" title="'.$aMenu["title"].'"'.(isset($aMenu["_active"]) && $aMenu["_active"]? ' class="active"':'').'>'.$aMenu["text"].'</a></td>';
		else
			echo '<td class="menutext'.(isset($aMenu["readonly"]) && $aMenu["readonly"] == true? ' menutext-readonly':'').'">'.$aMenu["text"].'</td>';

		echo '
</tr></table>
';

		if($bSubmenu || (isset($aMenu["dynamic"]) && $aMenu["dynamic"] == true))
		{
			echo '<div id="'.$aMenu["items_id"].'" style="display:'.($bSectionActive? 'block':'none').';">';
			if($bSubmenu)
			{
				foreach($aMenu["items"] as $submenu)
					if($submenu)
						$this->Show($submenu, $level+1);
			}
			echo '</div>';
		}

		echo '</div>';
	}

	function ShowIcons($aMenu)
	{
		foreach($aMenu["items"] as $submenu)
		{
			if(!$submenu)
				continue;
			echo
				'<div class="index-icon-block" align="center">'.
				'<a href="'.$submenu["url"].'" title="'.$submenu["title"].'"><div class="index-icon" id="'.($submenu["page_icon"]<>""? $submenu["page_icon"]:$aMenu["page_icon"]).'"></div>'.
				'<div class="index-label">'.$submenu["text"].'</div></a>'.
				'</div>';
		}
		echo '<br clear="all">';
	}

	function ShowList($aMenu)
	{
		foreach($aMenu["items"] as $submenu)
		{
			if(!$submenu)
				continue;
			echo '<div class="index-list" id="'.($submenu["icon"]<>""? $submenu["icon"]:$aMenu["icon"]).'"><a href="'.$submenu["url"].'" title="'.$submenu["title"].'">'.$submenu["text"].'</a></div>';
		}
	}

	function ShowTable($aMenu)
	{
		$sTableID = "module_index_table";
		// List init
		$lAdmin = new CAdminList($sTableID);

		// List headers
		$lAdmin->AddHeaders(array(
			array("id"=>"NAME", "content"=>GetMessage("admin_lib_index_name"), "default"=>true),
			array("id"=>"DESCRIPTION", "content"=>GetMessage("admin_lib_index_desc"), "default"=>true),
		));

		$n = 0;
		foreach($aMenu["items"] as $submenu)
		{
			// Populate list with data
			if(!$submenu)
				continue;
			$row = &$lAdmin->AddRow(0, null, $submenu["url"], GetMessage("admin_lib_index_go"));
			$row->AddField("NAME", '<div class="index-table" id="'.($submenu["icon"]<>""? $submenu["icon"]:$aMenu["icon"]).'"><a href="'.$submenu["url"].'" title="'.$submenu["title"].'">'.$submenu["text"].'</a></div>');
			$row->AddField("DESCRIPTION", $submenu["title"]);
			$n++;
		}

		// List footer
		$lAdmin->AddFooter(
			array(
				array(
					"title" => GetMessage("MAIN_ADMIN_LIST_SELECTED"),
					"value" => $n
				)
			)
		);

		$lAdmin->Display();

		echo '
<script>
'.$sTableID.'.InitTable();
</script>
';
	}

	function ShowSubmenu($menu_id, $mode="menu")
	{
		foreach($this->aGlobalMenu as $key=>$menu)
			if($this->_ShowSubmenu($this->aGlobalMenu[$key], $menu_id, $mode))
				break;
	}

	function _ShowSubmenu(&$aMenu, $menu_id, $mode, $level=0)
	{
		$bSubmenu = (is_array($aMenu["items"]) && count($aMenu["items"])>0);
		if($bSubmenu)
		{
			if($aMenu["items_id"] == $menu_id)
			{
				if($mode == "menu")
				{
					foreach($aMenu["items"] as $submenu)
						$this->Show($submenu, $level);
				}
				elseif($mode == "icon")
					$this->ShowIcons($aMenu);
				elseif($mode == "list")
					$this->ShowList($aMenu);
				elseif($mode == "table")
					$this->ShowTable($aMenu);

				return true;
			}
			else
			{
				foreach($aMenu["items"] as $submenu)
					if($this->_ShowSubmenu($submenu, $menu_id, $mode, $level+1))
						return true;
			}
		}
		return false;
	}

	function ActiveSection()
	{
		if(!empty($this->aActiveSections))
			foreach($this->aActiveSections as $menu)
				return $menu;

		foreach($this->aGlobalMenu as $menu)
			return $menu;
	}

	function ActiveIcon()
	{
		if(!empty($this->aActiveSections))
		{
			$aSections = array_keys($this->aActiveSections);
			for($i=count($aSections)-1; $i>=0; $i--)
				if($this->aActiveSections[$aSections[$i]]["page_icon"] <> "")
					return $this->aActiveSections[$aSections[$i]]["page_icon"];
		}
		return "default_page_icon";
	}

	function AddOpenedSections($sections)
	{
		$aSect = explode(",", $sections);
		foreach($aSect as $sect)
			if(trim($sect) <> "")
				$this->aOpenedSections[] = trim($sect);
	}

	function IsSectionActive($section)
	{
		return in_array($section, $this->aOpenedSections);
	}

	function GetOpenedSections()
	{
		return implode(",", $this->aOpenedSections);
	}
}

/* Popup menu */
class CAdminPopup
{
	var $name;
	var $id;
	var $items;
	var $params;

	function CAdminPopup($name, $id, $items=false, $params=false)
	{
		//SEPARATOR, ID, ONCLICK, ICONCLASS, TEXT, DEFAULT=>true|false, DISABLED=>true|false
		$this->name = $name;
		$this->id = $id;
		$this->items = $items;
		$this->params = $params;
	}

	function Show($bReturnValue=false)
	{
		$s = '';
		if(!isset($_REQUEST["mode"]) || $_REQUEST["mode"] != "frame")
		{
			$s .=
'<script>
window.'.$this->name.' = new PopupMenu("'.$this->id.'"'.
	(is_array($this->params) && isset($this->params['zIndex'])? ', '.$this->params['zIndex']:'').
	(is_array($this->params) && isset($this->params['dxShadow'])? ', '.$this->params['dxShadow']:'').
');
';
			if(is_array($this->items))
			{
				$s .=
'window.'.$this->name.'.SetItems('.CAdminPopup::PhpToJavaScript($this->items).');
';
			}
			$s .=
'</script>
';
		}
		if($bReturnValue)
			return $s;
		else
			echo $s;
	}

	function PhpToJavaScript($items)
	{
		$sMenuUrl = "[";
		if(is_array($items))
		{
			$i = 0;
			foreach($items as $action)
			{
				if($i > 0)
					$sMenuUrl .= ",\n";

				if(isset($action["SEPARATOR"]) && ($action["SEPARATOR"] === true || $action["SEPARATOR"] == "Y"))
					$sMenuUrl .= "{'SEPARATOR':true}";
				else
				{
					if($action["ONCLICK"] <> "")
						$action["ACTION"] = $action["ONCLICK"];
					$sItem =
						(isset($action["ICON"]) && $action["ICON"]<>""? "'ICONCLASS':'".CUtil::JSEscape($action["ICON"])."',":"").
						(isset($action["IMAGE"]) && $action["IMAGE"]<>""? "'IMAGE':'".CUtil::JSEscape($action["IMAGE"])."',":"").
						(isset($action["ID"]) && $action["ID"]<>""? "'ID':'".CUtil::JSEscape($action["ID"])."',":"").
						(isset($action["DISABLED"]) && $action["DISABLED"] == true? "'DISABLED':true,":"").
						(isset($action["AUTOHIDE"]) && $action["AUTOHIDE"] == false? "'AUTOHIDE':false,":"").
						(isset($action["DEFAULT"]) && $action["DEFAULT"] == true? "'DEFAULT':true,":"").
						($action["TEXT"]<>""? "'TEXT':'".CUtil::JSEscape($action["TEXT"])."',":"").
						(isset($action["TITLE"]) && $action["TITLE"]<>""? "'TITLE':'".CUtil::JSEscape($action["TITLE"])."',":"").
						($action["ACTION"]<>""? "'ONCLICK':'".CUtil::JSEscape($action["ACTION"])."',":"").
						(isset($action["ONMENUPOPUP"]) && $action["ONMENUPOPUP"]<>""? "'ONMENUPOPUP':'".CUtil::JSEscape($action["ONMENUPOPUP"])."',":"").
						(isset($action["MENU"]) && is_array($action["MENU"])? "'MENU':".CAdminPopup::PhpToJavaScript($action["MENU"]).",":"");
					if($sItem <> "")
						$sItem = substr($sItem, 0, -1); //delete last comma
					$sMenuUrl .= "{".$sItem."}";
				}
				$i++;
			}
		}
		$sMenuUrl .= "]";
		return $sMenuUrl;
	}
}

/* Filter */
class CAdminFilter
{
	var $id;
	var $popup;

	function CAdminFilter($id, $popup=false)
	{
		if(empty($popup))
			$popup = false;
		$this->id = $id;
		$this->popup = $popup;
	}

	function Begin()
	{
		if($this->popup)
		{
			$aPopup = array();
			foreach($this->popup as $key=>$item)
			{
				if($item === null)
					continue;
				$aPopup[] = array("TEXT"=>$item, "ONCLICK"=>$this->id.".ToggleFilterRow('".$this->id."_row_".$key."');", "ID"=>"gutter_".$this->id."_row_".$key, "AUTOHIDE"=>false);
			}
			$aPopup[] = array("SEPARATOR"=>true);
			$aPopup[] = array("TEXT"=>GetMessage("admin_lib_filter_show_all"), "ONCLICK"=>$this->id.".ToggleAllFilterRows(true);");
			$aPopup[] = array("TEXT"=>GetMessage("admin_lib_filter_hide_all"), "ONCLICK"=>$this->id.".ToggleAllFilterRows(false);");

			$menu = new CAdminPopup($this->id."_menu", $this->id."_menu", $aPopup, array('zIndex'=>1000));
			$menu->Show();
		}

		echo '
<div class="filter-form">
<table cellpadding="0" cellspacing="0" border="0" class="filter-form">
	<tr class="top">
		<td class="left"><div class="empty"></div></td>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
';
		if($this->popup)
		{
			echo '
					<td><div class="section-separator first"></div></td>
					<td><a href="javascript:void(0)" onclick="this.blur();'.$this->id.'.ToggleAllFilterRows(true);" hidefocus="true" title="'.GetMessage("admin_lib_filter_show_all_title").'" class="context-button icon" id="filtershow"></a></td>
					<td><a href="javascript:void(0)" onclick="this.blur();'.$this->id.'.ToggleAllFilterRows(false);" hidefocus="true" title="'.GetMessage("admin_lib_filter_hide_all_title").'" class="context-button icon" id="filterhide"></a></td>
					<td><div class="separator"></div></td>
					<td><a href="javascript:void(0);" onClick="this.blur();'.$this->id.'_menu.ShowMenu(this, null);return false;" hidefocus="true" title="'.GetMessage("admin_lib_filter_more_title").'" class="context-button icon" id="filtermore">'.GetMessage("admin_lib_filter_more").'<img src="'.ADMIN_THEMES_PATH.'/'.ADMIN_THEME_ID.'/images/arr_down.gif" class="arrow" alt=""></a></td>
';
		}
		echo '
					<td width="100%"></td>
					<td><div class="inactive" id="'.$this->id.'_active_lamp" title="'.GetMessage("admin_lib_filter_clear").'"></div></td>
				</tr>
			</table>
		</td>
		<td class="right"><div class="empty"></div></td>
	</tr>
	<tr>
		<td class="left"><div class="empty"></div></td>
		<td class="content">
			<table cellpadding="0" cellspacing="0" border="0" width="100%" class="filtercontent" id="'.$this->id.'" style="display:none;">
';
	}

	function Buttons($aParams=false)
	{
		$hkInst = CHotKeys::getInstance();

		echo '
			</table>
			<div class="buttons">
';
		if($aParams !== false)
		{
			$url = $aParams["url"];
			if(strpos($url, "?")===false)
				$url .= "?";
			else
				$url .= "&";

			if(strpos($url, "lang=")===false)
				$url .= "lang=".LANG."&";

			if(isset($aParams['report']) && $aParams['report'])
				echo '
<input type="submit" name="set_filter" value="'.GetMessage("admin_lib_filter_set_rep").'" title="'.GetMessage("admin_lib_filter_set_rep_title").$hkInst->GetTitle("set_filter").'" onClick="'.htmlspecialcharsbx($this->id.'.OnSet(\''.CUtil::AddSlashes($aParams["table_id"]).'\', \''.CUtil::AddSlashes($url).'\'); return false;').'">
<input type="submit" name="del_filter" value="'.GetMessage("admin_lib_filter_clear_rep").'" title="'.GetMessage("admin_lib_filter_clear_rep_title").$hkInst->GetTitle("del_filter").'" onClick="'.htmlspecialcharsbx($this->id.'.OnClear(\''.CUtil::AddSlashes($aParams["table_id"]).'\', \''.CUtil::AddSlashes($url).'\'); return false;').'">
';
			else
				echo '
<input type="submit" name="set_filter" value="'.GetMessage("admin_lib_filter_set_butt").'" title="'.GetMessage("admin_lib_filter_set_butt_title").$hkInst->GetTitle("set_filter").'" onClick="'.htmlspecialcharsbx($this->id.'.OnSet(\''.CUtil::AddSlashes($aParams["table_id"]).'\', \''.CUtil::AddSlashes($url).'\'); return false;').'">
<input type="submit" name="del_filter" value="'.GetMessage("admin_lib_filter_clear_butt").'" title="'.GetMessage("admin_lib_filter_clear_butt_title").$hkInst->GetTitle("del_filter").'" onClick="'.htmlspecialcharsbx($this->id.'.OnClear(\''.CUtil::AddSlashes($aParams["table_id"]).'\', \''.CUtil::AddSlashes($url).'\'); return false;').'">
';
		}
	}

	function End()
	{
		$hkInst = CHotKeys::getInstance();
		echo '
			</div>
		</td>
		<td class="right"><div class="empty"></div></td>
	</tr>
	<tr class="bottom">
		<td class="left"><div class="empty"></div></td>
		<td><div class="empty"></div></td>
		<td class="right"><div class="empty"></div></td>
	</tr>
</table>
</div>
';
		$sRowIds = $sVisRowsIds = "";
		if($this->popup)
		{
			foreach($this->popup as $key=>$item)
				if($item !== null)
					$sRowIds .= ($sRowIds <> ""? ",":"").'"'.CUtil::JSEscape($key).'"';

			$aOptFlt = CUserOptions::GetOption("filter", $this->id, array("rows"=>""));
			$aRows = explode(",", $aOptFlt["rows"]);
			foreach($aRows as $row)
				if(trim($row) <> "")
					$sVisRowsIds .= ($sVisRowsIds <> ""? ",":"").'"'.CUtil::JSEscape(trim($row)).'":true';
		}

		echo '
<script>
var '.$this->id.' = new JCAdminFilter("'.$this->id.'", ['.$sRowIds.']);
'.$this->id.'.InitFilter({'.$sVisRowsIds.'});
</script>
';
			$Execs = $hkInst->GetCodeByClassName("CAdminFilter");
			echo $hkInst->PrintJSExecs($Execs);

	}

	function UnEscape($aFilter)
	{
		if(defined("BX_UTF"))
			return;
		if(!is_array($aFilter))
			return;
		foreach($aFilter as $flt)
			if(is_string($GLOBALS[$flt]) && CUtil::DetectUTF8($GLOBALS[$flt]))
				CUtil::decodeURIComponent($GLOBALS[$flt]);
	}
}

/* Context links menu */
class CAdminContextMenu
{
	var $items;

	function CAdminContextMenu($items)
	{
		//array(
		//	array("NEWBAR"=>true),
		//	array("SEPARATOR"=>true),
		//	array("HTML"=>""),
		//	array("TEXT", "ICON", "TITLE", "LINK", "LINK_PARAM"),
		//	array("TEXT", "ICON", "TITLE", "MENU"=>array(array("SEPARATOR"=>true, "ICON", "TEXT", "TITLE", "ACTION"), ...)),
		//	array("TEXT", "ICON", "TITLE", "ONCLICK", "LINK_PARAM"),
		//	...
		//)
		$this->items = $items;
	}

	function Show()
	{
		if (defined('BX_PUBLIC_MODE') && BX_PUBLIC_MODE == 1)
			return;

		$hkInst = CHotKeys::getInstance();

		$db_events = GetModuleEvents("main", "OnAdminContextMenuShow");
		while($arEvent = $db_events->Fetch())
			ExecuteModuleEventEx($arEvent, array(&$this->items));

		echo '
<div class="contextmenu">
<table cellpadding="0" cellspacing="0" border="0" class="contextmenu">
';
		$bFirst = true;
		$bWasSeparator = false;
		$bWasPopup = false;
		foreach($this->items as $item)
		{
			if(!empty($item["NEWBAR"]))
				$this->EndBar();
			if($bFirst || !empty($item["NEWBAR"]))
			{
				$this->BeginBar();
				$bWasSeparator = true;
			}
			if(!empty($item["NEWBAR"]))
				continue;
			if(!empty($item["SEPARATOR"]))
			{
				echo '<td><div class="section-separator"></div></td>';
				$bWasSeparator = true;
			}
			else
			{
				if(!$bWasSeparator)
				{
					echo '<td><div class="separator"></div></td>';
				}
				if(!empty($item["MENU"]))
				{
					$bWasPopup = true;
					$sMenuUrl = "jsToolBar_popup.ShowMenu(this, ".htmlspecialcharsbx(CAdminPopup::PhpToJavaScript($item["MENU"])).");";
					echo '<td><a href="javascript:void(0);" hidefocus="true" onClick="this.blur();'.$sMenuUrl.'return false;" title="'.$item["TITLE"].'" class="context-button'.(!empty($item["ICON"])? ' icon" id="'.$item["ICON"].'"':'"').'>'.$item["TEXT"].'<img src="'.ADMIN_THEMES_PATH.'/'.ADMIN_THEME_ID.'/images/arr_down.gif" class="arrow" alt=""></a></td>';
				}
				elseif(isset($item["HTML"]) && $item["HTML"] <> "")
				{
					echo '<td>'.$item["HTML"].'</td>';
				}
				else
				{
					echo '<td><a href="'.($item["ONCLICK"] <> ''? 'javascript:void(0)' : htmlspecialcharsbx(htmlspecialcharsback($item["LINK"]))).'" hidefocus="true" title="'.$item["TITLE"].$hkInst->GetTitle($item["ICON"]).'" '.$item["LINK_PARAM"].' class="context-button'.(!empty($item["ICON"])? ' icon" id="'.$item["ICON"].'"':'"').($item["ONCLICK"] <> ''? ' onclick="'.htmlspecialcharsbx($item["ONCLICK"]).'"':'').'>'.$item["TEXT"].'</a>';

					$arExecs = $hkInst->GetCodeByClassName($item["ICON"]);
					echo $hkInst->PrintJSExecs($arExecs, "", true, true);

					echo '</td>';
				}
				$bWasSeparator = false;
			}
			$bFirst = false;
		}

		$this->EndBar();

		echo '
<tr class="bottom-all">
<td class="left"><div class="empty"></div></td>
<td><div class="empty"></div></td>
<td class="right"><div class="empty"></div></td>
</tr>
</table>
';
		if($bWasPopup)
		{
			$menu = new CAdminPopup("jsToolBar_popup", "adminToolbarMenu");
			$menu->Show();

		}
		echo '
</div>
';
	}

	function BeginBar()
	{
		echo '
<tr class="top">
<td class="left"><div class="empty"></div></td>
<td><div class="empty"></div></td>
<td class="right"><div class="empty"></div></td>
</tr>
<tr>
<td class="left"><div class="empty"></div></td>
<td class="content">
<table cellpadding="0" cellspacing="0" border="0">
<tr>
<td><div class="section-separator first"></div></td>
';
	}

	function EndBar()
	{
		echo '
</tr>
</table>
</td>
<td class="right"><div class="empty"></div></td>
</tr>
<tr class="bottom">
<td class="left"><div class="empty"></div></td>
<td><div class="empty"></div></td>
<td class="right"><div class="empty"></div></td>
</tr>
';
	}
}

/* Sorting in lists */
class CAdminSorting
{
	var $by_name;
	var $ord_name;
	var $table_id;
	var $by_initial;
	var $order_initial;

	function CAdminSorting($table_id, $by_initial=false, $order_initial=false, $by_name="by", $ord_name="order")
	{
		$this->by_name = $by_name;
		$this->ord_name = $ord_name;
		$this->table_id = $table_id;
		$this->by_initial = $by_initial;
		$this->order_initial = $order_initial;

		$uniq = md5($GLOBALS["APPLICATION"]->GetCurPage());

		$aOptSort = array();
		if(isset($GLOBALS[$this->by_name]))
			$_SESSION["SESS_SORT_BY"][$uniq] = $GLOBALS[$this->by_name];
		elseif(isset($_SESSION["SESS_SORT_BY"][$uniq]))
			$GLOBALS[$this->by_name] = $_SESSION["SESS_SORT_BY"][$uniq];
		else
		{
			$aOptSort = CUserOptions::GetOption("list", $this->table_id, array("by"=>$by_initial, "order"=>$order_initial));
			if(!empty($aOptSort["by"]))
				$GLOBALS[$this->by_name] = $aOptSort["by"];
			elseif($by_initial !== false)
				$GLOBALS[$this->by_name] = $by_initial;
		}

		if(isset($GLOBALS[$this->ord_name]))
			$_SESSION["SESS_SORT_ORDER"][$uniq] = $GLOBALS[$this->ord_name];
		elseif(isset($_SESSION["SESS_SORT_ORDER"][$uniq]))
			$GLOBALS[$this->ord_name] = $_SESSION["SESS_SORT_ORDER"][$uniq];
		else
		{
			if(empty($aOptSort["order"]))
				$aOptSort = CUserOptions::GetOption("list", $this->table_id, array("order"=>$order_initial));
			if(!empty($aOptSort["order"]))
				$GLOBALS[$this->ord_name] = $aOptSort["order"];
			elseif($order_initial !== false)
				$GLOBALS[$this->ord_name] = $order_initial;
		}
	}

	function Show($text, $sort_by, $alt_title = false)
	{
		$ord = "asc";
		$class = "";
		$title = GetMessage("admin_lib_sort_title")." ".($alt_title?$alt_title:$text);
		//echo $this->by_name.'/'.strtolower($GLOBALS[$this->by_name]) .'=='. strtolower($sort_by).'<br>';
		if(strtolower($GLOBALS[$this->by_name]) == strtolower($sort_by))
		{
			if(strtolower($GLOBALS[$this->ord_name]) == "desc")
			{
				$class = " down";
				$title .= " ".GetMessage("admin_lib_sort_down");
			}
			else
			{
				$class = " up";
				$title .= " ".GetMessage("admin_lib_sort_up");
				$ord = "desc";
			}
		}

		$path = $_SERVER["REQUEST_URI"];
		$sep = "?";
		if($_SERVER["QUERY_STRING"] <> "")
		{
			$path = preg_replace("/([?&])".$this->by_name."=[^&]*[&]*/i", "\\1", $path);
			$path = preg_replace("/([?&])".$this->ord_name."=[^&]*[&]*/i", "\\1", $path);
			$path = preg_replace("/([?&])mode=[^&]*[&]*/i", "\\1", $path);
			$path = preg_replace("/([?&])table_id=[^&]*[&]*/i", "\\1", $path);
			$sep = "&";
		}
		if(($last = substr($path, -1, 1)) == "?" || $last == "&")
			$sep = "";

		$url = $path.$sep.$this->by_name."=".$sort_by."&".$this->ord_name."=".($class <> ""? $ord:"");

		echo '
<table cellspacing="0" class="sorting" onClick="'.$this->table_id.'.Sort(\''.htmlspecialcharsbx(CUtil::addslashes($url)).'\', '.($class <> ""? "false" : "true").', arguments);" title="'.$title.'">
<tr>
<td>'.$text.'</td>
<td class="sign'.$class.'"><div class="empty"></div></td>
</tr>
</table>
';
	}
}

/* Navigation */
/*
Important Notice:
	CIBlockResult has copy of the methods of this class
	because we need CIBlockResult::Fetch method to be called on iblock_element_admin.php page.
	So this page based on CIBlockResult not on CAdminResult!
*/
class CAdminResult extends CDBResult
{
	var $nInitialSize;
	var $table_id;

	function CAdminResult($res, $table_id)
	{
		parent::CDBResult($res);
		$this->table_id = $table_id;
	}

	function NavStart($nPageSize=20, $bShowAll=true, $iNumPage=false)
	{
		$nSize = CAdminResult::GetNavSize($this->table_id, $nPageSize);

		if(!is_array($nPageSize))
			$nPageSize = array();

		$nPageSize["nPageSize"] = $nSize;
		if($_REQUEST["mode"] == "excel")
			$nPageSize["NavShowAll"] = true;

		$this->nInitialSize = $nPageSize["nPageSize"];

		parent::NavStart($nPageSize, $bShowAll, $iNumPage);
	}

	function GetNavSize($table_id=false, $nPageSize=20)
	{
		$bSess = (CPageOption::GetOptionString("main", "nav_page_in_session", "Y")=="Y");
		if($bSess)
		{
			if(is_array($nPageSize))
				$sNavID = $nPageSize["sNavID"];
			$unique = md5((isset($sNavID)? $sNavID : $GLOBALS["APPLICATION"]->GetCurPage()));
		}

		if(isset($_REQUEST["SIZEN_".($GLOBALS["NavNum"]+1)]))
		{
			$nSize = intval($_REQUEST["SIZEN_".($GLOBALS["NavNum"]+1)]);
			if($bSess)
				$_SESSION["NAV_PAGE_SIZE"][$unique] = $nSize;
		}
		elseif($bSess && isset($_SESSION["NAV_PAGE_SIZE"][$unique]))
		{
			$nSize = $_SESSION["NAV_PAGE_SIZE"][$unique];
		}
		else
		{
			$aOptions = array();
			if($table_id)
				$aOptions = CUserOptions::GetOption("list", $table_id);
			if(intval($aOptions["page_size"]) > 0)
				$nSize = intval($aOptions["page_size"]);
			else
				$nSize = (is_array($nPageSize)? $nPageSize["nPageSize"]:$nPageSize);
		}
		return $nSize;
	}

	function GetNavPrint($title, $show_allways=true, $StyleText="", $template_path=false, $arDeleteParam=false)
	{
		if($template_path === false)
			$template_path = $_SERVER["DOCUMENT_ROOT"]."/bitrix/modules/main/interface/navigation.php";
		return parent::GetNavPrint($title, $show_allways, $StyleText, $template_path, array('action', 'sessid'));
	}
}

/*Tab Control*/
class CAdminTabControl
{
	var $name, $unique_name;
	var $tabs;
	var $selectedTab;
	var $tabIndex = 0;
	var $bButtons = false;
	var $bCanExpand;
	var $bPublicModeBuffer = false;

	var $customTabber;

	var $bPublicMode = false;
	var $publicObject = 'BX.WindowManager.Get()';

	var $AUTOSAVE = null;

	function CAdminTabControl($name, $tabs, $bCanExpand = true, $bDenyAutoSave = false)
	{
		//array(array("DIV"=>"", "TAB"=>"", "ICON"=>, "TITLE"=>"", "ONSELECT"=>"javascript"), ...)
		$this->tabs = $tabs;
		$this->name = $name;
		$this->unique_name = $name."_".md5($GLOBALS["APPLICATION"]->GetCurPage());

		$this->bPublicMode = defined('BX_PUBLIC_MODE') && BX_PUBLIC_MODE == 1;
		$this->bCanExpand = !$this->bPublicMode && (bool)$bCanExpand;

		if(isset($_REQUEST[$this->name."_active_tab"]))
			$this->selectedTab = $_REQUEST[$this->name."_active_tab"];
		else
			$this->selectedTab = $tabs[0]["DIV"];

		if (!$bDenyAutoSave && CAutoSave::Allowed())
		{
			$this->AUTOSAVE = new CAutoSave();
		}
	}

	function SetPublicMode($jsObject = false)
	{
		$this->bPublicMode = true;
		$this->bCanExpand = false;
		$this->bPublicModeBuffer = true;

		if ($jsObject)
			$this->publicObject = $jsObject;
	}

	function AddTabs(&$customTabber)
	{
		$this->customTabber = $customTabber;

		$arCustomTabs = $this->customTabber->GetTabs();
		if ($arCustomTabs && is_array($arCustomTabs))
		{
			$arTabs = array();
			$i = 0;
			foreach ($this->tabs as $value)
			{
				foreach ($arCustomTabs as $key1 => $value1)
				{
					if (array_key_exists("SORT", $value1) && IntVal($value1["SORT"]) == $i)
					{
						$arTabs[] = array_merge($value1, array("CUSTOM" => "Y"));
						unset($arCustomTabs[$key1]);
					}
				}

				$arTabs[] = $value;
				$i++;
			}

			foreach ($arCustomTabs as $key1 => $value1)
				$arTabs[] = array_merge($value1, array("CUSTOM" => "Y"));

			if(isset($_REQUEST[$this->name."_active_tab"]))
				$this->selectedTab = $_REQUEST[$this->name."_active_tab"];
			else
				$this->selectedTab = $arTabs[0]["DIV"];

			$this->tabs = $arTabs;
		}
	}

	function Begin()
	{
		$hkInst = CHotKeys::getInstance();

		$db_events = GetModuleEvents("main", "OnAdminTabControlBegin");
		while($arEvent = $db_events->Fetch())
			ExecuteModuleEventEx($arEvent, array(&$this));

		$this->tabIndex = 0;

		if ($this->bPublicMode)
		{
			$tabs_html = '<span class="tabs">';

			foreach($this->tabs as $tab)
			{
				$bSelected = ($tab["DIV"] == $this->selectedTab);
				$tabs_html .= '
					<a href="javascript:void(0)" hidefocus="hidefocus" title="'.$tab["TITLE"].$hkInst->GetTitle("tab-container").'" id="tab_cont_'.$tab["DIV"].'" class="tab-container'.($bSelected? "-selected":"").'" onclick="return false;"><span class="tab-left"><span class="tab-right" onclick="'.$this->name.'.SelectTab(\''.$tab["DIV"].'\');">'.htmlspecialcharsex($tab["TAB"]).'</span></span></a>
';
			}

			$tabs_html .= '</span>';
?>
<script type="text/javascript">
<?=$this->publicObject?>.SetHead('<?echo CUtil::JSEscape($tabs_html)?>');
<?if ($this->AUTOSAVE):?>
<?=$this->publicObject?>.setAutosave();
<?endif;?>
</script><?

			if ($this->bPublicModeBuffer)
			{
				$this->publicModeBuffer_id = 'bx_tab_control_'.RandString(6);
				echo '<div id="'.$this->publicModeBuffer_id.'" style="display: none;">';
			}

?>
<div class="edit-form">
<?
		}
		else //($this->bPublicMode)
		{
			echo '
<div class="edit-form">
<table cellpadding="0" cellspacing="0" border="0" width="100%" class="edit-form">
	<tr class="top">
		<td class="left"><div class="empty"></div></td>
		<td><div class="empty"></div></td>
		<td class="right"><div class="empty"></div></td>
	</tr>
	<tr>
		<td class="left"><div class="empty"></div></td>
		<td class="content">';

			echo '<table cellspacing="0" class="edit-tabs" width="100%">
				<tr>
					<td class="tab-indent"><div class="empty"></div></td>
';
			$nTabs = count($this->tabs);
			$i = 0;
			foreach($this->tabs as $tab)
			{
				$bSelected = ($tab["DIV"] == $this->selectedTab);
				echo '
					<td title="'.$tab["TITLE"].$hkInst->GetTitle("tab-container").'" id="tab_cont_'.$tab["DIV"].'" class="tab-container'.($bSelected? "-selected":"").'" onClick="'.$this->name.'.SelectTab(\''.$tab["DIV"].'\');" onMouseOver="if(window.'.$this->name.'){'.$this->name.'.HoverTab(\''.$tab["DIV"].'\', true);}" onMouseOut="if(window.'.$this->name.'){'.$this->name.'.HoverTab(\''.$tab["DIV"].'\', false);}">
						<table cellspacing="0">
							<tr>
								<td class="tab-left'.($bSelected? "-selected":"").'" id="tab_left_'.$tab["DIV"].'"><div class="empty"></div></td>
								<td class="tab'.($bSelected? "-selected":"").'" id="tab_'.$tab["DIV"].'">'.htmlspecialcharsex($tab["TAB"]).'</td>
								<td class="tab-right'.($i == ($nTabs - 1)? "-last":"").($bSelected? "-selected":"").'" id="tab_right_'.$tab["DIV"].'"><div class="empty"></div></td>
							</tr>
						</table>
					</td>
';
				$i++;
			}
			$this->ShowTabButtons();
			echo '
				</tr>
			</table>';
			echo '<table cellspacing="0" class="edit-tab">
				<tr>
					<td>
';
		}
	}

	function ShowTabButtons()
	{
		echo '<td width="100%" align="right">';
		if(count($this->tabs) > 1 && $this->bCanExpand || $this->AUTOSAVE)
		{
			if ($this->AUTOSAVE)
				echo '<a href="javascript:void(0)" id="'.$this->name.'_autosave_link" class="context-button bx-core-autosave bx-core-autosave-ready"></a>';

			if (count($this->tabs) > 1 && $this->bCanExpand)
				echo '<a href="javascript:void(0)" onclick="this.blur();'.$this->name.'.ToggleTabs();" hidefocus="true" title="'.GetMessage("admin_lib_expand_tabs").'" id="'.$this->name.'_expand_link" class="context-button down"></a>';
		}
		else
			echo '<div class="empty"></div>';

		echo '</td>';
	}

	function BeginNextTab()
	{
		if ($this->AUTOSAVE)
			$this->AUTOSAVE->Init();

		//end previous tab
		$this->EndTab();

		if($this->tabIndex >= count($this->tabs))
			return;

		$css = '';
		if ($this->tabs[$this->tabIndex]["DIV"] <> $this->selectedTab)
			$css .= 'display:none; ';

		echo '
<div id="'.$this->tabs[$this->tabIndex]["DIV"].'" class="edit-tab-inner"'.($css != '' ? 'style="'.$css.'"' : '').'>'.($this->bPublicMode ? '' : '<div style="height: 100%;">').'
<table cellpadding="0" cellspacing="0" border="0" class="edit-tab-title">
	<tr style="display:none;">
		<td colspan="2" class="delimiter delimiter-top"><div class="empty"></div></td>
	</tr>
	<tr>
';
		if($this->tabs[$this->tabIndex]["ICON"] <> "")
			echo '
		<td class="icon"><div id="'.$this->tabs[$this->tabIndex]["ICON"].'"></div></td>
';
		echo '
		<td class="title">'.$this->tabs[$this->tabIndex]["TITLE"].'</td>
	</tr>
	<tr>
		<td colspan="2" class="delimiter"><div class="empty"></div></td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border="0" class="edit-table" id="'.$this->tabs[$this->tabIndex]["DIV"].'_edit_table">
';
		if(array_key_exists("CUSTOM", $this->tabs[$this->tabIndex]) && $this->tabs[$this->tabIndex]["CUSTOM"] == "Y")
		{
			$this->customTabber->ShowTab($this->tabs[$this->tabIndex]["DIV"]);
			$this->tabIndex++;
			$this->BeginNextTab();
		}
		elseif(array_key_exists("CONTENT", $this->tabs[$this->tabIndex]))
		{
			echo $this->tabs[$this->tabIndex]["CONTENT"];
			$this->tabIndex++;
			$this->BeginNextTab();
		}
		else
		{
			$this->tabIndex++;
		}
	}

	function EndTab()
	{
		if(
			$this->tabIndex < 1
			|| $this->tabIndex > count($this->tabs)
			|| $this->tabs[$this->tabIndex-1]["_closed"] === true
		)
			return;

			echo '
	</table>
</div>
';
		if (!$this->bPublicMode)
			echo '</div>';

		$this->tabs[$this->tabIndex-1]["_closed"] = true;
	}

	function Buttons($aParams=false)
	{
		$hkInst = CHotKeys::getInstance();

		while($this->tabIndex < count($this->tabs))
			$this->BeginNextTab();

		$this->bButtons = true;
		//end previous tab
		$this->EndTab();

		if (!$this->bPublicMode)
		{
			echo '
					</td>
				</tr>
			</table>';
			echo '<div class="buttons">';
		}

		if ($_REQUEST['subdialog'])
		{
			echo '<input type="hidden" name="suffix" value="'.substr($GLOBALS['obJSPopup']->suffix, 1).'" />';
			echo '<input type="hidden" name="subdialog" value="Y" />';
		}

		if($aParams !== false)
		{
			if ($this->bPublicMode)
			{
				if (strlen($_REQUEST['from_module']))
					echo '<input type="hidden" name="from_module" value="'.htmlspecialcharsbx($_REQUEST['from_module']).'" />';

				if(is_array($aParams['buttons']))
				{
?>
<input type="hidden" name="bxpublic" value="Y" />
<script type="text/javascript"><?=$this->publicObject?>.SetButtons(<?echo CUtil::PhpToJsObject($aParams['buttons']);?>);</script>
<?
				}
				else
				{
?>
<input type="hidden" name="bxpublic" value="Y" /><input type="hidden" name="save" value="Y" />
<script type="text/javascript"><?=$this->publicObject?>.SetButtons([<?=$this->publicObject?>.btnSave, <?=$this->publicObject?>.btnCancel]);</script>
<?
				}
			}
			else
			{
				echo '
<input'.($aParams["disabled"] === true? " disabled":"").' type="submit" name="save" value="'.GetMessage("admin_lib_edit_save").'" title="'.GetMessage("admin_lib_edit_save_title").$hkInst->GetTitle("Edit_Save_Button").'" />
<input'.($aParams["disabled"] === true? " disabled":"").' type="submit" name="apply" value="'.GetMessage("admin_lib_edit_apply").'" title="'.GetMessage("admin_lib_edit_apply_title").$hkInst->GetTitle("Edit_Apply_Button").'" />
'.($aParams["back_url"] <> '' && !preg_match('/(javascript|data)[\s\0-\13]*:/i', $aParams["back_url"])? '<input type="button" value="'.GetMessage("admin_lib_edit_cancel").'" name="cancel" onClick="window.location=\''.htmlspecialcharsbx(CUtil::addslashes($aParams["back_url"])).'\'" title="'.GetMessage("admin_lib_edit_cancel_title").$hkInst->GetTitle("Edit_Cancel_Button").'" />':'');

			echo $hkInst->PrintJSExecs($hkInst->GetCodeByClassName("Edit_Save_Button"));
			echo $hkInst->PrintJSExecs($hkInst->GetCodeByClassName("Edit_Apply_Button"));
			echo $hkInst->PrintJSExecs($hkInst->GetCodeByClassName("Edit_Cancel_Button"));

			}
		}
	}

	function ButtonsPublic($arJSButtons = false)
	{
		while ($this->tabIndex < count($this->tabs))
			$this->BeginNextTab();

		$this->bButtons = true;
		$this->EndTab();

		if ($this->bPublicMode)
		{
			if (strlen($_REQUEST['from_module']))
				echo '<input type="hidden" name="from_module" value="'.htmlspecialcharsbx($_REQUEST['from_module']).'" />';

			if ($arJSButtons === false)
			{
?>
<input type="hidden" name="bxpublic" value="Y" /><input type="hidden" name="save" value="Y" />
<script type="text/javascript"><?=$this->publicObject?>.SetButtons([<?=$this->publicObject?>.btnSave, <?=$this->publicObject?>.btnCancel]);</script>
<?
			}
			elseif (is_array($arJSButtons))
			{
				$arJSButtons = array_values($arJSButtons);
?>
<input type="hidden" name="bxpublic" value="Y" />
<script type="text/javascript"><?=$this->publicObject?>.SetButtons([
<?
				foreach ($arJSButtons as $key => $btn)
				{
					if (substr($btn, 0, 1) == '.')
						$btn = $this->publicObject.$btn;
					echo $key ? ',' : '', $btn, "\r\n"; // NO JSESCAPE HERE! string must contain valid js object
				}
?>
]);</script>
<?
			}
		}
	}

	function End()
	{
		$hkInst = CHotKeys::getInstance();

		if(!$this->bButtons)
		{
			while ($this->tabIndex < count($this->tabs))
				$this->BeginNextTab();

			//end previous tab
			$this->EndTab();

			if (!$this->bPublicMode)
			{
				echo '
					</td>
				</tr>
			</table>
';
			}
		}
		elseif (!$this->bPublicMode)
		{
			echo '
</div>
';
		}

		if (!$this->bPublicMode)
		{
			echo '
		</td>
		<td class="right"><div class="empty"></div></td>
	</tr>
	<tr class="bottom">
		<td class="left"><div class="empty"></div></td>
		<td><div class="empty"></div></td>
		<td class="right"><div class="empty"></div></td>
	</tr>
</table>';
		}

		$Execs = $hkInst->GetCodeByClassName("CAdminTabControl");
		echo $hkInst->PrintJSExecs($Execs, $this->name);

		echo '
</div>

<input type="hidden" id="'.$this->name.'_active_tab" name="'.$this->name.'_active_tab" value="'.htmlspecialcharsbx($this->selectedTab).'">

<script>';
		$s = "";
		foreach($this->tabs as $tab)
		{
			$s .= ($s <> ""? ", ":"").
			"{".
			"'DIV': '".$tab["DIV"]."' ".
			($tab["ONSELECT"] <> ""? ", 'ONSELECT': '".CUtil::JSEscape($tab["ONSELECT"])."'":"").
			"}";
		}
		echo '
var '.$this->name.' = new TabControl("'.$this->name.'", "'.$this->unique_name.'", ['.$s.']);';
		if($this->bCanExpand && count($this->tabs) > 1)
		{
			$aEditOpt = CUserOptions::GetOption("edit", $this->unique_name, array());
			if($aEditOpt["expand"] == "on")
				echo '
'.$this->name.'.ToggleTabs();';
		}
		echo '
'.$this->name.'.InitEditTables('.($this->bPublicMode ? 'true' : '').');
jsUtils.addEvent(window, "unload", function(){'.$this->name.'.Destroy();});
</script>
';
		if ($this->bPublicModeBuffer)
		{
			echo '</div>';
			echo '<script type="text/javascript">BX.ready(function() {'.$this->publicObject.'.SwapContent(\''.$this->publicModeBuffer_id.'\');});</script>';
		}
	}

	function ActiveTabParam()
	{
		return $this->name."_active_tab=".urlencode($this->selectedTab);
	}

	//string, CAdminException, array("id"=>"name", ...)
	function ShowWarnings($form, $messages, $aFields=false)
	{
		if(!$messages)
			return;
		$aMess = $messages->GetMessages();
		if(empty($aMess) || !is_array($aMess))
			return;
		$s = "";
		foreach($aMess as $msg)
		{
			$field_name = (is_array($aFields)? $aFields[$msg["id"]] : $msg["id"]);
			if(empty($field_name))
				continue;
			$s .= ($s <> ""? ", ":"")."{'name':'".CUtil::JSEscape($field_name)."', 'title':'".CUtil::JSEscape(htmlspecialcharsback($msg["text"]))."'}";
		}
		echo '
<script>
'.$this->name.'.ShowWarnings("'.CUtil::JSEscape($form).'", ['.$s.']);
</script>
';
	}
}

/*View Tab Control*/
class CAdminViewTabControl
{
	var $name;
	var $tabs;
	var $selectedTab;
	var $tabIndex = 0;

	function CAdminViewTabControl($name, $tabs)
	{
		//array(array("DIV"=>"", "TAB"=>"", "ICON"=>, "TITLE"=>"", "ONSELECT"=>"javascript"), ...)
		$this->tabs = $tabs;
		$this->name = $name;
		if(isset($_REQUEST[$this->name."_active_tab"]))
			$this->selectedTab = $_REQUEST[$this->name."_active_tab"];
		else
			$this->selectedTab = $tabs[0]["DIV"];
	}

	function Begin()
	{
		echo '
<div class="view-tab-container">
';
		$i = 0;
		foreach($this->tabs as $tab)
		{
			if($i>0)
				echo '<div class="view-tab-delimiter"></div>'."\n";
			$bSelected = ($tab["DIV"] == $this->selectedTab);
			echo '<div class="view-tab'.($bSelected? " view-tab-active":"").'" id="view_tab_'.$tab["DIV"].'"><a href="javascript:'.$this->name.'.SelectTab(\''.$tab["DIV"].'\');" title="'.$tab["TITLE"].'">'.$tab["TAB"].'</a></div>'."\n";
			$i++;
		}
		echo '
<br class="tab-break">
<div class="view-tab-content">
';
	}

	function BeginNextTab()
	{
		//end previous tab
		$this->EndTab();

		if($this->tabIndex >= count($this->tabs))
			return;

		echo '
<div id="'.$this->tabs[$this->tabIndex]["DIV"].'"'.($this->tabs[$this->tabIndex]["DIV"] <> $this->selectedTab? ' style="display:none;"':'').'>
<div>
<div style="width:100%;">
<table cellpadding="0" cellspacing="0" border="0" class="edit-tab-title">
	<tr>
';
		if($this->tabs[$this->tabIndex]["ICON"] <> "")
			echo '
		<td class="icon"><div id="'.$this->tabs[$this->tabIndex]["ICON"].'"></div></td>
';
		echo '
		<td class="title">'.$this->tabs[$this->tabIndex]["TITLE"].'</td>
	</tr>
	<tr>
		<td colspan="2" class="delimiter"><div class="empty"></div></td>
	</tr>
</table>
';
		$this->tabIndex++;
	}

	function EndTab()
	{
		if($this->tabIndex < 1 || $this->tabIndex > count($this->tabs))
			return;
		echo '
</div>
</div>
</div>
';
	}

	function End()
	{
		$this->EndTab();
		echo '
</div>
</div>

<script>
';
$s = "";
foreach($this->tabs as $tab)
{
	$s .= ($s <> ""? ", ":"").
	"{".
	"'DIV': '".$tab["DIV"]."' ".
	($tab["ONSELECT"] <> ""? ", 'ONSELECT': '".CUtil::JSEscape($tab["ONSELECT"])."'":"").
	"}";
}
echo 'var '.$this->name.' = new ViewTabControl(['.$s.']);
</script>
';
	}
}

class CAdminList
{
	var $table_id;
	var $sort;
	var $aHeaders = array();
	var $aRows = array();
	var $aHeader = array();
	var $arVisibleColumns = array();
	var $aFooter = array();
	var $sNavText = '';
	var $arFilterErrors = Array();
	var $arUpdateErrors = array();
	var $arUpdateErrorIDs = Array();
	var $arGroupErrors = array();
	var $arGroupErrorIDs = Array();
	var $arActionSuccess = array();
	var $bEditMode = false;
	var $bMultipart = false;
	var $bCanBeEdited = false;
	var $arActions = Array();
	var $arActionsParams = Array();
	var $context = false;
	var $sContent = false, $sPrologContent = '', $sEpilogContent = '';
	var $bShowActions;
	var $onLoadScript;

	function CAdminList($table_id, $sort=false)
	{
		$this->table_id = $table_id;
		$this->sort = $sort;
	}

	//id, name, content, sort, default
	function AddHeaders($aParams)
	{
		if(isset($_REQUEST['showallcol']) && $_REQUEST['showallcol'])
			$_SESSION['SHALL'] = ($_REQUEST['showallcol']=='Y');

		$aOptions = CUserOptions::GetOption("list", $this->table_id, array());

		$aColsTmp = explode(",", $aOptions["columns"]);
		$aCols = array();
		foreach($aColsTmp as $col)
			if(trim($col)<>"")
				$aCols[] = trim($col);

		$bEmptyCols = empty($aCols);
		foreach($aParams as $param)
		{
			$this->aHeaders[$param["id"]] = $param;
			if(
				(isset($_SESSION['SHALL']) && $_SESSION['SHALL'])
				|| ($bEmptyCols && $param["default"]==true)
				|| in_array($param["id"], $aCols)
			)
				$this->arVisibleColumns[] = $param["id"];
		}

		if($_REQUEST["mode"] == "settings")
		{
			$aAllCols = array();
			foreach($this->aHeaders as $i=>$header)
				$aAllCols[$i] = $header;
		}

		if(!$bEmptyCols)
		{
			foreach($aCols as $i=>$col)
				if($this->aHeaders[$col] <> "")
					$this->aHeaders[$col]["__sort"] = $i;
			uasort($this->aHeaders, create_function('$a, $b', 'if($a["__sort"] == $b["__sort"]) return 0; return ($a["__sort"] < $b["__sort"])? -1 : 1;'));
		}

		if($_REQUEST["mode"] == "settings")
			$this->ShowSettings($aAllCols, $aCols, $aOptions);
	}

	function ShowSettings($aAllCols, $aCols, $aOptions)
	{
		if($this->sort)
		{
			if(empty($aOptions["by"]))
				$aOptions["by"] = $this->sort->by_initial;
			if(empty($aOptions["order"]))
				$aOptions["order"] = $this->sort->order_initial;
		}
		if(intval($aOptions["page_size"]) <= 0)
			$aOptions["page_size"] = 20;

		echo '
<div class="title">
<table cellspacing="0" width="100%">
	<tr>
		<td width="100%" class="title-text" onmousedown="jsFloatDiv.StartDrag(arguments[0], document.getElementById(\'settings_float_div\'));">'.GetMessage("admin_lib_sett_title").'</td>
		<td width="0%"><a class="close" href="javascript:'.$this->table_id.'.CloseSettings();" title="'.GetMessage("admin_lib_sett_close").'"></a></td>
	</tr>
</table>
</div>
<div class="content">
<form name="list_settings">
<h2>'.GetMessage("admin_lib_sett_cols").'</h2>
<table cellspacing="0">
	<tr>
		<td>'.GetMessage("admin_lib_sett_all").'</td>
		<td></td>
		<td>'.GetMessage("admin_lib_sett_sel").'</td>
		<td></td>
	</tr>
	<tr>
		<td>
			<select class="select" name="all_columns" id="list_settings_all_columns" size="10" multiple onchange="document.list_settings.add.disabled=(this.selectedIndex == -1);">
';
		$bNeedSort = false;
		foreach($aAllCols as $header)
		{
			echo '<option value="'.$header["id"].'">'.($header["name"]<>""? $header["name"]:$header["content"]).'</option>';
			if($header["sort"] <> "")
				$bNeedSort = true;
		}

		echo '
			</select>
		</td>
		<td><input type="button" name="add" value="'.'&nbsp; &gt; &nbsp;'.'" title="'.GetMessage("admin_lib_sett_sel_title").'" disabled onclick="jsSelectUtils.addSelectedOptions(document.list_settings.all_columns, \'list_settings_selected_columns\');"></td>
		<td>
			<select class="select" name="selected_columns" id="list_settings_selected_columns" size="10" multiple onchange="var frm=document.list_settings; frm.up.disabled=frm.down.disabled=frm.del.disabled=(this.selectedIndex == -1);">
';
		$bEmptyCols = empty($aCols);
		foreach($this->aHeaders as $header)
			if(($bEmptyCols && $header["default"]==true) || in_array($header["id"], $aCols))
				echo '<option value="'.$header["id"].'">'.($header["name"]<>""? $header["name"]:$header["content"]).'</option>';

		echo '
			</select>
		</td>
		<td>
			<input type="button" name="up" class="button" value="'.GetMessage("admin_lib_sett_up").'" title="'.GetMessage("admin_lib_sett_up_title").'" disabled onclick="jsSelectUtils.moveOptionsUp(document.list_settings.selected_columns);"><br>
			<input type="button" name="down" class="button" value="'.GetMessage("admin_lib_sett_down").'" title="'.GetMessage("admin_lib_sett_down_title").'" disabled onclick="jsSelectUtils.moveOptionsDown(document.list_settings.selected_columns);"><br>
			<input type="button" name="del" class="button" value="'.GetMessage("admin_lib_sett_del").'" title="'.GetMessage("admin_lib_sett_del_title").'" disabled onclick="jsSelectUtils.deleteSelectedOptions(\'list_settings_selected_columns\'); document.list_settings.selected_columns.onchange();"><br>
		</td>
	</tr>
</table>
<h2>'.GetMessage("admin_lib_sett_def_title").'</h2>
<table cellspacing="0">
';
		if($this->sort && $bNeedSort)
		{
			echo '
	<tr>
		<td>'.GetMessage("admin_lib_sett_sort").'</td>
		<td>
			<select name="order_field">
';
		$by = strtoupper($aOptions["by"]);
		$order = strtoupper($aOptions["order"]);
		foreach($aAllCols as $header)
			if($header["sort"] <> "")
				echo '<option value="'.$header["sort"].'"'.($by == strtoupper($header["sort"])? ' selected':'').'>'.($header["name"]<>""? $header["name"]:$header["content"]).'</option>';

		echo '
			</select>
		</td>
		<td>
			<select name="order_direction">
				<option value="desc"'.($order == "DESC"? ' selected':'').'>'.GetMessage("admin_lib_sett_desc").'</option>
				<option value="asc"'.($order == "ASC"? ' selected':'').'>'.GetMessage("admin_lib_sett_asc").'</option>
			</select>
		</td>
	</tr>
';
		}
		echo '
	<tr>
		<td>'.GetMessage("admin_lib_sett_rec").'</td>
		<td colspan="2">
			<select name="nav_page_size">
';
		$aSizes = array(10, 20, 50, 100, 200, 500);
		foreach($aSizes as $size)
			echo '<option value="'.$size.'"'.($aOptions["page_size"] == $size? ' selected':'').'>'.$size.'</option>';
		echo '
			</select>
		</td>
	</tr>
</table>
';
		if($GLOBALS["USER"]->CanDoOperation('edit_other_settings'))
		{
			echo '
<h2>'.GetMessage("admin_lib_sett_common").'</h2>
<table cellspacing="0">
	<tr>
		<td><input type="checkbox" name="set_default" id="set_default" value="Y"></td>
		<td><label for="set_default">'.GetMessage("admin_lib_sett_common_set").'</label></td>
		<td>|</td>
		<td><a class="delete-icon" title="'.GetMessage("admin_lib_sett_common_del").'" href="javascript:if(confirm(\''.GetMessage("admin_lib_sett_common_del_conf").'\'))'.$this->table_id.'.DeleteSettings(true)"></a></td>
	</tr>
</table>
';
		}
		echo '
</form>
</div>
<div class="buttons">
	<input type="button" value="'.GetMessage("admin_lib_sett_save").'" onclick="'.$this->table_id.'.SaveSettings()" title="'.GetMessage("admin_lib_sett_save_title").'">
	<input type="button" value="'.GetMessage("admin_lib_sett_cancel").'" onclick="'.$this->table_id.'.CloseSettings()" title="'.GetMessage("admin_lib_sett_cancel_title").'">
	<input type="button" value="'.GetMessage("admin_lib_sett_reset").'" onclick="if(confirm(\''.GetMessage("admin_lib_sett_reset_ask").'\'))'.$this->table_id.'.DeleteSettings()" title="'.GetMessage("admin_lib_sett_reset_title").'">
</div>
';
		require($_SERVER["DOCUMENT_ROOT"].BX_ROOT."/modules/main/include/epilog_admin_after.php");
		die();
	}

	function AddVisibleHeaderColumn($id)
	{
		if (!in_array($id, $this->arVisibleColumns))
			$this->arVisibleColumns[] = $id;
	}

	function GetVisibleHeaderColumns()
	{
		return $this->arVisibleColumns;
	}

	function AddAdminContextMenu($aContext=array(), $bShowExcel=true, $bShowSettings=true)
	{
		$bNeedSep = (count($aContext)>0);
		if($bShowSettings)
		{
			if($bNeedSep)
			{
				$aContext[] = array("SEPARATOR"=>true);
				$bNeedSep = false;
			}
			$link = DeleteParam(array("mode"));
			$link = $GLOBALS["APPLICATION"]->GetCurPage()."?mode=settings".($link <> ""? "&".$link:"");
			$aContext[] = array(
				"TEXT"=>GetMessage("admin_lib_context_sett"),
				"TITLE"=>GetMessage("admin_lib_context_sett_title"),
				"LINK"=>"javascript:".$this->table_id.".ShowSettings('".urlencode($link)."')",
				"ICON"=>"btn_settings",
			);
		}
		if($bShowExcel)
		{
			if($bNeedSep)
				$aContext[] = array("SEPARATOR"=>true);
			$link = DeleteParam(array("mode"));
			$link = $GLOBALS["APPLICATION"]->GetCurPage()."?mode=excel".($link <> ""? "&".$link:"");
			$aContext[] = array(
				"TEXT"=>"Excel",
				"TITLE"=>GetMessage("admin_lib_excel"),
				"LINK"=>htmlspecialcharsbx($link),
				"ICON"=>"btn_excel",
			);
		}
		if(count($aContext)>0)
			$this->context = new CAdminContextMenu($aContext);
	}

	function IsUpdated($ID)
	{
		$f = $_REQUEST['FIELDS'][$ID];
		$f_old = $_REQUEST['FIELDS_OLD'][$ID];

		if(!is_array($f) || !is_array($f_old))
			return true;

		foreach($f as $k=>$v)
		{
			if(is_array($v))
			{
				if(!is_array($f_old[$k]))
					return true;
				else
				{
					foreach($v as $k2 => $v2)
					{
						if($f_old[$k][$k2] != $v2)
							return true;
						unset($f_old[$k][$k2]);
					}
					if(count($f_old[$k]) > 0)
						return true;
				}
			}
			else
			{
				if(is_array($f_old[$k]))
					return true;
				elseif($f_old[$k] != $v)
					return true;
			}
			unset($f_old[$k]);
		}
		if(count($f_old) > 0)
			return true;

		return false;
	}

	function EditAction()
	{
		if($_SERVER['REQUEST_METHOD']=='POST' && isset($_REQUEST['save'])  && check_bitrix_sessid())
		{
			if(is_array($GLOBALS["FIELDS"]))
			{
				foreach($GLOBALS["FIELDS"] as $id=>$fields)
				{
					if(is_array($fields))
					{
						$keys = array_keys($fields);
						foreach($keys as $key)
						{
							if(($c = substr($key, 0, 1)) == '~' || $c == '=')
							{
								unset($_POST["FIELDS"][$id][$key]);
								unset($_REQUEST["FIELDS"][$id][$key]);
								unset($GLOBALS["FIELDS"][$id][$key]);
							}
						}
					}
				}
			}
			return true;
		}
		return false;
	}

	function GroupAction()
	{
		//AddMessage2Log("GroupAction");
		if(!empty($_REQUEST['action_button']))
			$_REQUEST['action'] = $_REQUEST['action_button'];

		if(!isset($_REQUEST['action']) || !check_bitrix_sessid())
			return false;

		//AddMessage2Log("GroupAction = ".$_REQUEST['action']." & ".($this->bCanBeEdited?'bCanBeEdited':'ne'));
		if($_REQUEST['action_button']=="edit")
		{
			if(isset($_REQUEST['ID']))
			{
				if(!is_array($_REQUEST['ID']))
					$arID = Array($_REQUEST['ID']);
				else
					$arID = $_REQUEST['ID'];

				$this->arEditedRows = $arID;
				$this->bEditMode = true;
			}
			return false;
		}

		//AddMessage2Log("GroupAction = X");
		$arID = Array();
		if($_REQUEST['action_target']!='selected')
		{
			if(!is_array($_REQUEST['ID']))
				$arID = Array($_REQUEST['ID']);
			else
				$arID = $_REQUEST['ID'];
		}
		else
			$arID = Array('');

		return $arID;
	}

	function ActionRedirect($url)
	{
		$url = htmlspecialcharsback($url);
		if(strpos($url, "lang=")===false)
		{
			if(strpos($url, "?")===false)
				$url .= '?';
			else
				$url .= '&';
			$url .= 'lang='.LANGUAGE_ID;
		}
		return "jsUtils.Redirect([], '".CUtil::AddSlashes($url)."');";
	}

	function ActionAjaxReload($url)
	{
		if(strpos($url, "lang=")===false)
		{
			if(strpos($url, "?")===false)
				$url .= '?';
			else
				$url .= '&';
			$url .= 'lang='.LANGUAGE_ID;
		}
		return $this->table_id.".GetAdminList('".CUtil::AddSlashes($url)."');";
	}

	function ActionPost($url = false)
	{
		$res = '';
		if($url)
		{
			if(strpos($url, "lang=")===false)
			{
				if(strpos($url, "?")===false)
					$url .= '?';
				else
					$url .= '&';
				$url .= 'lang='.LANGUAGE_ID;
			}

			if(strpos($url, "mode=")===false)
				$url .= '&mode=frame';

			$res = 'document.getElementById(\'form_'.$this->table_id.'\').action=\''.CUtil::AddSlashes($url).'\';';
		}

		return $res.'
			document.getElementById(\'form_'.$this->table_id.'\').onsubmit();
			document.getElementById(\'form_'.$this->table_id.'\').submit();';
	}

	function ActionDoGroup($id, $action_id, $add_params='')
	{
		global $APPLICATION;
		return $this->table_id.".GetAdminList('".CUtil::AddSlashes($APPLICATION->GetCurPage())."?ID=".CUtil::AddSlashes($id)."&action=".CUtil::AddSlashes($action_id)."&lang=".LANGUAGE_ID."&".bitrix_sessid_get().($add_params<>""?"&".CUtil::AddSlashes($add_params):"")."');";
	}

	function InitFilter($arFilterFields)
	{
		$sTableID = $this->table_id;
		global $del_filter, $set_filter;
		if($del_filter <> "")
			DelFilterEx($arFilterFields, $sTableID);
		elseif($set_filter <> "")
		{
			CAdminFilter::UnEscape($arFilterFields);
			InitFilterEx($arFilterFields, $sTableID, "set");
		}
		else
			InitFilterEx($arFilterFields, $sTableID, "get");
	}

	function IsDefaultFilter()
	{
		global $set_default;
		$sTableID = $this->table_id;
		return $set_default=="Y" && (!isset($_SESSION["SESS_ADMIN"][$sTableID]) || empty($_SESSION["SESS_ADMIN"][$sTableID]));
	}

	function &AddRow($id = false, $arRes = Array(), $link = false, $title = false)
	{
		$row = new CAdminListRow($this->aHeaders, $this->table_id);
		$row->id = $id;
		$row->arRes = $arRes;
		$row->link = $link;
		$row->title = $title;
		$row->pList = &$this;

		if($id)
		{
			if($this->bEditMode && in_array($id, $this->arEditedRows))
				$row->bEditMode = true;
			elseif(in_array($id, $this->arUpdateErrorIDs))
				$row->bEditMode = true;
		}

		$this->aRows[] = &$row;
		return $row;
	}

	function AddFooter($aFooter)
	{
		$this->aFooter = $aFooter;
	}

	function NavText($sNavText)
	{
		$this->sNavText = $sNavText;
	}

	function Display()
	{
		global $APPLICATION;

		$db_events = GetModuleEvents("main", "OnAdminListDisplay");
		while($arEvent = $db_events->Fetch())
			ExecuteModuleEventEx($arEvent, array(&$this));

		if($this->context)
			$this->context->Show();

		if(
			(isset($_REQUEST['ajax_debugx']) && $_REQUEST['ajax_debugx']=='Y')
			|| (isset($_SESSION['AJAX_DEBUGX']) && $_SESSION['AJAX_DEBUGX'])
		)
			echo '<form method="POST" '.($this->bMultipart?'  ENCTYPE="multipart/form-data" ':'').' onsubmit="CheckWin();ShowWaitWindow();'.$this->table_id.'.SetActiveResult();" target="frame_debug" id="form_'.$this->table_id.'" name="form_'.$this->table_id.'" action="'.htmlspecialcharsbx($APPLICATION->GetCurPageParam("mode=frame", Array("mode"))).'">';
		else
			echo '<form method="POST" '.($this->bMultipart?'  ENCTYPE="multipart/form-data" ':'').' onsubmit="ShowWaitWindow();'.$this->table_id.'.SetActiveResult();" target="frame_'.$this->table_id.'" id="form_'.$this->table_id.'" name="form_'.$this->table_id.'" action="'.htmlspecialcharsbx($APPLICATION->GetCurPageParam("mode=frame", Array("mode"))).'">';

		if($this->bEditMode && !$this->bCanBeEdited)
			$this->bEditMode = false;

		$errmsg = '';
		for($i=0; $i<count($this->arFilterErrors); $i++)
			$errmsg .= ($errmsg<>''?'<br>':'').$this->arFilterErrors[$i];
		for($i=0; $i<count($this->arUpdateErrors); $i++)
			$errmsg .= ($errmsg<>''?'<br>':'').$this->arUpdateErrors[$i][0];
		for($i=0; $i<count($this->arGroupErrors); $i++)
			$errmsg .= ($errmsg<>''?'<br>':'').$this->arGroupErrors[$i][0];
		if($errmsg<>'')
			CAdminMessage::ShowMessage(array("MESSAGE"=>GetMessage("admin_lib_error"), "DETAILS"=>$errmsg, "TYPE"=>"ERROR"));

		$successMessage = '';
		for ($i = 0, $cnt = count($this->arActionSuccess); $i < $cnt; $i++)
			$successMessage .= ($successMessage != '' ? '<br>' : '').$this->arActionSuccess[$i];
		if ($successMessage != '')
			CAdminMessage::ShowMessage(array("MESSAGE" => GetMessage("admin_lib_success"), "DETAILS" => $successMessage, "TYPE" => "OK"));

		if($this->sContent!==false)
		{
			echo $this->sContent;
			echo '</form>';
			return;
		}

		echo $this->sPrologContent;

		//!!! insert filter's hiddens
		echo bitrix_sessid_post();
		echo $this->sNavText;
		echo '<table cellspacing="0" class="list" id="'.$this->table_id.'">';

		$bShowSelectAll = (count($this->arActions)>0 || $this->bCanBeEdited);
		$this->bShowActions = false;
		foreach($this->aRows as $row)
		{
			if(!empty($row->aActions))
			{
				$this->bShowActions = true;
				break;
			}
		}

		echo '<tr class="gutter">';
		if($bShowSelectAll)
			echo '<td><div class="empty"></div></td>';
		if($this->bShowActions)
			echo '<td><div class="empty"></div></td>';
		foreach($this->aHeaders as $column_id=>$header)
			if(in_array($column_id, $this->arVisibleColumns))
				echo '<td><div class="empty"></div></td>';
		echo '</tr>';
		echo '<tr class="head">';

		$colSpan = 0;
		if($bShowSelectAll)
		{
			echo '<td><input type="checkbox" name="" id="'.$this->table_id.'_check_all" value="" title="'.GetMessage("admin_lib_list_check_all").'" onClick="'.$this->table_id.'.SelectAllRows(this);"></td>';
			$colSpan++;
		}
		if($this->bShowActions)
		{
			echo '<td title="'.GetMessage("admin_lib_list_act").'"><div class="action"></div></td>';
			$colSpan++;
		}
		foreach($this->aHeaders as $column_id=>$header)
		{
			if(!in_array($column_id, $this->arVisibleColumns))
				continue;

			echo '<td>';
			if($this->sort && !empty($header["sort"]))
				echo $this->sort->Show($header["content"], $header["sort"], $header["title"]);
			else
				echo $header["content"];
			echo '</td>';
			$colSpan++;
		}
		echo '</tr>';

		if(!empty($this->aRows))
		{
			foreach($this->aRows as $row)
				$row->Display();
		}
		elseif(!empty($this->aHeaders))
			echo '<tr><td colspan="'.$colSpan.'">'.GetMessage("admin_lib_no_data").'</td></tr>';

		echo '</table>';

		if(!empty($this->aFooter))
		{
			echo '
<table cellpadding="0" cellspacing="0" border="0" class="listfooter">
	<tr>
';
			$n = count($this->aFooter);
			for($i=0; $i<$n; $i++)
				echo '<td'.($i==0? ' class="left"':'').'>'.$this->aFooter[$i]["title"].' <span'.($this->aFooter[$i]["counter"]===true? ' id="'.$this->table_id.'_selected_span"':'').'>'.$this->aFooter[$i]["value"].'</span></td>';
			echo '
		<td class="right">&nbsp;</td>
	</tr>
</table>
';
		}
		echo $this->sNavText;
		$this->ShowActionTable();

		echo $this->sEpilogContent;
		echo '</form>';
	}

	function DisplayExcel()
	{
		global $APPLICATION;
		echo '
		<html>
		<head>
		<title>'.$APPLICATION->GetTitle().'</title>
		<meta http-equiv="Content-Type" content="text/html; charset='.LANG_CHARSET.'">
		<style>
			.number0 {mso-number-format:0;}
			.number2 {mso-number-format:Fixed;}
		</style>
		</head>
		<body>';

		echo "<table border=\"1\">";
		echo "<tr>";

		foreach($this->aHeaders as $column_id=>$header)
		{
			if(!in_array($column_id, $this->arVisibleColumns))
				continue;
			echo '<td>';
			echo $header["content"];
			echo '</td>';
		}
		echo "</tr>";


		foreach($this->aRows as $row)
		{
			echo "<tr>";
			foreach($row->aHeaders as $id=>$header_props)
			{
				if(!in_array($id, $row->pList->arVisibleColumns))
					continue;

				$field = $row->aFields[$id];
				if(!is_array($row->arRes[$id]))
					$val = trim($row->arRes[$id]);
				else
					$val = $row->arRes[$id];

				switch($field["view"]["type"])
				{
					case "checkbox":
						if($val=='Y')
							$val = GetMessage("admin_lib_list_yes");
						else
							$val = GetMessage("admin_lib_list_no");
						break;
					case "select":
						if($field["edit"]["values"][$val])
							$val = $field["edit"]["values"][$val];
						break;
					case "input":
						break;
				}

				if($field["view"]['type']=='html')
					$val = $field["view"]['value'];
				else
					$val = htmlspecialcharsex($val);

				echo '<td'.($header_props['align']?' align="'.$header_props['align'].'"':'').($header_props['valign']?' valign="'.$header_props['valign'].'"':'').'>';
				echo ($val<>""? $val:'&nbsp;').'</td>';
			}
			echo "</tr>";
		}

		echo "</table>";

		if(!empty($this->aFooter))
		{
			echo '<table border="1"><tr>';

			$n = count($this->aFooter);
			for($i=0; $i<$n; $i++)
				echo '<td>'.$this->aFooter[$i]["title"].' '.$this->aFooter[$i]["value"].'</td>';

			echo '</tr></table>';
		}

		echo '</body></html>';
	}


	function AddGroupActionTable($arActions, $arParams=array())
	{
		//array("action"=>"text", ...)
		//OR array(array("action" => "custom JS", "value" => "action", "type" => "button", "title" => "", "name" => ""), ...)
		$this->arActions = $arActions;
		//array("disable_action_target"=>true, "select_onchange"=>"custom JS")
		$this->arActionsParams = $arParams;
	}

	function ShowActionTable()
	{
		global $APPLICATION;
		if(count($this->arActions)<=0 && !$this->bCanBeEdited)
			return;

		echo '
<div class="multiaction">
<input type="hidden" name="action_button" value="">
<table cellpadding="0" cellspacing="0" border="0" class="multiaction">
	<tr class="top"><td class="left"><div class="empty"></div></td><td><div class="empty"></div></td><td class="right"><div class="empty"></div></td></tr>
	<tr>
		<td class="left"><div class="empty"></div></td>
		<td class="content">
			<table cellpadding="0" cellspacing="0" border="0">
				<tr>
';

		if($this->bEditMode || count($this->arUpdateErrorIDs)>0)
		{
			echo '
		<td>
			<input type="submit" name="save" value="'.GetMessage("admin_lib_list_edit_save").'" title="'.GetMessage("admin_lib_list_edit_save_title").'">
			<input type="submit" name="cancel" value="'.GetMessage("admin_lib_list_edit_cancel").'" title="'.GetMessage("admin_lib_list_edit_cancel_title").'">
		</td>
';
		}
		else
		{
			$bNeedSep = false;
			if($this->arActionsParams["disable_action_target"] <> true)
			{
				echo '
		<td>
			<input title="'.GetMessage("admin_lib_list_edit_for_all").'" type="checkbox" name="action_target" id="action_target" value="selected" onclick="if(this.checked && !confirm(\''.GetMessage("admin_lib_list_edit_for_all_warn").'\')) {this.checked=false;} '.$this->table_id.'.EnableActions();">
		</td>
		<td><label title="'.GetMessage("admin_lib_list_edit_for_all").'" for="action_target">'.GetMessage("admin_lib_list_for_all").'</label></td>
';
				$bNeedSep = true;
			}

			if($this->bCanBeEdited)
			{
				if($bNeedSep)
					echo '<td><div class="separator"></div></td>';
				$bNeedSep = true;
				echo '
		<td><a href="javascript:void(0);" hidefocus="true" onClick="this.blur();if('.$this->table_id.'.IsActionEnabled(\'edit\')){document.forms[\'form_'.$this->table_id.'\'].elements[\'action_button\'].value=\'edit\'; '.htmlspecialcharsbx($this->ActionPost()).'}" title="'.GetMessage("admin_lib_list_edit").'" class="context-button icon action-edit-button-dis" id="action_edit_button"></a></td>
';
			}

			$list = "";
			$buttons = "";
			$html = "";
			foreach($this->arActions as $k=>$v)
			{
				if($k === "delete")
				{
					if($bNeedSep && !$this->bCanBeEdited)
						echo '
		<td><div class="separator"></div></td>
';
					$bNeedSep = true;
					echo '
		<td><a href="javascript:void(0);" hidefocus="true" onClick="this.blur();if('.$this->table_id.'.IsActionEnabled() && confirm((document.getElementById(\'action_target\') && document.getElementById(\'action_target\').checked? \''.GetMessage("admin_lib_list_del").'\':\''.GetMessage("admin_lib_list_del_sel").'\'))) {document.forms[\'form_'.$this->table_id.'\'].elements[\'action_button\'].value=\'delete\'; '.htmlspecialcharsbx($this->ActionPost()).'}" title="'.GetMessage("admin_lib_list_del_title").'" class="context-button icon action-delete-button-dis" id="action_delete_button"></a></td>
';
				}
				else
				{
					if(is_array($v))
					{
						if($v["type"] == "button")
							$buttons .= '<td><input type="button" name="" value="'.htmlspecialcharsbx($v['name']).'" onclick="'.(!empty($v["action"])? str_replace("\"", "&quot;", $v['action']) : 'document.forms[\'form_'.$this->table_id.'\'].elements[\'action_button\'].value=\''.htmlspecialcharsbx($v["value"]).'\'; '.htmlspecialcharsbx($this->ActionPost()).'').'" title="'.htmlspecialcharsbx($v["title"]).'"></td>';
						elseif($v["type"] == "html")
							$html .= '<td>'.$v["value"].'</td>';
						else
							$list .= '<option value="'.htmlspecialcharsbx($v['value']).'"'.($v['action']?' custom_action="'.str_replace("\"", "&quot;", $v['action']).'"':'').'>'.htmlspecialcharsex($v['name']).'</option>';
					}
					else
						$list .= '<option value="'.htmlspecialcharsbx($k).'">'.htmlspecialcharsex($v).'</option>';
				}
			}

			if($buttons <> "")
			{
				if($bNeedSep)
					echo '<td><div class="separator"></div></td>';
				$bNeedSep = true;
				echo $buttons;
			}

			if($list <> "")
			{
				if($bNeedSep)
					echo '<td><div class="separator"></div></td>';
				echo '
		<td>
			<select name="action"'.($this->arActionsParams["select_onchange"] <> ""? ' onchange="'.htmlspecialcharsbx($this->arActionsParams["select_onchange"]).'"':'').'>
				<option value="">'.GetMessage("admin_lib_list_actions").'</option>
				'.$list.'
			</select>
		</td>'.
		$html.'
		<td><input type="submit" name="apply" value="'.GetMessage("admin_lib_list_apply").'" onclick="if(this.form.action[this.form.action.selectedIndex].getAttribute(\'custom_action\')){eval(this.form.action[this.form.action.selectedIndex].getAttribute(\'custom_action\'));return false;}" disabled></td>
';
			}
		}
		echo '
				</tr>
			</table>
		</td>
		<td class="right"><div class="empty"></div></td>
	</tr>
	<tr class="bottom"><td class="left"><div class="empty"></div></td><td><div class="empty"></div></td><td class="right"><div class="empty"></div></td></tr>
</table>
</div>
';
	}

	function DisplayList()
	{
		global $APPLICATION;
		$menu = new CAdminPopup($this->table_id."_menu", $this->table_id."_menu");
		$menu->Show();

		if(
			(isset($_REQUEST['ajax_debugx']) && $_REQUEST['ajax_debugx']=='Y')
			|| (isset($_SESSION['AJAX_DEBUGX']) && $_SESSION['AJAX_DEBUGX'])
		)
		{
			echo '<script>
				function CheckWin()
				{
					window.open("about:blank", "frame_debug");
				}
				</script>';
		}
		else
		{
			echo '<iframe src="javascript:\'\'" id="frame_'.$this->table_id.'" name="frame_'.$this->table_id.'" style="width:1px; height:1px; border:0px; position:absolute; left:-10px; top:-10px; z-index:0;"></iframe>';
		}
		echo '<div id="'.$this->table_id.'_result_div">';
		$this->Display();
		echo '</div>';

		$tbl = CUtil::AddSlashes($this->table_id);
		echo '
<script>
var '.$this->table_id.' = new JCAdminList("'.$tbl.'");
'.$this->table_id.'.InitTable();
jsAdminChain.AddItems("'.$tbl.'_navchain_div");
jsUtils.addEvent(window, "unload", function(){'.$this->table_id.'.Destroy(true);});
</script>
';
	}

	function AddUpdateError($strError, $id = false)
	{
		$this->arUpdateErrors[] = Array($strError, $id);
		$this->arUpdateErrorIDs[] = $id;
	}

	function AddGroupError($strError, $id = false)
	{
		$this->arGroupErrors[] = Array($strError, $id);
		$this->arGroupErrorIDs[] = $id;
	}

	function AddActionSuccessMessage($strMessage)
	{
		$this->arActionSuccess[] = $strMessage;
	}

	function AddFilterError($strError)
	{
		$this->arFilterErrors[] = $strError;
	}

	function BeginPrologContent()
	{
		ob_start();
	}

	function EndPrologContent()
	{
		$this->sPrologContent .= ob_get_contents();
		ob_end_clean();
	}

	function BeginEpilogContent()
	{
		ob_start();
	}

	function EndEpilogContent()
	{
		$this->sEpilogContent = ob_get_contents();
		ob_end_clean();
	}

	function BeginCustomContent()
	{
		ob_start();
	}

	function EndCustomContent()
	{
		$this->sContent = ob_get_contents();
		ob_end_clean();
	}

	function CreateChain()
	{
		return new CAdminChain($this->table_id."_navchain_div", false);
	}

	function ShowChain($chain)
	{
		$this->BeginPrologContent();
		$chain->Show();
		$this->EndPrologContent();
	}

	function CheckListMode()
	{
		if($_REQUEST["mode"]=='list' || $_REQUEST["mode"]=='frame')
		{
			ob_start();
			$this->Display();
			$string = ob_get_contents();
			ob_end_clean();

			if($_REQUEST["mode"]=='frame')
			{
				echo '<html><head>';
				echo '</head><body>
<div id="'.$this->table_id.'_result_frame_div">'.$string.'</div>
<script>
var w = (opener? opener.window:parent.window);
w.CloseWaitWindow();
w.'.$this->table_id.'.Destroy(false);
var frameResultDiv = document.getElementById("'.$this->table_id.'_result_frame_div");
var targetResultDiv = w.document.getElementById("'.$this->table_id.'_result_div");
targetResultDiv.innerHTML = frameResultDiv.innerHTML;
w.'.$this->table_id.'.InitTable();
w.jsAdminChain.AddItems("'.$this->table_id.'_navchain_div");
';
				if(isset($this->onLoadScript))
					echo 'w.eval(\''.CUtil::JSEscape($this->onLoadScript).'\');';
				echo '</script></body></html>';
			}
			else
			{
				if(isset($this->onLoadScript))
					echo "<script>".$this->onLoadScript."</script>";
				echo $string;
			}
			define("ADMIN_AJAX_MODE", true);
			require($_SERVER["DOCUMENT_ROOT"].BX_ROOT."/modules/main/include/epilog_admin_after.php");
			die();
		}
		elseif($_REQUEST["mode"]=='excel')
		{
			$fname = basename($GLOBALS["APPLICATION"]->GetCurPage(), ".php");
			// http response splitting defence
			$fname = str_replace(array("\r", "\n"), "", $fname);

			header("Content-Type: application/vnd.ms-excel");
			header("Content-Disposition: filename=".$fname.".xls");
			$this->DisplayExcel();
			require($_SERVER["DOCUMENT_ROOT"].BX_ROOT."/modules/main/include/epilog_admin_after.php");
			die();
		}
	}
}

class CAdminListRow
{
	var $aHeaders = array();
	var $aHeadersID = array();
	var $aFields = array();
	var $aActions = array();
	var $table_id;
	var $indexFields = 0;
	var $edit = false;
	var $id;
	var $bReadOnly = false;
	var $aFeatures = array();
	var $bEditMode = false;

	function CAdminListRow(&$aHeaders, $table_id)
	{
		$this->aHeaders = $aHeaders;
		$this->aHeadersID = array_keys($aHeaders);
		$this->table_id = $table_id;
	}

	function SetFeatures($aFeatures)
	{
		//array("footer"=>true)
		$this->aFeatures = $aFeatures;
	}

	function AddField($id, $text, $edit=false)
	{
		$this->aFields[$id] = array();
		if($edit)
		{
			$this->aFields[$id]["edit"] = Array("type"=>"html", "value"=>$edit);
			$this->pList->bCanBeEdited = true;
		}
		$this->aFields[$id]["view"] = Array("type"=>"html", "value"=>$text);
	}

	function AddCheckField($id, $arAttributes = Array())
	{
		if($arAttributes!==false)
		{
			$this->aFields[$id]["edit"] = Array("type"=>"checkbox", "attributes"=>$arAttributes);
			$this->pList->bCanBeEdited = true;
		}
		$this->aFields[$id]["view"] = Array("type"=>"checkbox");
	}

	function AddSelectField($id, $arValues = Array(), $arAttributes = Array())
	{
		if($arAttributes!==false)
		{
			$this->aFields[$id]["edit"] = Array("type"=>"select", "values"=>$arValues, "attributes"=>$arAttributes);
			$this->pList->bCanBeEdited = true;
		}
		$this->aFields[$id]["view"] = Array("type"=>"select", "values"=>$arValues);
	}

	function AddInputField($id, $arAttributes = Array())
	{
		if($arAttributes!==false)
		{
			$this->aFields[$id]["edit"] = Array("type"=>"input", "attributes"=>$arAttributes);
			$this->pList->bCanBeEdited = true;
		}
	}

	function AddCalendarField($id, $arAttributes = Array())
	{
		if($arAttributes!==false)
		{
			$this->aFields[$id]["edit"] = Array("type"=>"calendar", "attributes"=>$arAttributes);
			$this->pList->bCanBeEdited = true;
		}
	}

	function AddViewField($id, $sHTML)
	{
		$this->aFields[$id]["view"] = Array("type"=>"html", "value"=>$sHTML);
	}

	function AddEditField($id, $sHTML)
	{
		$this->aFields[$id]["edit"] = Array("type"=>"html", "value"=>$sHTML);
		$this->pList->bCanBeEdited = true;
	}


	function AddActions($aActions)
	{
		$this->aActions = $aActions;
	}

	function __AttrGen($attr)
	{
		$res = '';
		foreach($attr as $name=>$val)
			$res .= ' '.htmlspecialcharsbx($name).'="'.htmlspecialcharsbx($val).'"';

		return $res;
	}

	function VarsFromForm()
	{
		return ($this->bEditMode && is_array($this->pList->arUpdateErrorIDs) && in_array($this->id, $this->pList->arUpdateErrorIDs));
	}

	function Display()
	{
		$sDefAction = $sDefTitle = "";
		if(!$this->bEditMode)
		{
			if(!empty($this->link))
			{
				$sDefAction = "jsUtils.Redirect([], '".CUtil::addslashes($this->link)."');";
				$sDefTitle = $this->title;
			}
			else
			{
				foreach($this->aActions as $action)
					if($action["DEFAULT"] == true)
					{
						$sDefAction = htmlspecialcharsbx($action["ACTION"]);
						$sDefTitle = (!empty($action["TITLE"])? $action["TITLE"]:$action["TEXT"]);
						break;
					}
			}
		}

		$sMenuItems = "";
		if(!empty($this->aActions))
			$sMenuItems = htmlspecialcharsbx(CAdminPopup::PhpToJavaScript($this->aActions));

		$aUserOpt = CUserOptions::GetOption("global", "settings");
		echo '<tr'.(isset($this->aFeatures["footer"]) && $this->aFeatures["footer"] == true? ' class="footer"':'').($sMenuItems <> "" && $aUserOpt["context_menu"]<>"N"? ' oncontextmenu="return '.$sMenuItems.';"':'').($sDefAction <> ""? ' ondblclick="'.$sDefAction.'"'.(!empty($sDefTitle)? ' title="'.GetMessage("admin_lib_list_double_click").' '.$sDefTitle.'"':''):'').'>';

		if(count($this->pList->arActions)>0 || $this->pList->bCanBeEdited)
			echo '<td><input type="checkbox" name="ID[]" value="'.$this->id.'" title="'.GetMessage("admin_lib_list_check").'"'.($this->bReadOnly? ' disabled':'').'></td>';

		if($this->pList->bShowActions)
		{
			if(!empty($this->aActions))
			{
				echo '
	<td align="center">
		<table cellspacing="0">
			<tr>
				<td><a href="javascript:void(0);" hidefocus="true" onclick="this.blur();'.$this->table_id."_menu".'.ShowMenu(this, '.$sMenuItems.');return false;" title="'.GetMessage("admin_lib_list_actions_title").'" class="action context-button icon">'.'<img src="'.ADMIN_THEMES_PATH.'/'.ADMIN_THEME_ID.'/images/arr_down.gif" class="arrow" alt=""></a></td>
			</tr>
		</table>
	</td>
	';
			}
			else
				echo '<td>&nbsp;</td>';
		}

		$bVarsFromForm = ($this->bEditMode && is_array($this->pList->arUpdateErrorIDs) && in_array($this->id, $this->pList->arUpdateErrorIDs));
		foreach($this->aHeaders as $id=>$header_props)
		{
			if(!in_array($id, $this->pList->arVisibleColumns))
				continue;

			$field = $this->aFields[$id];
			if($this->bEditMode && isset($field["edit"]))
			{
				if($bVarsFromForm && $_REQUEST["FIELDS"])
					$val = $_REQUEST["FIELDS"][$this->id][$id];
				else
					$val = $this->arRes[$id];

				$val_old = $this->arRes[$id];

				echo '<td'.($header_props['align']?' align="'.$header_props['align'].'"':'').($header_props['valign']?' valign="'.$header_props['valign'].'"':'').'>';
				if(is_array($val_old))
				{
					foreach($val_old as $k=>$v)
						echo '<input type="hidden" name="FIELDS_OLD['.htmlspecialcharsbx($this->id).']['.htmlspecialcharsbx($id).']['.htmlspecialcharsbx($k).']" value="'.htmlspecialcharsbx($v).'">';
				}
				else
				{
					echo '<input type="hidden" name="FIELDS_OLD['.htmlspecialcharsbx($this->id).']['.htmlspecialcharsbx($id).']" value="'.htmlspecialcharsbx($val_old).'">';
				}
				switch($field["edit"]["type"])
				{
					case "checkbox":
						echo '<input type="hidden" name="FIELDS['.htmlspecialcharsbx($this->id).']['.htmlspecialcharsbx($id).']" value="N">';
						echo '<input type="checkbox" name="FIELDS['.htmlspecialcharsbx($this->id).']['.htmlspecialcharsbx($id).']" value="Y"'.($val=='Y'?' checked':'').'>';
						break;
					case "select":
						echo '<select name="FIELDS['.htmlspecialcharsbx($this->id).']['.htmlspecialcharsbx($id).']"'.$this->__AttrGen($field["edit"]["attributes"]).'>';
						foreach($field["edit"]["values"] as $k=>$v)
							echo '<option value="'.htmlspecialcharsbx($k).'" '.($k==$val?' selected':'').'>'.htmlspecialcharsex($v).'</option>';
						echo '</select>';
						break;
					case "input":
						if(!$field["edit"]["attributes"]["size"])
							$field["edit"]["attributes"]["size"] = "10";
						echo '<input type="text" '.$this->__AttrGen($field["edit"]["attributes"]).' name="FIELDS['.htmlspecialcharsbx($this->id).']['.htmlspecialcharsbx($id).']" value="'.htmlspecialcharsbx($val).'">';
						break;
					case "calendar":
						if(!$field["edit"]["attributes"]["size"])
							$field["edit"]["attributes"]["size"] = "10";
						echo '<span style="white-space:nowrap;"><input type="text" '.$this->__AttrGen($field["edit"]["attributes"]).' name="FIELDS['.htmlspecialcharsbx($this->id).']['.htmlspecialcharsbx($id).']" value="'.htmlspecialcharsbx($val).'">';
						echo CAdminCalendar::Calendar('FIELDS['.htmlspecialcharsbx($this->id).']['.htmlspecialcharsbx($id).']').'</span>';
						break;
					default:
						echo $field["edit"]['value'];
				}
				echo '</td>';
			}
			else
			{
				if(!is_array($this->arRes[$id]))
					$val = trim($this->arRes[$id]);
				else
					$val = $this->arRes[$id];
				switch($field["view"]["type"])
				{
					case "checkbox":
						if($val=='Y')
							$val = GetMessage("admin_lib_list_yes");
						else
							$val = GetMessage("admin_lib_list_no");
						break;
					case "select":
						if($field["edit"]["values"][$val])
							$val = $field["edit"]["values"][$val];
						break;
				}
				if($field["view"]['type']=='html')
					$val = $field["view"]['value'];
				else
					$val = htmlspecialcharsex($val);

				echo '<td'.(isset($header_props['align']) && $header_props['align']?' align="'.$header_props['align'].'"':'').(isset($header_props['valign']) && $header_props['valign']?' valign="'.$header_props['valign'].'"':'').'>';
				echo ((string)$val <> ""? $val:'&nbsp;');
				if(isset($field["edit"]) && $field["edit"]["type"] == "calendar")
					echo CAdminCalendar::ShowScript();
				echo '</td>';
			}
		}
		echo '</tr>';
	}
}

class CAdminMessage
{
	var $exception, $message;
	function CAdminMessage($message, $exception=false)
	{
		//array("MESSAGE"=>"", "TYPE"=>("ERROR"|"OK"), "DETAILS"=>"", "HTML"=>true)
		if(!is_array($message))
			$message = array("MESSAGE"=>$message, "TYPE"=>"ERROR");
		if(empty($message["DETAILS"]) && $exception !== false)
			$message["DETAILS"] = $exception->GetString();
		$this->message = $message;
		$this->exception = $exception;
	}

	function Show()
	{
		if (defined('BX_PUBLIC_MODE') && BX_PUBLIC_MODE == 1)
		{
			ob_end_clean();
			echo '<script>top.BX.WindowManager.Get().ShowError(\''.CUtil::JSEscape(str_replace(array('<br>', '<br />', '<BR>', '<BR />'), "\r\n", htmlspecialcharsback($this->message['DETAILS']? $this->message['DETAILS'] : $this->message['MESSAGE']))).'\');</script>';
			die();
		}

		$s = '
<div class="message">
<table cellpadding="0" cellspacing="0" border="0" class="message '.($this->message["TYPE"] <> "OK"? "message-error":"message-ok").'">
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" class="content">
				<tr>
					<td valign="top"><div class="'.($this->message["TYPE"] <> "OK"? "icon-error":"icon-ok").'"></div></td>
					<td>
						<span class="message-title">'.($this->message["HTML"]? $this->message["MESSAGE"] : _ShowHtmlspec($this->message["MESSAGE"])).'</span><br>
						'.(!empty($this->message["DETAILS"])? '<div class="empty" style="height:5px;"></div>':'').($this->message["HTML"]? $this->message["DETAILS"] : _ShowHtmlspec($this->message["DETAILS"])).'
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>
';
		return $s;
	}

	function GetMessages()
	{
		if($this->exception && method_exists($this->exception, 'GetMessages'))
			return $this->exception->GetMessages();
		return false;
	}

	function ShowOldStyleError($message)
	{
		if(!empty($message))
		{
			$m = new CAdminMessage(array("MESSAGE"=>GetMessage("admin_lib_error"), "DETAILS"=>$message, "TYPE"=>"ERROR"));
			echo $m->Show();
		}
	}

	function ShowMessage($message)
	{
		if(!empty($message))
		{
			$m = new CAdminMessage($message);
			echo $m->Show();
		}
	}

	function ShowNote($message)
	{
		if(!empty($message))
			CAdminMessage::ShowMessage(array("MESSAGE"=>$message, "TYPE"=>"OK"));
	}
}

class CAdminChain
{
	var $items = array();
	var $id, $bVisible;

	function CAdminChain($id=false, $bVisible=true)
	{
		$this->id = $id;
		$this->bVisible = $bVisible;
	}

	function AddItem($item)
	{
		//array("TEXT"=>"", "LINK"=>"", "ONCLICK"=>"", "MENU"=>array(array("TEXT"=>"", "LINK"=>""), ...))
		$this->items[] = $item;
	}

	function Show()
	{
		if(empty($this->items))
			return;

		echo '<div class="navchain"'.($this->id? ' id="'.$this->id.'"':'').($this->bVisible == false? ' style="display:none;"':'').'>';

		$n = 0;
		foreach($this->items as $item)
		{
			if($n>0)
				echo '<img src="'.ADMIN_THEMES_PATH.'/'.ADMIN_THEME_ID.'/images/chain_arrow.gif" alt="" border="0" class="arrow">';
			echo (!empty($item["LINK"])? '<a href="'.$item["LINK"].'"'.(!empty($item["ONCLICK"])? ' onclick="'.$item["ONCLICK"].'"':'').'>'.$item["TEXT"].'</a>' : $item["TEXT"]);
			$n++;
		}
		echo '</div>';
	}
}

class CAdminMainChain extends CAdminChain
{
	var $bInit = false;

	function CAdminMainChain($id=false, $bVisible=true)
	{
		$this->CAdminChain($id, $bVisible);
	}

	function Init()
	{
		if($this->bInit)
			return;
		$this->bInit = true;
		$GLOBALS["adminPage"]->Init();
		$GLOBALS["adminMenu"]->Init($GLOBALS["adminPage"]->aModules);

		parent::AddItem(array("TEXT"=>'<img src="'.ADMIN_THEMES_PATH.'/'.ADMIN_THEME_ID.'/images/home.gif" alt="" border="0" class="home">'.GetMessage("admin_lib_navchain_first"), "LINK"=>"/bitrix/admin/index.php?lang=".LANGUAGE_ID));

		foreach($GLOBALS["adminMenu"]->aActiveSections as $sect)
		{
			if($sect["skip_chain"] !== true)
				parent::AddItem(array("TEXT"=>$sect["text"], "LINK"=>$sect["url"]));
		}
	}

	function AddItem($item)
	{
		$this->Init();
		parent::AddItem($item);
	}

	function Show()
	{
		parent::Show(true);
	}
}

class CAdminCalendar
{
	function ShowScript()
	{
		CJSCore::Init(array('date'));
	}

	function Calendar($sFieldName, $sFromName="", $sToName="", $bTime=false)
	{
		ob_start();
		$GLOBALS['APPLICATION']->IncludeComponent('bitrix:main.calendar', '', array(
			'RETURN' => 'Y',
			'SHOW_INPUT' => 'N',
			'INPUT_NAME' => $sFieldName,
			'SHOW_TIME' => $bTime ? 'Y' : 'N'
		), null, array('HIDE_ICONS' => 'Y'));
		$res = ob_get_contents();
		ob_end_clean();

		return $res;
	}

	function CalendarDate($sFieldName, $sValue="", $size="10", $bTime=false)
	{
		// component can't set 'size' param
		return '<span style="white-space:nowrap;"><input type="text" name="'.$sFieldName.'" size="'.$size.'" value="'.htmlspecialcharsbx($sValue).'">'.CAdminCalendar::Calendar($sFieldName, "", "", $bTime).'</span>';
	}

	function CalendarPeriod($sFromName, $sToName, $sFromVal="", $sToVal="", $bDaysList=false, $size="10", $bTime=false)
	{
		$sSelectName = $sFromName."_DAYS_TO_BACK";
		$s = '';
		if($bDaysList)
		{
			$s .= '<select name="'.$sSelectName.'" onchange="BX.calendar.InsertDaysBack(this.form.'.$sFromName.', this[this.selectedIndex].value);"><option value=""></option>';
			for($day=0; $day<=90; $day++)
				$s .= '<option value="'.$day.'"'.($GLOBALS[$sSelectName] <> "" && $GLOBALS[$sSelectName] == $day? " selected":"").'>'.$day.' '.GetMessage("calend_days").'</option>';
			$s .= '</select>&nbsp;';
		}
		$sDisabled = ($GLOBALS[$sSelectName] <> ""? " disabled":"");
		return
			$s.
			'<span style="white-space:nowrap;"><input'.$sDisabled.' type="text" name="'.$sFromName.'" size="'.$size.'" value="'.htmlspecialcharsbx($sFromVal).'">'.
			CAdminCalendar::Calendar($sFromName, $sFromName, $sToName, $bTime).
			'...&nbsp;'.
			'<input type="text" name="'.$sToName.'" size="'.$size.'" value="'.htmlspecialcharsbx($sToVal).'">'.
			CAdminCalendar::Calendar($sToName, $sFromName, $sToName, $bTime).'</span>';
	}
}


class CAdminTheme
{
	function GetList()
	{
		global $MESS;

		$aThemes = array();
		$dir = $_SERVER["DOCUMENT_ROOT"].ADMIN_THEMES_PATH;
		if(is_dir($dir) && ($dh = opendir($dir)))
		{
			while (($file = readdir($dh)) !== false)
			{
				if(is_dir($dir."/".$file) && $file!="." && $file!="..")
				{
					$path = ADMIN_THEMES_PATH."/".$file;

					$sLangFile = $_SERVER["DOCUMENT_ROOT"].$path."/lang/".LANGUAGE_ID."/.description.php";
					if(file_exists($sLangFile))
						include($sLangFile);
					else
					{
						$sLangFile = $_SERVER["DOCUMENT_ROOT"].$path."/lang/en/.description.php";
						if(file_exists($sLangFile))
							include($sLangFile);
					}

					$aTheme = array();
					$sDescFile = $_SERVER["DOCUMENT_ROOT"].$path."/.description.php";
					if(file_exists($sDescFile))
						$aTheme = include($sDescFile);
					$aTheme["ID"] = $file;
					if($aTheme["NAME"] == "")
						$aTheme["NAME"] = $file;

					$aThemes[] = $aTheme;
				}
			}
			closedir($dh);
		}
		usort($aThemes, create_function('$a, $b', 'return strcasecmp($a["ID"], $b["ID"]);'));
		return $aThemes;
	}

	function GetCurrentTheme()
	{
		$aUserOpt = CUserOptions::GetOption("global", "settings");
		if($aUserOpt["theme_id"] <> "")
			return $aUserOpt["theme_id"];

		return ".default";
	}
}

/**********************************************************************/

class CAdminTabEngine
{
	var $name;
	var $bInited = False;
	var $arEngines = array();
	var $arArgs = array();
	var $bVarsFromForm = False;

	function CAdminTabEngine($name, $arArgs = array())
	{
		$this->bInited = False;
		$this->name = $name;
		$this->arEngines = array();
		$this->arArgs = $arArgs;

		$db_events = GetModuleEvents("main", $this->name);
		while ($arEvent = $db_events->Fetch())
		{
			$res = ExecuteModuleEventEx($arEvent);
			$this->arEngines[$res["TABSET"]] = $res;
			$this->bInited = True;
		}
	}

	function SetErrorState($bVarsFromForm = False)
	{
		$this->bVarsFromForm = $bVarsFromForm;
	}

	function SetArgs($arArgs = array())
	{
		$this->arArgs = $arArgs;
	}

	function Check()
	{
		if (!$this->bInited)
			return True;

		$result = True;

		foreach ($this->arEngines as $key => $value)
		{
			if (array_key_exists("Check", $value))
			{
				$resultTmp = call_user_func_array($value["Check"], array($this->arArgs));
				if ($result && !$resultTmp)
					$result = False;
			}
		}

		return $result;
	}

	function Action()
	{
		if (!$this->bInited)
			return True;

		$result = True;

		foreach ($this->arEngines as $key => $value)
		{
			if (array_key_exists("Action", $value))
			{
				$resultTmp = call_user_func_array($value["Action"], array($this->arArgs));
				if ($result && !$resultTmp)
					$result = False;
			}
		}

		return $result;
	}

	function GetTabs()
	{
		if (!$this->bInited)
			return False;

		$arTabs = array();
		foreach ($this->arEngines as $key => $value)
		{
			if (array_key_exists("GetTabs", $value))
			{
				$arTabsTmp = call_user_func_array($value["GetTabs"], array($this->arArgs));
				if (is_array($arTabsTmp))
				{
					foreach ($arTabsTmp as $key1 => $value1)
						$arTabsTmp[$key1]["DIV"] = $key."_".$arTabsTmp[$key1]["DIV"];

					$arTabs = array_merge($arTabs, $arTabsTmp);
				}
			}
		}

		return $arTabs;
	}

	function ShowTab($divName)
	{
		if (!$this->bInited)
			return False;

		foreach ($this->arEngines as $key => $value)
		{
			if (SubStr($divName, 0, StrLen($key."_")) == $key."_")
			{
				if (array_key_exists("ShowTab", $value))
					$arTabsTmp = call_user_func_array($value["ShowTab"], array(SubStr($divName, StrLen($key."_")), $this->arArgs, $this->bVarsFromForm));
			}
		}
	}
}

class CJSPopup
{
	var $__form_name = 'bx_popup_form';
	var $post_args;
	var $title = '';
	var $bDescriptionStarted = false;
	var $bContentStarted = false;
	var $bButtonsStarted = false;
	var $suffix = '';
	var $jsPopup = 'BX.WindowManager.Get()';

	/*
	$arConfig = array(
		'TITLE' => 'Popup window title',
		'ARGS' => 'param1=values1&param2=value2', // additional GET arguments for POST query
	)
	*/
	function CJSPopup($title = '', $arConfig = array())
	{
		if ($title != '') $this->SetTitle($title);
		if (is_set($arConfig, 'TITLE')) $this->SetTitle($arConfig['TITLE']);
		if (is_set($arConfig, 'ARGS')) $this->SetAdditionalArgs($arConfig['ARGS']);
		if (is_set($arConfig, 'SUFFIX') && strlen($arConfig['SUFFIX']) > 0) $this->SetSuffix($arConfig['SUFFIX']);
	}

	function SetAdditionalArgs($additional_args = '')
	{
		$this->post_args = $additional_args;
	}

	function SetTitle($title = '')
	{
		$this->title = trim($title);
	}

	function GetFormName()
	{
		return $this->__form_name;
	}

	function SetSuffix($suffix)
	{
		$this->suffix = '_'.trim($suffix);
		//$this->jsPopup .= $this->suffix;
		$this->__form_name .= $this->suffix;
	}

	function ShowTitlebar($title = '')
	{
		if ($title == '') $title = $this->title;
?>
<script type="text/javascript"><?=$this->jsPopup?>.SetTitle('<?echo CUtil::JSEscape($title)?>');</script>
<?
	}

	function StartDescription($icon = false, $additional = '')
	{
		$this->bDescriptionStarted = true;

?>
<script type="text/javascript"><?if ($icon):?>
	<?if (strpos($icon, '/') === false):?>
		<?=$this->jsPopup?>.SetIcon('<?echo CUtil::JSEscape($icon)?>');
	<?else:?>
		<?=$this->jsPopup?>.SetIconFile('<?echo CUtil::JSEscape($icon)?>');
	<?endif;?>
<?endif;?>
<?
			ob_start();
	}

	function EndDescription()
	{
		if ($this->bDescriptionStarted)
		{
			$descr = ob_get_contents();
			ob_end_clean();
?>

<?=$this->jsPopup?>.SetHead('<?echo CUtil::JSEscape($descr)?>');</script>
<?
			//echo '</div></div>';
			$this->bDescriptionStarted = false;
		}
	}

	function StartContent($arAdditional = array())
	{
		$this->EndDescription();
		$this->bContentStarted = true;

		if ($arAdditional['buffer'])
		{
			$this->bContentBuffered = true;
			//ob_start();
			$this->cont_id = RandString(10);
			echo '<div id="'.$this->cont_id.'" style="display: none;">';
		}

		echo '<form name="'.$this->__form_name.'">'."\r\n";
		echo bitrix_sessid_post()."\r\n";

		if (is_set($_REQUEST, 'back_url'))
			echo '<input type="hidden" name="back_url" value="'.htmlspecialcharsbx($_REQUEST['back_url']).'" />'."\r\n";
	}

	function EndContent()
	{
		if ($this->bContentStarted)
		{
			echo '</form>'."\r\n";

			$hkInstance = CHotKeys::getInstance();
			$Execs = $hkInstance->GetCodeByClassName("CDialog");
			echo $hkInstance->PrintJSExecs($Execs, "", true, true);

			if ($this->bContentBuffered)
			{
?></div><script type="text/javascript">BX.ready(function() {<?=$this->jsPopup?>.SwapContent(BX('<?echo $this->cont_id?>'))});</script><?
			}
			$this->bContentStarted = false;
		}
	}

	function StartButtons($additional = '')
	{
		$this->EndDescription();
		$this->EndContent();

		$this->bButtonsStarted = true;

		ob_start();
	}

	function EndButtons()
	{
		if ($this->bButtonsStarted)
		{
			$buttons = ob_get_contents();
			ob_end_clean();
?>
		<script type="text/javascript"><?=$this->jsPopup?>.SetButtons('<?echo CUtil::JSEscape($buttons)?>');</script>
<?
			$this->bButtonsStarted = false;
		}
	}

	function ShowStandardButtons($arButtons = array('save', 'cancel'))
	{
		if (!is_array($arButtons)) return;

		if ($this->bButtonsStarted)
		{
			$this->EndButtons();
		}

		$arSB = array('save' => $this->jsPopup.'.btnSave', 'save' => $this->jsPopup.'.btnSave', 'cancel' => $this->jsPopup.'.btnCancel', 'close' => $this->jsPopup.'.btnClose');

		foreach ($arButtons as $key => $value)
			if (!$arSB[$value]) unset($arButtons[$key]);
		$arButtons = array_values($arButtons);

?>
<script type="text/javascript"><?=$this->jsPopup?>.SetButtons([<?foreach ($arButtons as $key => $btn) {echo ($key ? ',' : '').$arSB[$btn];}?>]);</script><?
	}

	function ShowValidationError($errortext)
	{
		$this->EndDescription();
		echo '<script>top.'.$this->jsPopup.'.ShowError(\''.CUtil::JSEscape(str_replace(array('<br>', '<br />', '<BR>', '<BR />'), "\r\n", $errortext)).'\')</script>';
	}

	function ShowError($errortext, $title = '')
	{
		$this->ShowTitlebar($title != "" ? $title : $this->title);

		if (!$this->bDescriptionStarted)
			$this->StartDescription();

		ShowError($errortext);

		$this->ShowStandardButtons(array("close"));
		echo '<script>'.$this->jsPopup.'.AdjustShadow();</script>';
		require($_SERVER["DOCUMENT_ROOT"]."/bitrix/modules/main/include/epilog_admin_js.php");

		exit();
	}

	function Close($bReload = true, $back_url = false)
	{
		if (!$back_url && is_set($_REQUEST, 'back_url'))
			$back_url = $_REQUEST['back_url'];

		echo '<script>';
		echo 'top.'.$this->jsPopup.'.Close(); ';

		if ($bReload)
		{
			echo 'top.BX.showWait(); ';
			echo "top.BX.reload('".CUtil::JSEscape($back_url)."', true);";
		}
		echo '</script>';
		die();
	}
}

class CAdminForm extends CAdminTabControl
{
	var $arParams = array();
	var $arFields = array();
	var $arFieldValues = array();
	var $sPrologContent = "";
	var $sEpilogContent = "";
	var $arButtonsParams = false;
	var $sButtonsContent = "";

	var $arSavedTabs = array();
	var $arSystemTabs = array();
	var $arSystemFields = array();

	var $arCustomLabels = array();
	var $bCustomFields = false;
	var $sCurrentLabel = "";
	var $bCurrentReq = false;

	function CAdminForm($name, $tabs, $bCanExpand = true, $bDenyAutosave = false)
	{
		parent::CAdminTabControl($name, $tabs, $bCanExpand, $bDenyAutosave);
		$this->tabIndex = 0;
		foreach($this->tabs as $i => $arTab)
			$this->tabs[$i]["FIELDS"] = array();

		//Parse customized labels
		$this->arCustomLabels = array();
		$customTabs = CUserOptions::GetOption("form", $this->name);
		if($customTabs && $customTabs["tabs"])
		{
			$arTabs = explode("--;--", $customTabs["tabs"]);
			if(count($arTabs) > 0)
			{
				foreach($arTabs as $customFields)
				{
					$arCustomFields = explode("--,--", $customFields);
					//Tab MUST have at least one field
					foreach($arCustomFields as $customField)
					{
						list($customID, $customName) = explode("--#--", $customField);
						$this->arCustomLabels[$customID] = ltrim($customName, defined("BX_UTF")? "* -\xa0\xc2": "* -\xa0");
					}
				}
			}
		}
		ob_start();
	}

	function ShowSettings()
	{
		global $APPLICATION;

		$arSystemTabsFields = array();
		foreach($this->arSystemTabs as $arTab)
		{
			if(!array_key_exists("CUSTOM", $arTab) || $arTab["CUSTOM"] !== "Y")
			{
				$arSystemTabsFields[$arTab["DIV"]] = array();
				if(is_array($arTab["FIELDS"]))
					foreach($arTab["FIELDS"] as $i => $arField)
						$arSystemTabsFields[$arTab["DIV"]][$arField["id"]] = $arField["id"];
			}
		}

		$arSystemTabs = array();
		foreach($this->arSystemTabs as $arTab)
		{
			if(!array_key_exists("CUSTOM", $arTab) || $arTab["CUSTOM"] !== "Y")
			{
				$arSystemTabs[$arTab["DIV"]] = $arTab["TAB"];
			}
		}

		$arSystemFields = array();
		foreach($this->arSystemTabs as $arTab)
		{
			if(!array_key_exists("CUSTOM", $arTab) || $arTab["CUSTOM"] !== "Y")
			{
				if(is_array($arTab["FIELDS"]))
				{
					foreach($arTab["FIELDS"] as $arField)
					{
						$id = htmlspecialcharsbx($arField["id"]);
						$label = htmlspecialcharsbx(rtrim(trim($arField["content"]), " :"));
						if($arField["delimiter"])
							$arSystemFields[$id] = "--".$label;
						else
							$arSystemFields[$id] = ($arField["required"]? "*": "&nbsp;&nbsp;").$label;
					}
				}
			}
		}

		$arAvailableTabs = $arSystemTabs;
		$arAvailableFields = $arSystemFields;

		$arCustomFields = array();
		foreach($this->tabs as $arTab)
		{
			if(!array_key_exists("CUSTOM", $arTab) || $arTab["CUSTOM"] !== "Y")
			{
				$ar = array(
					"TAB" => $arTab["TAB"],
					"FIELDS" => array(),
				);
				if(is_array($arTab["FIELDS"]))
				{
					foreach($arTab["FIELDS"] as $arField)
					{
						$id = htmlspecialcharsbx($arField["id"]);
						$label = htmlspecialcharsbx(rtrim(trim($arField["content"]), " :"));
						if($arField["delimiter"])
							$ar["FIELDS"][$id] = "--".$label;
						else
							$ar["FIELDS"][$id] = ($arField["required"]? "*": "&nbsp;&nbsp;").$label;
						unset($arAvailableFields[$id]);
					}
				}
				$arCustomFields[$arTab["DIV"]] = $ar;
				unset($arAvailableTabs[$arTab["DIV"]]);
			}
		}

		$arFormEditMess = array(
			"admin_lib_sett_tab_prompt" => GetMessage("admin_lib_sett_tab_prompt"),
			"admin_lib_sett_tab_default_name" => GetMessage("admin_lib_sett_tab_default_name"),
			"admin_lib_sett_sec_prompt" => GetMessage("admin_lib_sett_sec_prompt"),
			"admin_lib_sett_sec_default_name" => GetMessage("admin_lib_sett_sec_default_name"),
			"admin_lib_sett_sec_rename" => GetMessage("admin_lib_sett_sec_rename"),
			"admin_lib_sett_tab_rename" => GetMessage("admin_lib_sett_tab_rename"),
		);
		
?>
<script>
var arSystemTabsFields = <?echo CUtil::PhpToJSObject($arSystemTabsFields)?>;
var arSystemTabs = <?echo CUtil::PhpToJSObject($arSystemTabs)?>;
var arSystemFields = <?echo CUtil::PhpToJSObject($arSystemFields)?>;
var arFormEditMess = <?echo CUtil::PhpToJSObject($arFormEditMess)?>;
Sync();
</script>

<div class="title">
<table cellspacing="0" width="100%">
	<tr>
		<td width="100%" class="title-text" onmousedown="jsFloatDiv.StartDrag(arguments[0], document.getElementById('settings_float_div'));"><?echo GetMessage("admin_lib_sett_tab_title")?></td>
		<td width="0%"><a class="close" href="javascript:<?echo $this->name?>.CloseSettings();" title="<?echo GetMessage("admin_lib_sett_close")?>"></a></td>
	</tr>
</table>
</div>
<form ENCTYPE="multipart/form-data" name="form_settings" action="<?echo $APPLICATION->GetCurPageParam()?>" method="POST">
<div class="content">
<h2><?echo GetMessage("admin_lib_sett_tab_fields")?></h2>
<table cellspacing="0">
	<tr valign="center">
		<td><?echo GetMessage("admin_lib_sett_tab_available_tabs")?>:</td>
		<td></td>
		<td><?echo GetMessage("admin_lib_sett_tab_selected_tabs")?>:</td>
		<td></td>
	</tr>
	<tr valign="center">
		<td>
			<select class="select" name="available_tabs" id="available_tabs" size="8" onchange="Sync();">
		<?
		foreach($arSystemTabs as $id => $label)
			echo '<option value="'.htmlspecialcharsbx($id).'">'.htmlspecialcharsbx($label).'</option>';
		?>
			</select>
		</td>
		<td>
			<input type="button" name="tabs_copy" id="tabs_copy" value="&nbsp; &gt; &nbsp;" title="<?echo GetMessage("admin_lib_sett_tab_copy")?>" disabled onclick="OnAdd(this.id);">
		</td>
		<td>
			<select class="select" name="selected_tabs" id="selected_tabs" size="8" onchange="Sync();">
		<?
		foreach($arCustomFields as $tab_id => $arTab)
			echo '<option value="'.htmlspecialcharsbx($tab_id).'">'.htmlspecialcharsbx($arTab["TAB"]).'</option>';
		?>
			</select>
		</td>
		<td>
			<input type="button" name="tabs_up" id="tabs_up" class="button" value="<?echo GetMessage("admin_lib_sett_up")?>" title="<?echo GetMessage("admin_lib_sett_up_title")?>" disabled onclick="jsSelectUtils.moveOptionsUp(document.form_settings.selected_tabs);"><br>
			<input type="button" name="tabs_down" id="tabs_down" class="button" value="<?echo GetMessage("admin_lib_sett_down")?>" title="<?echo GetMessage("admin_lib_sett_down_title")?>" disabled onclick="jsSelectUtils.moveOptionsDown(document.form_settings.selected_tabs);"><br>
			<input type="button" name="tabs_rename" id="tabs_rename" class="button" value="<?echo GetMessage("admin_lib_sett_tab_rename")?>" title="<?echo GetMessage("admin_lib_sett_tab_rename_title")?>" disabled onclick="OnRename(this.id);"><br>
			<input type="button" name="tabs_add" id="tabs_add" class="button" value="<?echo GetMessage("admin_lib_sett_tab_add")?>" title="<?echo GetMessage("admin_lib_sett_tab_add_title")?>" onclick="OnAdd(this.id);"><br>
			<input type="button" name="tabs_delete" id="tabs_delete" class="button" value="<?echo GetMessage("admin_lib_sett_del")?>" title="<?echo GetMessage("admin_lib_sett_del_title")?>" disabled onclick="OnDelete(this.id);"><br>
		</td>
	</tr>
	<tr valign="center">
		<td><?echo GetMessage("admin_lib_sett_tab_available_fields")?>:</td>
		<td></td>
		<td><?echo GetMessage("admin_lib_sett_tab_selected_fields")?>:</td>
		<td></td>
	</tr>
	<tr valign="center">
		<td>
			<select class="select" name="available_fields" id="available_fields" size="12" multiple onchange="Sync();">
		<?
		foreach($arAvailableFields as $id => $label)
			echo '<option value="'.$id.'">'.$label.'</option>';
		?>
			</select>
		</td>
		<td>
			<input type="button" name="fields_copy" id="fields_copy" value="&nbsp; &gt; &nbsp;" title="<?echo GetMessage("admin_lib_sett_fields_copy")?>" disabled onclick="OnAdd(this.id);"><br><br>
		</td>
		<td id="selected_fields">
		<select style="display:block" disabled class="select" name="selected_fields[undef]" id="selected_fields[undef]" size="12" multiple></select>
		<?
		foreach($arCustomFields as $tab_id => $arTab)
		{
			if(is_array($arTab["FIELDS"]))
			{
				echo '<select style="display:none" class="select" name="selected_fields['.$tab_id.']" id="selected_fields['.$tab_id.']" size="12" multiple onchange="Sync();">';
				foreach($arTab["FIELDS"] as $field_id => $label)
					echo '<option value="'.$field_id.'">'.$label.'</option>';
				echo '</select>';
			}
		}
		?>
		</td>
		<td>
			<input type="button" name="fields_up" id="fields_up" class="button" value="<?echo GetMessage("admin_lib_sett_up")?>" title="<?echo GetMessage("admin_lib_sett_up_title")?>" disabled onclick="FieldsUpAndDown('up');"><br>
			<input type="button" name="fields_down" id="fields_down" class="button" value="<?echo GetMessage("admin_lib_sett_down")?>" title="<?echo GetMessage("admin_lib_sett_down_title")?>" disabled onclick="FieldsUpAndDown('down');"><br>
			<input type="button" name="fields_rename" id="fields_rename" class="button" value="<?echo GetMessage("admin_lib_sett_field_rename")?>" title="<?echo GetMessage("admin_lib_sett_field_rename_title")?>" disabled onclick="OnRename(this.id);"><br>
			<input type="button" name="fields_add" id="fields_add" class="button" value="<?echo GetMessage("admin_lib_sett_field_add")?>" title="<?echo GetMessage("admin_lib_sett_field_add_title")?>" onclick="OnAdd(this.id);"><br>
			<input type="button" name="fields_delete" id="fields_delete" class="button" value="<?echo GetMessage("admin_lib_sett_del")?>" title="<?echo GetMessage("admin_lib_sett_fields_delete")?>" disabled onclick="OnDelete(this.id);">
		</td>
	</tr>
</table>
		<?if($GLOBALS["USER"]->CanDoOperation('edit_other_settings')):?>
<h2><?echo GetMessage("admin_lib_sett_common")?></h2>
<table cellspacing="0">
	<tr>
		<td><input type="checkbox" name="set_default" id="set_default" value="Y"></td>
		<td><label for="set_default"><?echo GetMessage("admin_lib_sett_common_set")?></label></td>
		<td>|</td>
		<td><a class="delete-icon" title="<?echo GetMessage("admin_lib_sett_common_del")?>" href="javascript:if(confirm('<?echo GetMessage("admin_lib_sett_common_del_conf")?>'))<?echo $this->name?>.DeleteSettings(true)"></a></td>
	</tr>
</table>
		<?endif?>
</div>
<div class="buttons">
	<input type="button" id="save_settings" value="<?echo GetMessage("admin_lib_sett_save")?>" onclick="<?echo $this->name?>.SaveSettings()" title="<?echo GetMessage("admin_lib_sett_save_title")?>">
	<input type="button" value="<?echo GetMessage("admin_lib_sett_cancel")?>" onclick="<?echo $this->name?>.CloseSettings()" title="<?echo GetMessage("admin_lib_sett_cancel_title")?>">
	<input type="button" value="<?echo GetMessage("admin_lib_sett_reset")?>" onclick="if(confirm('<?echo GetMessage("admin_lib_sett_reset_ask")?>'))<?echo $this->name?>.DeleteSettings()" title="<?echo GetMessage("admin_lib_sett_reset_title")?>">
</div>
</form>
<?
		require($_SERVER["DOCUMENT_ROOT"].BX_ROOT."/modules/main/include/epilog_admin_after.php");
		die();
	}

	function SetFieldsValues($bVarsFromForm, $db_record, $default_values)
	{
		foreach($default_values as $key=>$value)
			$this->SetFieldValue($key, $bVarsFromForm, $db_record, $value);
	}

	function SetFieldValue($field_name, $bVarsFromForm, $db_record, $default_value = false)
	{
		if($bVarsFromForm)
		{
			if(array_key_exists($field_name, $_REQUEST))
				$this->arFieldValues[$field_name] = $_REQUEST[$field_name];
			else
				$this->arFieldValues[$field_name] = $default_value;
		}
		else
		{
			if(is_array($db_record) && array_key_exists($field_name, $db_record) && isset($db_record[$field_name]))
				$this->arFieldValues[$field_name] = $db_record[$field_name];
			else
				$this->arFieldValues[$field_name] = $default_value;
		}
	}

	function GetFieldValue($field_name)
	{
		return $this->arFieldValues[$field_name];
	}

	function GetHTMLFieldValue($field_name)
	{
		return htmlspecialcharsbx($this->arFieldValues[$field_name]);
	}

	function GetHTMLFieldValueEx($field_name)
	{
		return htmlspecialcharsex($this->arFieldValues[$field_name]);
	}

	function GetFieldLabel($id)
	{
		return $this->arFields[$id]["content"];
	}

	function ShowTabButtons()
	{
		if(!$this->bPublicMode && $this->bCustomFields)
		{
			if(is_array($_SESSION["ADMIN_CUSTOM_FIELDS"]) && array_key_exists($this->name, $_SESSION["ADMIN_CUSTOM_FIELDS"]))
				echo '<td width="100%" align="right"><a href="javascript:void(0)" onclick="this.blur();'.$this->name.'.EnableSettings();" hidefocus="true" title="'.GetMessage("admin_lib_sett_sett_enable").'" id="'.$this->name.'_custom_fields_on" class="context-button custom-fields-on"></a></td>';
			else
				echo '<td width="100%" align="right"><a href="javascript:void(0)" onclick="this.blur();'.$this->name.'.DisableSettings();" hidefocus="true" title="'.GetMessage("admin_lib_sett_sett_disable").'" id="'.$this->name.'_custom_fields_off" class="context-button custom-fields-off"></a></td>';
		}
		parent::ShowTabButtons();
	}

	function Begin($arParams = array())
	{
		$this->tabIndex = -1;
		if(is_array($arParams))
			$this->arParams = $arParams;
		else
			$this->arParams = array();
	}

	function BeginNextFormTab()
	{
		if($this->tabIndex >= count($this->tabs))
			return;

		$this->tabIndex++;
		while(
			isset($this->tabs[$this->tabIndex])
			&& array_key_exists("CUSTOM", $this->tabs[$this->tabIndex])
			&& $this->tabs[$this->tabIndex]["CUSTOM"] == "Y"
		)
		{
			$this->tabIndex++;
		}
	}

	function Show()
	{
		global $APPLICATION;

		//Save form defined tabs
		$this->arSavedTabs = $this->tabs;
		$this->arSystemTabs = array();
		foreach($this->tabs as $i => $arTab)
		{
			$this->arSystemTabs[$arTab["DIV"]] = $arTab;
			if(is_array($arTab["FIELDS"]))
				foreach($arTab["FIELDS"] as $j => $arField)
					$this->arFields[$arField["id"]] = $arField;
		}
		//Save form defined fields
		$this->arSystemFields = $this->arFields;

		$arCustomTabs = array();
		$customTabs = CUserOptions::GetOption("form", $this->name);
		if($customTabs && $customTabs["tabs"])
		{
			$arTabs = explode("--;--", $customTabs["tabs"]);
			if(count($arTabs) > 0)
			{
				foreach($arTabs as $customFields)
				{
					$arCustomFields = explode("--,--", $customFields);
					//Tab MUST have at least one field
					if(count($arCustomFields) > 1)
					{
						$arCustomTabID = "";
						$arCustomTabName = "";
						foreach($arCustomFields as $customField)
						{
							if($arCustomTabID == "")
							{
								list($arCustomTabID, $arCustomTabName) = explode("--#--", $customField);
								$arCustomTabs[$arCustomTabID] = array(
									"TAB" => $arCustomTabName,
									"FIELDS" => array(),
								);
							}
							else
							{
								list($arCustomFieldID, $arCustomFieldName) = explode("--#--", $customField);
								$arCustomFieldName = ltrim($arCustomFieldName, defined("BX_UTF")? "* -\xa0\xc2": "* -\xa0");
								$arCustomTabs[$arCustomTabID]["FIELDS"][$arCustomFieldID] = $arCustomFieldName;
							}
						}
					}
				}
				$this->bCustomFields = true;
				$this->tabs = array();
				foreach($arCustomTabs as $tab_id => $arTab)
				{
					if(array_key_exists($tab_id, $this->arSystemTabs))
					{
						$arNewTab = $this->arSystemTabs[$tab_id];
						$arNewTab["TAB"] = $arTab["TAB"];
						$arNewTab["FIELDS"] = array();
					}
					else
					{
						$arNewTab = array(
							"DIV" => $tab_id,
							"TAB" => $arTab["TAB"],
							"ICON" => "main_user_edit",
							"TITLE" => "",
							"FIELDS" => array(),
						);
					}
					foreach($arTab["FIELDS"] as $field_id => $content)
					{

						if(array_key_exists($field_id, $this->arSystemFields))
						{
							$arNewField = $this->arSystemFields[$field_id];
							$arNewField["content"] = $content;
						}
						elseif(strlen($content) > 0)
						{
							$arNewField = array(
								"id" => $field_id,
								"content" => $content,
								"html" => '<td colspan="2">'.htmlspecialcharsex($content).'</td>',
								"delimiter" => true,
							);
						}
						else
						{
							$arNewField = false;
						}

						if(is_array($arNewField))
						{
							$this->arFields[$field_id] = $arNewField;
							$arNewTab["FIELDS"][] = $arNewField;
						}
					}
					$this->tabs[] = $arNewTab;
				}
			}
		}

		if($_REQUEST["mode"] == "settings")
		{
			ob_end_clean();
			$this->ShowSettings($this->arFields);
			die();
		}
		else
		{
			ob_end_flush();
		}

		if(!is_array($_SESSION["ADMIN_CUSTOM_FIELDS"]))
			$_SESSION["ADMIN_CUSTOM_FIELDS"] = array();
		$arDisabled = CUserOptions::GetOption("form", $this->name."_disabled", "N");
		if(is_array($arDisabled) && $arDisabled["disabled"] === "Y")
		{
			$_SESSION["ADMIN_CUSTOM_FIELDS"][$this->name] = true;
			$this->tabs = $this->arSavedTabs;
			$this->arFields = $this->arSystemFields;
		}
		else
		{
			unset($_SESSION["ADMIN_CUSTOM_FIELDS"][$this->name]);
		}

		if(isset($_REQUEST[$this->name."_active_tab"]))
			$this->selectedTab = $_REQUEST[$this->name."_active_tab"];
		else
			$this->selectedTab = $this->tabs[0]["DIV"];

		//To show
		$arHiddens = $this->arFields;
		echo $this->sPrologContent;
		if(array_key_exists("FORM_ACTION", $this->arParams))
			$action = htmlspecialcharsbx($this->arParams["FORM_ACTION"]);
		else
			$action = htmlspecialcharsbx($APPLICATION->GetCurPage());
		echo '<form method="POST" Action="'.$action.'"  ENCTYPE="multipart/form-data" name="'.$this->name.'_form"'.($this->arParams["FORM_ATTRIBUTES"] <> ''? ' '.$this->arParams["FORM_ATTRIBUTES"]:'').'>';

		parent::Begin();

		while($this->tabIndex < count($this->tabs))
		{
			$this->BeginNextTab();
			$arTab = $this->tabs[$this->tabIndex-1];
			if(is_array($arTab["FIELDS"]))
			{
				foreach($arTab["FIELDS"] as $j => $arField)
				{
					if(strlen($this->arFields[$arField["id"]]["custom_html"]) > 0)
					{
						echo $this->arFields[$arField["id"]]["custom_html"];
					}
					elseif(strlen($this->arFields[$arField["id"]]["html"]) > 0)
					{
						if($this->arFields[$arField["id"]]["delimiter"])
							echo '<tr class="heading" id="tr_'.$arField["id"].'">';
						else
							echo '<tr'.($this->arFields[$arField["id"]]["valign"] <> ''? ' valign="'.$this->arFields[$arField["id"]]["valign"].'"':'').' id="tr_'.$arField["id"].'">';
						echo $this->arFields[$arField["id"]]["html"].'</tr>'."\n";
					}
					unset($arHiddens[$arField["id"]]);
				}
			}
		}
		foreach($arHiddens as $i => $arField)
		{
			if($arField["required"])
			{
					if(strlen($this->arFields[$arField["id"]]["custom_html"]) > 0)
					{
						echo $this->arFields[$arField["id"]]["custom_html"];
					}
					elseif(strlen($this->arFields[$arField["id"]]["html"]) > 0)
					{
						if($this->arFields[$arField["id"]]["delimiter"])
							echo '<tr class="heading">';
						else
							echo '<tr>';
						echo $this->arFields[$arField["id"]]["html"].'</tr>';
					}
					unset($arHiddens[$arField["id"]]);
			}
		}
		parent::Buttons($this->arButtonsParams);
		echo $this->sButtonsContent;
		$this->End();
		echo $this->sEpilogContent;
		foreach($arHiddens as $i => $arField)
		{
			echo $arField["hidden"];
		}
		echo '</form>';
	}

	function GetName()
	{
		return $this->name;
	}

	function GetFormName()
	{
		return $this->name."_form";
	}

	function GetCustomLabel($id, $content)
	{
		$bColumnNeeded = substr($content, -1)==":";

		if($id === false)
			return $this->sCurrentLabel;
		elseif(array_key_exists($id, $this->arCustomLabels))
			return $this->arCustomLabels[$id].($bColumnNeeded? ":": "");
		else
			return $content;
	}

	function GetCustomLabelHTML($id = false, $content = "")
	{
		$bColumnNeeded = substr($content, -1)==":";

		if($id === false)
			return ($this->bCurrentReq? '<span class="required">*</span>': '').htmlspecialcharsex($this->sCurrentLabel);
		elseif(array_key_exists($id, $this->arCustomLabels))
			return ($this->arFields[$id]["required"]? '<span class="required">*</span>': '').htmlspecialcharsex($this->arCustomLabels[$id]).($bColumnNeeded? ":": "");
		else
			return ($this->tabs[$this->tabIndex]["FIELDS"][$id]["required"]? '<span class="required">*</span>': '').htmlspecialcharsex($content);
	}

	function ShowWarnings($form, $messages, $aFields=false)
	{
		parent::ShowWarnings($this->name.'_form', $messages, $aFields);
	}

	function BeginPrologContent()
	{
		ob_start();
	}

	function EndPrologContent()
	{
		$this->sPrologContent = ob_get_contents();
		ob_end_clean();
	}

	function BeginEpilogContent()
	{
		ob_start();
	}

	function EndEpilogContent()
	{
		$this->sEpilogContent = ob_get_contents();
		ob_end_clean();
	}

	function AddSection($id, $content, $required = false)
	{
		$this->tabs[$this->tabIndex]["FIELDS"][$id] = array(
			"id" => $id,
			"required" => $required,
			"delimiter" => true,
			"content" => $content,
			"html" => '<td colspan="2">'.($required? '<span class="required">*</span>': '').$this->GetCustomLabelHTML($id, $content).'</td>',
		);
	}

	function AddViewField($id, $content, $html, $required=false)
	{
		$this->tabs[$this->tabIndex]["FIELDS"][$id] = array(
			"id" => $id,
			"required" => $required,
			"content" => $content,
			"html" => ($html <> ''? '<td width="40%">'.$this->GetCustomLabelHTML($id, $content).'</td><td>'.$html.'</td>' : ''),
		);
	}

	function AddDropDownField($id, $content, $required, $arSelect, $value=false, $arParams=array())
	{
		if($value === false)
			$value = $this->arFieldValues[$id];

		$html = '<select name="'.$id.'"';
		foreach($arParams as $param)
			$html .= ' '.$param;
		$html .= '>';

		foreach($arSelect as $key => $val)
			$html .= '<option value="'.htmlspecialcharsbx($key).'"'.($value == $key? ' selected': '').'>'.htmlspecialcharsex($val).'</option>';
		$html .= '</select>';

		$this->tabs[$this->tabIndex]["FIELDS"][$id] = array(
			"id" => $id,
			"required" => $required,
			"content" => $content,
			"html" => '<td width="40%">'.($required? '<span class="required">*</span>': '').$this->GetCustomLabelHTML($id, $content).'</td><td>'.$html.'</td>',
			"hidden" => '<input type="hidden" name="'.$id.'" value="'.htmlspecialcharsbx($value).'">',
		);
	}

	function AddEditField($id, $content, $required, $arParams = array(), $value = false)
	{
		if($value === false)
			$value = htmlspecialcharsbx($this->arFieldValues[$id]);
		$html = '<input type="text" name="'.$id.'" value="'.$value.'"';
		if(intval($arParams["size"]) > 0)
			$html .= ' size="'.intval($arParams["size"]).'"';
		if(intval($arParams["maxlength"]) > 0)
			$html .= ' maxlength="'.intval($arParams["maxlength"]).'"';
		$html .= '>';

		$this->tabs[$this->tabIndex]["FIELDS"][$id] = array(
			"id" => $id,
			"required" => $required,
			"content" => $content,
			"html" => '<td width="40%">'.($required? '<span class="required">*</span>': '').$this->GetCustomLabelHTML($id, $content).'</td><td>'.$html.'</td>',
			"hidden" => '<input type="hidden" name="'.$id.'" value="'.$value.'">',
		);
	}

	function AddTextField($id, $label, $value, $arParams=array(), $required=false)
	{
		$html = '<textarea name="'.$id.'"';
		if(intval($arParams["cols"]) > 0)
			$html .= ' cols="'.intval($arParams["cols"]).'"';
		if(intval($arParams["rows"]) > 0)
			$html .= ' rows="'.intval($arParams["rows"]).'"';
		$html .= '>'.$value.'</textarea>';

		$this->tabs[$this->tabIndex]["FIELDS"][$id] = array(
			"id" => $id,
			"required" => $required,
			"content" => $label,
			"html" => '<td width="40%">'.($required? '<span class="required">*</span>': '').$this->GetCustomLabelHTML($id, $label).'</td><td>'.$html.'</td>',
			"hidden" => '<input type="hidden" name="'.$id.'" value="'.$value.'">',
			"valign" => "top",
		);
	}

	function AddCalendarField($id, $label, $value, $required=false)
	{
		$html = CalendarDate($id, $value, $this->GetFormName());

		$this->tabs[$this->tabIndex]["FIELDS"][$id] = array(
			"id" => $id,
			"required" => $required,
			"content" => $label,
			"html" => '<td width="40%">'.($required? '<span class="required">*</span>': '').$this->GetCustomLabelHTML($id, $label).'</td><td>'.$html.'</td>',
			"hidden" => '<input type="hidden" name="'.$id.'" value="'.$value.'">',
		);
	}

	function AddCheckBoxField($id, $content, $required, $value, $checked, $arParams=array())
	{
		$html = '<input type="checkbox" name="'.$id.'" value="'.htmlspecialcharsbx($value).'"'.($checked? ' checked': '');
		foreach($arParams as $param)
			$html .= ' '.$param;
		$html .= '>';

		$this->tabs[$this->tabIndex]["FIELDS"][$id] = array(
			"id" => $id,
			"required" => $required,
			"content" => $content,
			"html" => '<td width="40%">'.($required? '<span class="required">*</span>': '').$this->GetCustomLabelHTML($id, $content).'</td><td>'.$html.'</td>',
			"hidden" => '<input type="hidden" name="'.$id.'" value="'.htmlspecialcharsbx($value).'">',
		);
	}

	function AddFileField($id, $label, $value, $arParams=array(), $required=false)
	{
		$arDefParams = array("iMaxW"=>150, "iMaxH"=>150, "sParams"=>"border=0", "strImageUrl"=>"", "bPopup"=>true, "sPopupTitle"=>false);
		foreach($arDefParams as $key=>$val)
			if(!array_key_exists($key, $arParams))
				$arParams[$key] = $val;

		$html = CFile::InputFile($id, 20, $value);
		if($value <> '')
			$html .= '<br>'.CFile::ShowImage($value, $arParams["iMaxW"], $arParams["iMaxH"], $arParams["sParams"], $arParams["strImageUrl"], $arParams["bPopup"], $arParams["sPopupTitle"]);

		$this->tabs[$this->tabIndex]["FIELDS"][$id] = array(
			"id" => $id,
			"required" => $required,
			"content" => $label,
			"html" => '<td width="40%">'.($required? '<span class="required">*</span>': '').$this->GetCustomLabelHTML($id, $label).'</td><td>'.$html.'</td>',
			"valign" => "top",
		);
	}

	function BeginCustomField($id, $content, $required = false)
	{
		$this->sCurrentLabel = $this->GetCustomLabel($id, $content);
		$this->bCurrentReq = $required;
		$this->tabs[$this->tabIndex]["FIELDS"][$id] = array(
			"id" => $id,
			"required" => $required,
			"content" => $content,
		);

		ob_start();
	}

	function EndCustomField($id, $hidden = "")
	{
		$html = ob_get_contents();
		ob_end_clean();

		$this->tabs[$this->tabIndex]["FIELDS"][$id]["custom_html"] = $html;
		$this->tabs[$this->tabIndex]["FIELDS"][$id]["hidden"] = $hidden;
	}

	function ShowUserFields($PROPERTY_ID, $ID, $bVarsFromForm)
	{
		global $USER_FIELD_MANAGER, $APPLICATION;

		if($USER_FIELD_MANAGER->GetRights($PROPERTY_ID) >= "W")
		{
			$this->BeginCustomField("USER_FIELDS_ADD", GetMessage("admin_lib_add_user_field"));
			?>
				<tr colspan="2">
					<td align="left">
						<a href="/bitrix/admin/userfield_edit.php?lang=<?echo LANGUAGE_ID?>&amp;ENTITY_ID=<?echo urlencode($PROPERTY_ID)?>&amp;back_url=<?echo urlencode($APPLICATION->GetCurPageParam()."&tabControl_active_tab=user_fields_tab")?>"><?echo $this->GetCustomLabelHTML()?></a>
					</td>
				</tr>
			<?
			$this->EndCustomField("USER_FIELDS_ADD", '');
		}

		$arUserFields = $USER_FIELD_MANAGER->GetUserFields($PROPERTY_ID, $ID, LANGUAGE_ID);
		foreach($arUserFields as $FIELD_NAME => $arUserField)
		{
			$arUserField["VALUE_ID"] = intval($ID);
			if(array_key_exists($FIELD_NAME, $this->arCustomLabels))
				$strLabel = $this->arCustomLabels[$FIELD_NAME];
			else
				$strLabel = $arUserField["EDIT_FORM_LABEL"]? $arUserField["EDIT_FORM_LABEL"]: $arUserField["FIELD_NAME"];
			$arUserField["EDIT_FORM_LABEL"] = $strLabel;

			$this->BeginCustomField($FIELD_NAME, $strLabel, $arUserField["MANDATORY"]=="Y");

			if(isset($_REQUEST['def_'.$FIELD_NAME]))
				$arUserField['SETTINGS']['DEFAULT_VALUE'] = $_REQUEST['def_'.$FIELD_NAME];

			echo $USER_FIELD_MANAGER->GetEditFormHTML($bVarsFromForm, $GLOBALS[$FIELD_NAME], $arUserField);

			$form_value = $GLOBALS[$FIELD_NAME];
			if(!$bVarsFromForm)
				$form_value = $arUserField["VALUE"];
			elseif($arUserField["USER_TYPE"]["BASE_TYPE"]=="file")
				$form_value = $GLOBALS[$arUserField["FIELD_NAME"]."_old_id"];

			$hidden = "";
			if(is_array($form_value))
			{
				foreach($form_value as $value)
					$hidden .= '<input type="hidden" name="'.$FIELD_NAME.'[]" value="'.htmlspecialcharsbx($value).'">';
			}
			else
			{
				$hidden .= '<input type="hidden" name="'.$FIELD_NAME.'" value="'.htmlspecialcharsbx($form_value).'">';
			}
			$this->EndCustomField($FIELD_NAME, $hidden);
		}
	}

	function Buttons($aParams=false, $additional_html="")
	{
		if($aParams === false)
			$this->arButtonsParams = false;
		else
			$this->arButtonsParams = $aParams;
		$this->sButtonsContent = $additional_html;
	}

	function ButtonsPublic($arJSButtons = false)
	{
		if ($this->bPublicMode)
		{
			if (strlen($_REQUEST['from_module']))
				$this->sButtonsContent .= '<input type="hidden" name="from_module" value="'.htmlspecialcharsbx($_REQUEST['from_module']).'" />';

			ob_start();
			if ($arJSButtons === false)
			{
?>
<input type="hidden" name="bxpublic" value="Y" /><input type="hidden" name="save" value="Y" />
<script type="text/javascript"><?=$this->publicObject?>.SetButtons([<?=$this->publicObject?>.btnSave, <?=$this->publicObject?>.btnCancel]);</script>
<?
			}
			elseif (is_array($arJSButtons))
			{
				$arJSButtons = array_values($arJSButtons);
?>
<input type="hidden" name="bxpublic" value="Y" />
<script type="text/javascript"><?=$this->publicObject?>.SetButtons([
<?
				foreach ($arJSButtons as $key => $btn)
				{
					if (substr($btn, 0, 1) == '.')
						$btn = $this->publicObject.$btn;
					echo $key ? ',' : '', $btn, "\r\n"; // NO JSESCAPE HERE! string must contain valid js object
				}
?>
]);</script>
<?
			}
			$this->sButtonsContent .= ob_get_clean();
		}
	}
}

function ShowJSHint($text, $arParams=false)
{
	if (strlen($text) <= 0)
		return '';

	CUtil::InitJSCore(array('window'));

	$res = '<img src="/bitrix/images/1.gif" onload="BX.hint_replace(this, \''.htmlspecialcharsbx(CUtil::JSEscape($text)).'\')" />';

	if (isset($arParams['return']) && $arParams['return'])
		return $res;
	echo $res;
}
?>
