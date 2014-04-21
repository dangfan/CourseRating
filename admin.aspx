<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="Web.PageAdmin" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>管理</title>
</head>
<body>
    <form id="form1" runat="server">
        <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        </ajax:ToolkitScriptManager>
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <ajax:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0">
                    <ajax:TabPanel ID="TabLogin" runat="server" HeaderText="登录">
                        <ContentTemplate>
                            <table align="center">
                                <tr>
                                    <td style="text-align: right">
                                        用户名：
                                    </td>
                                    <td>
                                        <asp:TextBox ID="Username" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">
                                        密码：
                                    </td>
                                    <td>
                                        <asp:TextBox ID="Password" runat="server" TextMode="Password" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="text-align: center">
                                        <asp:Button ID="ButtonLogin" runat="server" Text="登录" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </ajax:TabPanel>
                </ajax:TabContainer>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>
