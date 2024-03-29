<?
define("ADMIN_MODULE_NAME", "bitrixcloud");
require_once($_SERVER["DOCUMENT_ROOT"]."/bitrix/modules/main/include/prolog_admin_before.php");
IncludeModuleLangFile(__FILE__);
if (!$USER->IsAdmin() || !CModule::IncludeModule("bitrixcloud"))
	$APPLICATION->AuthForm(GetMessage("ACCESS_DENIED"));

$aTabs = array(
	array(
		"DIV" => "main",
		"TAB" => GetMessage("BCL_MAIN_TAB"),
		"ICON" => "main_user_edit",
		"TITLE" => GetMessage("BCL_MAIN_TAB_TITLE"),
	),
	array(
		"DIV" => "sites",
		"TAB" => GetMessage("BCL_SITES_TAB"),
		"ICON" => "main_user_edit",
		"TITLE" => GetMessage("BCL_SITES_TAB_TITLE"),
	),
	array(
		"DIV" => "ext",
		"TAB" => GetMessage("BCL_EXTENDED_TAB"),
		"ICON" => "main_user_edit",
		"TITLE" => GetMessage("BCL_EXTENDED_TAB_TITLE"),
	),
);
$tabControl = new CAdminTabControl("tabControl", $aTabs, true, true);
$bVarsFromForm = false;
$message = /*.(CAdminMessage).*/ null;
if ($REQUEST_METHOD == "POST" && ($save != "" || $apply != "" || $bitrixcloud_siteb != "") && check_bitrix_sessid())
{
	if ($save != "" || $apply != "")
	{
		$server_name = trim($_POST["server_name"]);
		if ($server_name == "")
		{
			$message = new CAdminMessage(GetMessage("BCL_DOMAIN_ERROR"));
		}
		elseif (empty($_POST["site"]))
		{
			$message = new CAdminMessage(GetMessage("BCL_SITES_ERROR"));
		}
		else
		{
			$cdn_config = CBitrixCloudCDNConfig::getInstance()->loadFromOptions();
			if ($cdn_config->getDomain() !== $server_name)
				CBitrixCloudCDN::domainChanged();

			$cdn_config->setSites(array_keys($_POST["site"]));
			$cdn_config->setDomain($server_name);
			$cdn_config->saveToOptions();
			if (!CBitrixCloudCDN::SetActive($_POST["cdn_active"] === "Y"))
			{
				$e = $APPLICATION->GetException();
				if (is_object($e))
				{
					if ($_POST["cdn_active"] === "Y")
						$message = new CAdminMessage(GetMessage("BCL_ENABLE_ERROR"), $e);
					else
						$message = new CAdminMessage(GetMessage("BCL_DISABLE_ERROR"), $e);
				}
			}
		}
	}
	if (is_object($message))
	{
		$bVarsFromForm = true;
	}
	else
	{
		if ($save != "" && $_GET["return_url"] != "")
			LocalRedirect($_GET["return_url"]);

		LocalRedirect("/bitrix/admin/bitrixcloud_cdn.php?lang=".LANGUAGE_ID.($return_url ? "&return_url=".urlencode($_GET["return_url"]) : "")."&".$tabControl->ActiveTabParam());
	}
}
$cdn_config = CBitrixCloudCDNConfig::getInstance()->loadFromOptions();
$APPLICATION->SetTitle(GetMessage("BCL_TITLE"));
require($_SERVER["DOCUMENT_ROOT"]."/bitrix/modules/main/include/prolog_admin_after.php");
if (is_object($message))
	echo $message->Show();

