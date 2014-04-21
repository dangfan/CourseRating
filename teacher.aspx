<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="teacher.aspx.cs" Inherits="Web.PageTeacher" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>清华晒课厅</title>
    <link href="css/master.css" rel="stylesheet" type="text/css" />
</head>

<body>
    <form id="form1" runat="server">
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Path="~/Scripts/jquery-1.6.2.min.js" />
            <asp:ScriptReference Path="~/Scripts/jQuery.mouseDelay.min.js" />
        </Scripts>
    </ajax:ToolkitScriptManager>

         <script type="text/javascript">
             $(document).ready(function () {
                 window.scrollTo(0, 0);
             });
         
    </script>
	<div id="head">
    	<a id="logo" href="home.aspx">清华晒课厅</a>
                <div id="search_box">
                    <asp:TextBox ID="search_input" runat="server" />
                    <ajax:TextBoxWatermarkExtender ID="SearchExtender" runat="server" WatermarkText="课程名、课程号或老师名"
                        WatermarkCssClass="search_promp" TargetControlID="search_input" />
                    <asp:Button ID="search_button" Text="搜索" runat="server" OnClick="HeaderSearchBox_Click"
                        OnClientClick="return $('#search_input').val()!='课程名、课程号或老师名'" />
                </div>
        <div id="bread_crumbs"><a href="home.aspx">首页</a><span class="arrow">&gt;</span><a href="search.aspx?type=1&value=<% = _teacher.Department %>"> <% = _teacher.Department %> </a><span class="arrow">&gt;</span> <% = _teacher.TeacherName %> </div>       	
	</div>

    <div id="content" style="margin-top:-20px;">
    	<h1> <% = _teacher.TeacherName %> </h1>
        <asp:Panel id="upsideline_div" runat="server" class="line_bold"><div class="bold_left"></div><div class="bold_right"></div></asp:Panel>
        <div class="section" style="width:500px;">
        <ul id="list_view">
		<li><span>性别</span> <% = _teacher.Gender %> </li>
        <li style="margin-right:0;"><span>单位</span> <a href="search.aspx?type=1&value=<% = _teacher.Department %>"><% = _teacher.Department %> </a></li>
        <li><span>职称</span> <% = _teacher.Position %> </li>
        </ul>
        </div>
        <asp:Panel id="samenameteachers_div" runat="server" class="side" style="clear:right;">
        	<div class="side_top"></div>
            <div class="side_mid">
            	<h3>重名教师<span><% = SameNameTeachersNum %></span></h3>
                <ul>
                <asp:Repeater ID="samename_repeater" runat="server">
                <ItemTemplate>
                    <li><a href="search.aspx?type=1&value=<%# DataBinder.Eval(Container.DataItem,"Department") %>"><%# DataBinder.Eval(Container.DataItem, "Department")%></a><a href="teacher.aspx?id=<%# DataBinder.Eval(Container.DataItem,"ID") %>"><div class="stress"><p> <% = _teacher.TeacherName %> </p></div></a></li>                    
                </ItemTemplate>
                </asp:Repeater>
                </ul>
            </div>
            <div class="side_bottom"></div>
        </asp:Panel>
        <div class="section"><h2>讲授课程</h2>
        	<div class="line_light"><div class="light_left"></div><div class="light_right"></div></div>
            <ul>
                <asp:Repeater ID="taughtcourses_repeater" runat="server" OnItemDataBound="TaughtCourses_Bound">
                <ItemTemplate>
                	<asp:Literal ID="course_item" runat="server" />
                    <a href="course.aspx?id=<%# DataBinder.Eval(Container.DataItem,"ID") %>" class="course"><%# DataBinder.Eval(Container.DataItem,"CourseName") %></a>
                    <a href="#" class="teacher"></a><p class="browse"><span><%# ((DAL.Course)Container.DataItem).CourseInfo.Visits %></span>浏览</p>
                    <div class="bar_list">
                    	<span class="bar_label">含金量</span>
                    	<div class="bar">
                        	<div class="bar1_head"></div>
                            <div class="bar1_body" style="width: <%# Math.Floor(((DAL.Course) Container.DataItem).CourseInfo.Gold / 10 * 124) %>px;"></div>
                            <div class="bar1_foot"><span><%# BLL.Utility.Round(((DAL.Course) Container.DataItem).CourseInfo.Gold) %></span></div>
                        </div>
                    </div>
                    <div class="bar_list">
                    	<span class="bar_label">轻松度</span>
                        <div class="bar">
                        	<div class="bar2_head"></div>
                            <div class="bar2_body" style="width:<%# Math.Floor(((DAL.Course) Container.DataItem).CourseInfo.Relax / 10 * 124) %>px;"></div>
                            <div class="bar2_foot"><span><%# BLL.Utility.Round(((DAL.Course)Container.DataItem).CourseInfo.Relax)%></span></div>
                        </div>
                    </div>
                    <div class="bar_list">
                    	<span class="bar_label">成绩值</span>
                        <div class="bar">
                        	<div class="bar3_head"></div>
                            <div class="bar3_body" style="width:<%# Math.Floor(((DAL.Course) Container.DataItem).CourseInfo.Mark / 10 * 124) %>px;"></div>
                            <div class="bar3_foot"><span><%# BLL.Utility.Round(((DAL.Course)Container.DataItem).CourseInfo.Mark)%></span></div>
						</div>
					</div>
					</li>
                </ItemTemplate>
                </asp:Repeater> 
            </ul>
        </div>
        
        </div>
   </form>
</body>
</html>
