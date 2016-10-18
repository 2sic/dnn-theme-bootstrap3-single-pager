<%@ Control language="C#" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>
<%@ Register TagPrefix="dnn" TagName="LOGIN" Src="~/Admin/Skins/Login.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.DDRMenu.TemplateEngine" Assembly="DotNetNuke.Web.DDRMenu" %>
<%@ Register TagPrefix="dnn" TagName="MENU" src="~/DesktopModules/DDRMenu/Menu.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>
<%@ Register TagPrefix="ToFlex" TagName="Copyright" Src="~/DesktopModules/2flexCopyright/2flexCopyright.ascx" %>
<%@ Register tagPrefix="ToSic" tagName="LanguageNavigation" src="controls/LanguageNavigation.ascx" %>

<!-- GOOGLE UNIVERSAL ANALYTICS TRACKING -->
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-71407461-1', 'auto');
  ga('send', 'pageview');

</script>
<!-- /GOOGLE UNIVERSAL ANALYTICS TRACKING -->

<a class="sr-only sr-only-focusable" href="#content"><%= LocalizeString("SkipLink.MainContent") %></a>

<div id="content">
<section id="ContentPane" class="ly-section" runat="server" containertype="G" containername="Quaderer" containersrc="default.ascx"></section>
</div>


<!-- include files in head -->
<dnn:DnnCssInclude runat="server" FilePath="css/bootstrap-custom/bootstrap.css" Priority="100" PathNameAlias="SkinPath" />
<dnn:DnnCssInclude runat="server" FilePath="lib/fancybox/jquery.fancybox.css" Priority="110" PathNameAlias="SkinPath" />
<dnn:DnnCssInclude runat="server" FilePath="css/screen/typography.css" Priority="120" PathNameAlias="SkinPath" />
<dnn:DnnCssInclude runat="server" FilePath="css/screen/layout.css" Priority="130" PathNameAlias="SkinPath" />
<dnn:DnnCssInclude runat="server" FilePath="css/print/layout.css" Priority="140" PathNameAlias="SkinPath" />
<dnn:DnnCssInclude runat="server" FilePath="css/screen/contactform.css" Priority="150" PathNameAlias="SkinPath" />
<dnn:DnnCssInclude runat="server" FilePath="~/Portals/_default/Skins/_default/ToEasyDNN.css" Priority="150" />
<dnn:DnnJsInclude runat="server" FilePath="lib/bootstrap/dist/js/bootstrap.min.js" ForceProvider="DnnFormBottomProvider" Priority="100" PathNameAlias="SkinPath" />
<dnn:DnnJsInclude runat="server" FilePath="lib/sidr/jquery.sidr.min.js" ForceProvider="DnnFormBottomProvider" Priority="110" PathNameAlias="SkinPath" />
<dnn:DnnJsInclude runat="server" FilePath="lib/fancybox/jquery.fancybox.pack.js" ForceProvider="DnnFormBottomProvider" Priority="120" PathNameAlias="SkinPath" />
<dnn:DnnJsInclude runat="server" FilePath="js/jquery.onePageNav.js" ForceProvider="DnnFormBottomProvider" Priority="130" PathNameAlias="SkinPath" />
<dnn:DnnJsInclude runat="server" FilePath="lib/hyphenator/Hyphenator.js" ForceProvider="DnnFormBottomProvider" Priority="131" PathNameAlias="SkinPath" />
<dnn:DnnJsInclude runat="server" FilePath="js/scripts.js" ForceProvider="DnnFormBottomProvider" Priority="140" PathNameAlias="SkinPath" />

<script runat="server">
	protected override void OnPreRender(EventArgs e)
	{
		base.OnPreRender(e);
		AddCSSClassesForSkinning();
		NormalizePageTitle();
	}
	
	private void AddCSSClassesForSkinning()
	{
		//add language, edit mode, tab-id and root-tab-id to body css class
		string CssClass = "tab-" + PortalSettings.ActiveTab.TabID.ToString() + " ";
		if(DotNetNuke.Security.PortalSecurity.IsInRoles(PortalSettings.AdministratorRoleName))
			CssClass += "role-admin ";
		CssClass += "tab-level-" + PortalSettings.ActiveTab.Level + " ";
		CssClass += "root-" + ((DotNetNuke.Entities.Tabs.TabInfo)PortalSettings.ActiveTab.BreadCrumbs[0]).TabID.ToString() + " ";
		var rootTab = ((DotNetNuke.Entities.Tabs.TabInfo)PortalSettings.ActiveTab.BreadCrumbs[0]);
		rootTab = rootTab.IsDefaultLanguage || rootTab.IsNeutralCulture ? rootTab : rootTab.DefaultLanguageTab;
		CssClass += "lang-root-" + rootTab.TabID + " ";
		CssClass += "lang-" + System.Threading.Thread.CurrentThread.CurrentCulture.TwoLetterISOLanguageName.ToLower() + " ";
		CssClass += (PortalSettings.HomeTabId == PortalSettings.ActiveTab.TabID ? "tab-home " : "") + " ";
		CssClass += "portal-" + PortalSettings.Current.PortalId;
		CssClass += " ly-blankskin ";
		HtmlGenericControl body = (HtmlGenericControl)this.Page.FindControl("ctl00$body");
		body.Attributes["class"] = CssClass;
	}
	
	protected override void OnLoad(EventArgs e)
	{
		base.OnLoad(e);
		
		AttachCustomHeader("<meta name='viewport' content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' />");
		AttachCustomHeader("<!--[if lt IE 9]>" +
			"<script type='text/javascript' src='https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js'></scr" + "ipt>" +
			"<script type='text/javascript' src='https://oss.maxcdn.com/respond/1.4.2/respond.min.js'></scr" + "ipt>" +
			"<![endif]-->");
	}
	
	protected void AttachExternalCSS(string CSSPath) { AttachCustomHeader("<link type='text/css' rel='stylesheet' href='" + CSSPath + "' />"); }
	protected void AttachExternalJS(string JSPath) { AttachCustomHeader("<script type='text/javascript' src='" + JSPath + "'></scr" + "ipt>"); }
	protected void AttachCustomHeader(string CustomHeader) { HtmlHead HtmlHead = (HtmlHead)Page.FindControl("Head"); if ((HtmlHead != null)) { HtmlHead.Controls.Add(new LiteralControl(CustomHeader));	}	}
	
	protected string LocalizeString(string key)
	{
			return Localization.GetString(key, Localization.GetResourceFile(this, System.IO.Path.GetFileName(this.AppRelativeVirtualPath)));
	}
	
	// SEO page title script - v 1.1
    private void NormalizePageTitle()
    {
        const string separator = " | ";
        const int depth = 5;
        const bool includePortalName = true;
        
        // Set SEO page title
        Page.Title = String.Join(separator, PortalSettings.ActiveTab.BreadCrumbs.Cast<DotNetNuke.Entities.Tabs.TabInfo>()
            .Reverse().Take(depth).Select(p => p.TabID == PortalSettings.ActiveTab.TabID ? (p.Title != "" ? p.Title : p.TabName) : p.TabName).ToArray()) + 
            (includePortalName && !PortalSettings.ActiveTab.Title.Contains(PortalSettings.PortalName) ? separator + PortalSettings.PortalName : "");
    }
	
</script>