if (CBitrixCloudCDN::IsActive())
{
	try
	{
		if ($cdn_config->getQuota()->isExpired())
			$cdn_config->updateQuota();

		$cdn_quota = $cdn_config->getQuota();
		if ($cdn_quota->getAllowedSize() > 0.0 && $cdn_quota->getTrafficSize() > 0.0)
		{
			if ($cdn_quota->getTrafficSize() < $cdn_quota->getAllowedSize())
			{ ?>
				<p><b><?echo GetMessage("BCL_CDN_USAGE", array(
					"#TRAFFIC#" => CFile::FormatSize($cdn_quota->getTrafficSize()),
					"#ALLOWED#" => CFile::FormatSize($cdn_quota->getAllowedSize()),
				)); ?></b></p>
				<div class="bitrixcloud-cdn-chart">
				<span class="bitrixcloud-cdn-chart-bar-green" style="width:<?echo round(($cdn_quota->getTrafficSize() / $cdn_quota->getAllowedSize()) * 100); ?>%"></span>
				</div>
			<?
			}
			else
			{ ?>
				<p><b><?echo GetMessage("BCL_CDN_USAGE", array(
					"#TRAFFIC#" => CFile::FormatSize($cdn_quota->getTrafficSize()),
					"#ALLOWED#" => CFile::FormatSize($cdn_quota->getAllowedSize()),
				)); ?></b></p>
				<div class="bitrixcloud-cdn-chart">
				<span class="bitrixcloud-cdn-chart-bar-yellow" style="width:100%"></span>
				</div>
			<?
			}
		}
	}
	catch (Exception $e)
	{
		CAdminMessage::ShowMessage($e->getMessage());
	}
}
if ($bVarsFromForm)
{
	$active = $_POST["cdn_active"] === "Y";
	$server_name = $_POST["server_name"];
}
else
{
	$active = CBitrixCloudCDN::IsActive();
	$server_name = $cdn_config->getDomain();
	if (!$server_name)
	{
		$server_name = COption::GetOptionString("main", "server_name", $_SERVER["HTTP_HOST"]);
	}
}
?>
<form method="POST" action="bitrixcloud_cdn.php?lang=<?echo LANGUAGE_ID ?><?echo $_GET["return_url"] ? "&amp;return_url=".urlencode($_GET["return_url"]) : "" ?>" enctype="multipart/form-data" name="editform">
<?
$tabControl->Begin();
$tabControl->BeginNextTab();
?>
<tr>
	<td width="40%">
		<label for="cdn_active"><?echo GetMessage("BCL_TURN_ON"); ?>:</label>
	</td>
	<td>
		<input type="hidden" name="cdn_active" value="N">
		<input type="checkbox" id="cdn_active" name="cdn_active" value="Y" <?echo $active ? 'checked="checked"' : '' ?>>
	</td>
</tr>
<?
$tabControl->BeginNextTab();
if ($bVarsFromForm)
{
	if (is_array($_POST["site"]))
		$sites = $_POST["site"];
	else
		$sites = array(
			1,
		);
}
else
{
	$sites = $cdn_config->getSites();
}
?>
	<tr>
		<td width="40%">
			<label for="site_admin"><?echo GetMessage("BCL_ADMIN_PANEL"); ?>:</label>
		</td>
		<td>
			<input type="checkbox" id="site_admin" name="site[admin]" value="y" <?echo (empty($sites) || isset($sites["admin"])) ? 'checked="checked"' : '' ?>>
		</td>
	</tr>
<?
$rsSites = CSite::GetList($by, $order, array());
while ($arSite = $rsSites->Fetch())
{
?>
	<tr>
		<td>
			<label for="site_<?echo htmlspecialchars($arSite["LID"]); ?>"><?echo htmlspecialcharsEx($arSite["NAME"]." [".$arSite["LID"]."]"); ?>:</label>
		</td>
		<td>
			<input type="checkbox" id="site_<?echo htmlspecialchars($arSite["LID"]); ?>" name="site[<?echo htmlspecialchars($arSite["LID"]); ?>]" value="y" <?echo (empty($sites) || isset($sites[$arSite["LID"]])) ? 'checked="checked"' : '' ?>>
		</td>
	</tr>
<?
}
$tabControl->BeginNextTab();
?>
	<tr>
		<td width="40%">
			<span class="required">*</span><?echo GetMessage("BCL_SERVER_URL"); ?>:
		</td>
		<td>
			<input type="text" name="server_name" value="<?echo htmlspecialchars($server_name); ?>">
		</td>
	</tr>
<?
$tabControl->Buttons(array(
	"back_url" => $_GET["return_url"] ? $_GET["return_url"] : "bitrixcloud_cdn.php?lang=".LANGUAGE_ID,
));
?>
<?echo bitrix_sessid_post(); ?>
<input type="hidden" name="lang" value="<?echo LANGUAGE_ID ?>">
<?
$tabControl->End();
?>
</form>
<?echo BeginNote(), GetMessage("BCL_NOTE"), EndNote();
require($_SERVER["DOCUMENT_ROOT"]."/bitrix/modules/main/include/epilog_admin.php"); ?>