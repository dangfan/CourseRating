<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="search.aspx.cs" Inherits="Web.search" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>清华晒课厅</title>
    <link href="css/master.css" rel="stylesheet" type="text/css" />
</head>
<body>

    <form id="form1" runat="server">
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Path="~/Scripts/jquery-1.6.2.min.js" />
        </Scripts>
    </ajax:ToolkitScriptManager>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
     <script type="text/javascript">
         $(document).ready(function () {
             
             window.parent.scrollTo(0, 0);
         });
         
    </script>
            <asp:HiddenField ID="sort_type" runat="server" />
            <asp:HiddenField ID="page_count" runat="server" />
            <asp:HiddenField ID="current_page" runat="server" />
            <asp:HiddenField ID="search_type" runat="server" />
            <asp:HiddenField ID="search_value" runat="server" />
            <asp:HiddenField ID="course_num" runat="server" />
            <asp:HiddenField ID="type" runat="server" />
            <asp:HiddenField ID="value" runat="Server" />
            <div id="head">
                <a id="logo" href="home.aspx">清华晒课厅</a>
                <div id="search_box">
                    <asp:TextBox ID="search_input" runat="server" />
                    <ajax:TextBoxWatermarkExtender ID="SearchExtender" runat="server" WatermarkText="课程名、课程号或老师名"
                        WatermarkCssClass="search_promp" TargetControlID="search_input" />
                    <asp:Button ID="search_button" Text="搜索" runat="server" OnClick="search_button_Click"
                        OnClientClick="return $('#search_input').val()!='课程名、课程号或老师名'" />
                </div>
                <div id="bread_crumbs">
                    <a href="home.aspx">首页</a><span class="arrow">&gt;</span><asp:Literal ID="LiteralName1"
                        runat="server"></asp:Literal></div>
            </div>
            <div id="content" style="margin-top: -24px;">
                <h1>
                    <asp:Literal ID="LiteralName2" runat="server"></asp:Literal><span><asp:Literal ID="LiteralNum"
                        runat="server"></asp:Literal></span></h1>
                <div id="sort"  >
                    <p>
                        排序</p>
                    <div id="drop_box">
                        <asp:Literal ID="Literal0" runat="server"></asp:Literal><input type="button" id="drop_button" 
                        onclick="$('#drop_list').slideToggle(100)"
                             /></div>
                    <ul id="drop_list" style="display: none" >
                        <li><a>
                            <asp:LinkButton ID="LinkButton1" runat="server" OnClick="sortType_button_Click">
                                <asp:Literal ID="Literal1" runat="server"></asp:Literal></asp:LinkButton></a></li>
                        <li><a>
                            <asp:LinkButton ID="LinkButton2" runat="server" OnClick="sortType_button_Click">
                                <asp:Literal ID="Literal2" runat="server"></asp:Literal></asp:LinkButton></a></li>
                        <li style="border-bottom: none;"><a>
                            <asp:LinkButton ID="LinkButton3" runat="server" OnClick="sortType_button_Click">
                                <asp:Literal ID="Literal3" runat="server"></asp:Literal></asp:LinkButton></a></li>
                    </ul>
                </div>
                <div class="line_bold">
                    <div class="bold_left">
                    </div>
                    <div class="bold_right">
                    </div>
                </div>
                <ul id="content_list">
                    <asp:Repeater ID="Repeater_Content" runat="server" OnItemDataBound="DataBound">
                        <ItemTemplate>
                            <asp:Label ID="Label_Content" runat="server" />
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
            <div id="page_indicator">
                <asp:Button ID="page_down" runat="server" Text="下一页" OnClick="pageDownClick"/>
                <asp:Button ID="page_up" runat="server" Text="上一页" OnClick="pageUpClick"/>
                <ul id="pages">
                    <asp:Repeater ID="Repeater_Page" runat="server" OnItemDataBound="PageDataBound">
                        <ItemTemplate>
                            <asp:Label ID="Label_Page" runat="server" />
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    </form>
</body>
</html>
