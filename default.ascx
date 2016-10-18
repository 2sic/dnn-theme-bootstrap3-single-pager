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
    <span id="Top" class="co-mark Top"></span>
    <nav id="nav" role="navigation">
		<div class="ly-nav">
			<div class="container-fluid">
				<a class="scroll-top intLink co-hash-link" href="#Top">
					<!--[if gte IE 9]><!-->
					<img class="ly-logo" alt="skin-OnePager" src="<%=SkinPath%>images/logo.svg" data-fallback="<%=SkinPath%>images/logo.png" onerror="this.src=this.getAttribute('data-fallback');this.onerror=null;">
					<!--<![endif]-->
					<!--[if lt IE 9]>
					<img class="ly-logo" alt="skin-OnePager" src="<%=SkinPath%>images/logo.png" />
					<![endif]-->
				</a>
                <div id="NavPane" runat="server" containertype="G" containername="skin-OnePager" containersrc="default.ascx"></div>
                <!--
					<ToSic:languagenavigation runat="server" Languages="de-DE:DE,en-US:EN" /> 
				-->	
			</div>
		</div>
    </nav>
	<div>
		<section id="ContentPane" class="ly-section" runat="server" containertype="G" containername="skin-OnePager" containersrc="default.ascx"></section>
	</div>
    <a class="ly-scroll-button scroll-top co-hash-link" href="#Top" title="Nach oben">
        <span class="glyphicon glyphicon-menu-up"></span>
    </a>
</div>

<footer>
    <div style="float:left;"><dnn:login id="DnnLogin" cssclass="ly-login hidden-xs" runat="server" /></div>
    <div class="container-fluid">
        <div class="ly-container-inner clearfix">
          <a class="fancybox" data-fancybox-type="iframe" href="<%= LocalizeString("Impressum.Link") %>"><%= LocalizeString("Impressum.Text") %></a>&nbsp;&nbsp;&nbsp;
		  <a class="fancybox" data-fancybox-type="iframe" href="<%= LocalizeString("Links.Link") %>"><%= LocalizeString("Links.Text") %></a>
        </div>
    </div>
</footer>

<!-- include files in head -->
<dnn:DnnCssInclude runat="server" FilePath="dist/bootstrap.css" Priority="100" PathNameAlias="SkinPath" />
<dnn:DnnCssInclude runat="server" FilePath="lib/fancybox/jquery.fancybox.css" Priority="110" PathNameAlias="SkinPath" />
<dnn:DnnCssInclude runat="server" FilePath="dist/typography.css" Priority="120" PathNameAlias="SkinPath" />
<dnn:DnnCssInclude runat="server" FilePath="dist/layout.css" Priority="130" PathNameAlias="SkinPath" />
<dnn:DnnCssInclude runat="server" FilePath="dist/contactform.css" Priority="150" PathNameAlias="SkinPath" />
<dnn:DnnCssInclude runat="server" FilePath="~/Portals/_default/Skins/_default/ToEasyDNN.css" Priority="150" />
<dnn:DnnJsInclude runat="server" FilePath="lib/bootstrap/dist/js/bootstrap.min.js" ForceProvider="DnnFormBottomProvider" Priority="100" PathNameAlias="SkinPath" />
<dnn:DnnJsInclude runat="server" FilePath="lib/sidr/jquery.sidr.min.js" ForceProvider="DnnFormBottomProvider" Priority="110" PathNameAlias="SkinPath" />
<dnn:DnnJsInclude runat="server" FilePath="lib/fancybox/jquery.fancybox.pack.js" ForceProvider="DnnFormBottomProvider" Priority="120" PathNameAlias="SkinPath" />
<dnn:DnnJsInclude runat="server" FilePath="js/jquery.onePageNav.js" ForceProvider="DnnFormBottomProvider" Priority="130" PathNameAlias="SkinPath" />
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
		HtmlGenericControl body = (HtmlGenericControl)this.Page.FindControl("ctl00$body");
		body.Attributes["class"] = CssClass;
	}
	
	protected override void OnLoad(EventArgs e)
	{
		base.OnLoad(e);
		
		AttachCustomHeader("<meta name='viewport' content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, shrink-to-fit=no' />");
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
