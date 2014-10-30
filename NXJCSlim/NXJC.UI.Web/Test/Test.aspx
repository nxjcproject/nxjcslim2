<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="NXJC.UI.Web.Test.Test" %>

<%@ Register src="../Common/OrganisationTree.ascx" tagname="OrganisationTree" tagprefix="uc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="/Scripts/easyui/themes/gray/easyui.css" rel="stylesheet" />
    <link href="/Scripts/EasyUI/themes/color.css" rel="stylesheet" />
    <link href="/Scripts/easyui/themes/icon.css" rel="stylesheet" />
    <script src="/Scripts/easyui/jquery.min.js"></script>
    <script src="/Scripts/easyui/jquery.easyui.min.js"></script>
    <script src="/Scripts/EasyUI/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
    <script>
        function onOrganisationTreeClick(object) {
            alert(object.text);
        }
    </script>
    <form id="form1" runat="server">
        <uc1:OrganisationTree ID="OrganisationTree1" runat="server" />
        <asp:GridView ID="GridView1" runat="server"></asp:GridView>
    </form>
</body>
</html>