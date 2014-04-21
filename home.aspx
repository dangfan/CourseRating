<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="Web.Home" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>清华晒课厅</title>
    <link rel="stylesheet" type="text/css" href="css/master.css" charset="utf-8" />
</head>
<body scroll="no">
    <form id="form1" runat="server">
    <ajax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Path="~/Scripts/jquery-1.6.2.min.js" />
            <asp:ScriptReference Path="~/Scripts/jQuery.mouseDelay.min.js" />
        </Scripts>
    </ajax:ToolkitScriptManager>
    <script type="text/javascript">
        function hover_tab() {
            $('#quick_link').hover(function () {
                if ($('#quicklink_tabc').css("display") == "none") {
                    $(this).css('background-position', '-96px -0px');
                }
            }, function () {
                if ($('#quicklink_tabc').css("display") == "none") {
                    $(this).css('background-position', '-0px -0px');
                }
            });
            $('#all_course').hover(function () {
                if ($('#allcourse_tabc').css("display") == "none") {
                    $(this).css('background-position', '-96px -34px');
                }
            }, function () {
                if ($('#allcourse_tabc').css("display") == "none") {
                    $(this).css('background-position', '-0px -34px');
                }
            });
        }
        function pageLoad() {
            hover_tab();
            showAllTheThingUp();
        }
        $(document).ready(function () {
           // $("#MyRandom").val() = parseInt(Math.random() * 30);
            //$("#MyRandom").val() = 1;
        });
        function showAllTheThingUp() {
            if ($("#allThingPage").val() == "0")
                $("#up_expand").hide();
            else
                $("#up_expand_line").hide();
        }
    </script>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <Triggers> 
<asp:PostBackTrigger ControlID="Repeater_Mark" /> 
<asp:PostBackTrigger ControlID="Repeater_Gold" /> 
<asp:PostBackTrigger ControlID="Repeater_visit" /> 
</Triggers>
        <ContentTemplate>
            <asp:HiddenField ID="allThingPage" runat="server" />
            <asp:HiddenField ID="MyRandom" runat="server" />
            <div id="head">
                <a id="logo" href="home.aspx">清华晒课厅</a>
                <div id="search_box">
                    <asp:TextBox ID="search_input" runat="server" />
                    <ajax:TextBoxWatermarkExtender ID="SearchExtender" runat="server" WatermarkText="课程名、课程号或老师名"
                        WatermarkCssClass="search_promp" TargetControlID="search_input" />
                    <asp:Button ID="search_button" Text="搜索" runat="server" OnClick="HeaderSearchBox_Click"
                        OnClientClick="return $('#search_input').val()!='课程名、课程号或老师名'" />
                </div>
                <div id="tab">
                    <ul id="nav">
                        <li><a  id="quick_link" onclick="$('#all_course').css('background-position','-0px -34px');$('#quick_link').css('background-position','-288px -0px');$('#allcourse_tabc').css('display','none');$('#quicklink_tabc').css('display','block');">
                            快速访问</a></li>
                        <li><a  id="all_course" onclick="$('#all_course').css('background-position','-288px -34px');$('#quick_link').css('background-position','-0px -0px');$('#allcourse_tabc').css('display','block');$('#quicklink_tabc').css('display','none');">
                            全部课程</a></li>
                    </ul>
                    <div class="line_bold">
                        <div class="bold_left">
                        </div>
                        <div class="bold_right">
                        </div>
                    </div>
                </div>
            </div>
            <div id="content">
                <div id="tab_content">
                    <div id="quicklink_tabc">
                        <ul>
                            <a href="search.aspx?type=3">
                                <li>
                                    <img src="image/icon_english.png" width="80" height="86" alt="英语课" />英语课<p>
                                        <span>326</span>门</p>
                                </li>
                            </a><a href="search.aspx?type=4">
                                <li>
                                    <img src="image/icon_pe.png" width="80" height="86" alt="体育课" />体育课<p>
                                        <span>406</span>门</p>
                                </li>
                            </a><a href="search.aspx?type=2&value=文化素质核心课">
                                <li style="margin-right: 0;">
                                    <img src="image/icon_quality.png" width="80" height="86" alt="文化素质核心课程" />文化素质核心课程<p>
                                        <span>85</span>门</p>
                                </li>
                            </a><a href="search.aspx?type=1&value=人文学院">
                                <li>
                                    <img src="image/icon_humanities.png" width="80" height="86" alt="人文学院课程" />人文学院课程<p>
                                        <span>380</span>门</p>
                                </li>
                            </a><a href="search.aspx?type=1&value=艺教中心">
                                <li>
                                    <img src="image/icon_art.png" width="80" height="86" alt="艺教中心课程" />艺教中心课程<p>
                                        <span>68</span>门</p>
                                </li>
                            </a><a href="search.aspx?type=5">
                                <li style="margin-right: 0;">
                                    <img src="image/icon_2nd.png" width="80" height="86" alt="第二外国语课程" />第二外国语课程<p>
                                        <span>55</span>门</p>
                                </li>
                            </a>
                        </ul>
                        <div id="history">
                            <h2>
                                最常关注</h2>
                            
                            <asp:LinkButton ID="clean" runat="server"></asp:LinkButton>
                            <div class="line_light">
                                <div class="light_left">
                                </div>
                                <div class="light_right">
                                </div>
                            </div>
                            <ul>
                                <asp:Repeater ID="visitedcourse_repeator" runat="server" OnItemDataBound="VisitedCourse_Bound">
                                    <ItemTemplate>
                                        <asp:Literal ID="visitedcourse_item" runat="server" /><a href="course.aspx?id=<%# DataBinder.Eval(Container.DataItem,"ID") %>"><%# DataBinder.Eval(Container.DataItem,"CourseName") %></a></literal>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </ul>
                        </div>
                    </div>
                    <div id="allcourse_tabc" style="display: none;">
                        <div id="course_department">
                            <h2>
                                开课系</h2>
                            <div class="line_mid">
                                <div class="mid_left">
                                </div>
                                <div class="mid_right">
                                </div>
                            </div>
                            <div id="technology">
                                理工类
                                <div class="line_light">
                                    <div class="light_left">
                                    </div>
                                    <div class="light_right">
                                    </div>
                                </div>
                                <table width="328" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=建筑学院">建筑学院</a>
                                        </td>
                                        <td>
                                            <a href="search.aspx?type=1&value=热能系">热能系</a>
                                        </td>
                                        <td>
                                            <a href="search.aspx?type=1&value=工物系">工物系</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=建筑系">建筑系</a>
                                        </td>
                                        <td>
                                            <a href="search.aspx?type=1&value=汽车系">汽车系</a>
                                        </td>
                                        <td>
                                            <a href="search.aspx?type=1&value=化工系">化工系</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=建筑技术">建筑技术</a>
                                        </td>
                                        <td>
                                            <a href="search.aspx?type=1&value=工业工程">工业工程</a>
                                        </td>
                                        <td>
                                            <a href="search.aspx?type=1&value=生命学院">生命科学</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=土水学院">土水学院</a>
                                        </td>
                                        <td>
                                            <a href="search.aspx?type=1&value=电机系">电机系</a>
                                        </td>
                                        <td>
                                            <a href="search.aspx?type=1&value=交叉信息院">交叉信息研究院</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=土木系">土木系</a>
                                        </td>
                                        <td>
                                            <a href="search.aspx?type=1&value=电子系">电子系</a>
                                        </td>
                                        <td>
                                            <a href="search.aspx?type=1&value=数学系">数学系</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=水利系">水利系</a>
                                        </td>
                                        <td>
                                            <a href="search.aspx?type=1&value=计算机系">计算机系</a>
                                        </td>
                                        <td>
                                            <a href="search.aspx?type=1&value=物理系">物理系</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=建管系">建管系</a>
                                        </td>
                                        <td>
                                            <a href="search.aspx?type=1&value=自动化系">自动化系</a>
                                        </td>
                                        <td>
                                            <a href="search.aspx?type=1&value=化学系">化学系</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=环境系">环境系</a>
                                        </td>
                                        <td>
                                            <a href="search.aspx?type=1&value=软件学院">软件学院</a>
                                        </td>
                                        <td>
                                            <a href="search.aspx?type=1&value=医学院">医学院</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=机械系">机械系</a>
                                        </td>
                                        <td>
                                            <a href="search.aspx?type=1&value=微纳电子系">微纳电子系</a>
                                        </td>
                                        <td>
                                            <a href="search.aspx?type=1&value=生医系">生医系</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=精仪系">精仪系</a>
                                        </td>
                                        <td>
                                            <a href="search.aspx?type=1&value=航院">航院</a>
                                        </td>
                                        <td>
                                            <a href="search.aspx?type=1&value=材料系">材料系</a>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id="literature">
                                文史类
                                <div class="line_light">
                                    <div class="light_left">
                                    </div>
                                    <div class="light_right">
                                    </div>
                                </div>
                                <table cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=经管学院">经管学院</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=公共管理">公管学院</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=人文学院">人文学院</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=外语系">外语系</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=中文系">中文系</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=法学院">法学院</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=新闻学院">新闻学院</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=马克思主义学院">马克思主义学院</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=美术学院">美术学院</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id="other">
                                其他
                                <div class="line_light">
                                    <div class="light_left">
                                    </div>
                                    <div class="light_right">
                                    </div>
                                </div>
                                <table cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=体育部">体育部</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=宣传部">宣传部</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=学生部">学生部</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=武装部">武装部</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=图书馆">图书馆</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=校医院">校医院</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=教研院">教研院</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=艺教中心">艺教中心</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="search.aspx?type=1&value=训练中心">训练中心</a>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div id="course_type">
                            <h2>
                                课程类型</h2>
                            <div class="line_mid">
                                <div class="mid_left">
                                </div>
                                <div class="light_right">
                                </div>
                            </div>
                            <table style="clear: both; float: left; height: 132px;" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td>
                                        <a href="search.aspx?type=2&value=专题研讨课">专题研讨课</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <a href="search.aspx?type=2&value=双语课">双语课</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <a href="search.aspx?type=2&value=实践课">实践课</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <a href="search.aspx?type=2&value=实验课">实验课</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <a href="search.aspx?type=2&value=文化素质核心课">文化素质核心课</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <a href="search.aspx?type=2&value=新生研讨课">新生研讨课</a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <div id="top_list">
                    <div class="label">
                        <img src="image/label_top.gif" alt="排行榜" /></div>
                    <div class="line_bold">
                        <div class="bold_left">
                        </div>
                        <div class="bold_right">
                        </div>
                    </div>
                    <div class="section">
                        <h2>
                            <a href="search.aspx?type=6">推荐最热门</a></h2>
                        <div class="line_light">
                            <div class="light_left">
                            </div>
                            <div class="light_right">
                            </div>
                        </div>
                        <ul>
                            <asp:Repeater ID="Repeater_visit" runat="server" OnItemDataBound="VisitDataBound">
                                <ItemTemplate>
                                    <asp:Label ID="Label_visit" runat="server" />
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </div>
                    <div class="section">
                        <h2>
                            <a href="search.aspx?type=7">内容最精华</a></h2>
                        <div class="line_light">
                            <div class="light_left">
                            </div>
                            <div class="light_right">
                            </div>
                        </div>
                        <ul>
                            <asp:Repeater ID="Repeater_Gold" runat="server" OnItemDataBound="GoldDataBound">
                                <ItemTemplate>
                                    <asp:Label ID="Label_gold" runat="server" />
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </div>
                    <div class="section">
                        <h2>
                            <a href="search.aspx?type=8">给分最厚道</a></h2>
                        <div class="line_light">
                            <div class="light_left">
                            </div>
                            <div class="light_right">
                            </div>
                        </div>
                        <ul>
                            <asp:Repeater ID="Repeater_Mark" runat="server" OnItemDataBound="MarkDataBound">
                                <ItemTemplate>
                                    <asp:Label ID="Label_mark" runat="server" />
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </div>
                </div>
                <div id="news">
                    <div class="label">
                        <img src="image/label_news.gif" alt="最新动态" /></div>
                    <div class="line_bold">
                        <div class="bold_left">
                        </div>
                        <div class="bold_right">
                        </div>
                    </div>
                    <div class="section">
                        <div class="news_list">
                            <a href="#">
                                <img src="image/mascat.png" width="50" height="50" /></a>
                            <div class="news_content">
                                <h3>
                                    管理猿有话说：</h3>
                                <span class="time">12月10日&nbsp;2011年</span>
                                <div class="content_container">
                                    <div class="quotation_left">
                                    </div>
                                    <p class="added_index">
                                        亲爱的同学们~这个学期已经快结束啦<br />
                                        拉上你的亲朋好友，一起来给你上过的课程打分评价吧！造福社会，积攒RP！<br />
                                        祝大家考试顺利噢！！！！<br />
                                        <strong>注意：请使用 搜狗浏览器 的同学切换到 高速模式 否则不能正确浏览~ 推荐使用Chrome、Firefox等主流浏览器</strong><br />
                                        
                                        <p>
                                            <div class="quotation_right">
                                            </div>
                                </div>
                            </div>
                        </div>
                        <a href="#">
                            <div id="up_expand">
                                <div id="up_expand_left">
                                </div>
                           
                                <asp:LinkButton ID="up_expand_middle" runat="server" OnClick="up_expand_middle_Click"></asp:LinkButton>
                                <div id="up_expand_right">
                                </div>
                            </div>
                             <div class="line_light" id="up_expand_line"><div class="bold_left"></div><div class="bold_right"></div></div>
                        </a>
                        <asp:Repeater ID="Repeater_NewThing" runat="server" OnItemDataBound="NewThingDataBound">
                            <ItemTemplate>
                                <asp:Label ID="Label_NewThing" runat="server" />
                            </ItemTemplate>
                        </asp:Repeater>
                        <a href="#">
                            <div id="news_expand">
                                <div id="expand_left">
                                </div>
                                <asp:LinkButton ID="expand_middle" runat="server" OnClick="expand_middle_Click"></asp:LinkButton>
                                <div id="expand_right">
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
            <div id="footer">
                <p>
                    我们是4位来自清华的本科生，出自共同的兴趣开发了这款人人上的应用。希望对您选课、蹭课、求课、换课、谈课提供帮助。<br />
                    因能力、水平有限，如果您遇到什么问题或是有宝贵的建议，欢迎您联系我们。 此外，我们也真心地希望清华的研究生以及外校的同学能够加入到这一平台中，为更多的同学提供帮助。<br />
                    最后，衷心感谢您的关注和支持！
                </p>
                <div id="designer">
                    设计虱
                    <div class="line_light">
                        <div class="light_left">
                        </div>
                        <div class="light_right">
                        </div>
                    </div>
                    <a href="http://www.renren.com/profile.do?id=254640050" target="_new" title="丁棘">
                        <div id="Dinghy">
                        </div>
                    </a>
                </div>
                <div id="coder">
                    程序猿
                    <div class="line_light">
                        <div class="light_left">
                        </div>
                        <div class="light_right">
                        </div>
                    </div>
                    <a href="http://www.renren.com/chenr09" target="_new" title="陈然">
                        <div id="ChenRan">
                        </div>
                    </a><a href="http://www.renren.com/profile.do?id=365898802" target="_new" title="丁鹏">
                        <div id="DingPeng">
                        </div>
                    </a><a href="http://www.renren.com/dangfan" target="_new" title="党凡">
                        <div id="DangFan">
                        </div>
                    </a>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    </form>
</body>
</html>
