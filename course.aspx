<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="course.aspx.cs" Inherits="Web.PageCourse" %>
<%@ Import Namespace="DAL" %>
<%@ Import Namespace="RenrenApi" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
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
        // 记录评分栏是否修改
        var scoreChanged = false;
        // 记录是否评过分
        var scored = false;
        // 记录地点历史状态
        var placeHistoryCollasped = true;
        // 发布地点按钮是否点击
        var publishPlaceClicked = false;
        // 修改地点按钮是否点击
        var wrongPlaceClicked = false;
        // 被展开的回复
        var replies = new Array();
        // 是否播放换页动画
        var discussAnimation = false;

        function pageLoad() {
            initSlider();
            showScore();
            showDiscuss();
        }

        // 显示讨论区
        function showDiscuss() {
            if (discussAnimation) {
                $("#DiscussArea").hide();
                $("#DiscussArea").fadeTo(300, 1);
                discussAnimation = false;
            }
        }

        // 给Slider（评分栏）赋初值、绑定事件
        function initSlider() {
            var slider;
            slider = window.$find("SliderExtender1"); slider.set_Value(6);
            slider = window.$find("SliderExtender2"); slider.set_Value(6);
            slider = window.$find("SliderExtender3"); slider.set_Value(6);
            $(".slider1").bind("mousedown", function () { scoreChanged = true; $("#ok").attr("disabled", false); });
            $(".slider2").bind("mousedown", function () { scoreChanged = true; $("#ok").attr("disabled", false); });
            $(".slider3").bind("mousedown", function () { scoreChanged = true; $("#ok").attr("disabled", false); });
        }

        // 设置评分栏动画，由后台调用
        function setupScore() {
            $("#pop_up").mouseDelay(250).hover(null, function() { if (!scoreChanged) $("#pop_up").fadeOut(); }); // 隐藏评分栏
            $("#commentary").mouseDelay(250).hover(function() { $("#pop_up").fadeIn(); }, null); // 显示评分栏
        }

        // 显示我的评分
        function showScore() {
            if (scored) {   // 第一次评分后播放动画
                $('#my_rating').hide();
                $('#my_rating').fadeIn();
            }
            else
                $('#my_rating').show();
            scored = false;
        }

        // 展开/收起闲聊回复
        function toggleChatReply(id) {
            $("#chat_reply" + id).slideToggle();
            $("#chatreply_frame" + id + " textarea").focus();
            // 记录被点击情况
            replies["#chat_reply" + id] = replies["#chat_reply" + id] == null
                                            ? true : !replies["#chat_reply" + id];
        }

        // 展开/收起求助回复
        function toggleHelpReply(id) {
            $("#help_reply" + id).slideToggle();
            $("#helpreply_frame" + id + " textarea").focus();
            // 记录被点击情况
            replies["#help_reply" + id] = replies["#help_reply" + id] == null
                                            ? true : !replies["#help_reply" + id];
        }

        // 维持各slide状态，这个必须在Page_Load里完成，否则会覆盖其他动画
        function fixCollaspe() {
            if (!placeHistoryCollasped) {
                $("#history").show();
                $("#expand_arrow").css("background-position", "-11px 0");
            }
            for (var id in replies) {
                if (replies[id])
                    $(id).show();
            }
        }

        // 展开/收起地点历史记录
        function togglePlaceHistory() {
            if (placeHistoryCollasped) {
                $("#history").slideDown();
                $("#expand_arrow").css("background-position", "-11px 0");
                placeHistoryCollasped = false;
            } else {
                $("#history").slideUp();
                $("#expand_arrow").css("background-position", "0 0");
                placeHistoryCollasped = true;
            }
        }

        // 直接显示地点栏
        function showNormalPlaces() {
            if (publishPlaceClicked && wrongPlaceClicked) {
                publishPlaceClicked = false;
                wrongPlaceClicked = false;
                return;
            }
            $("#unknown_place").hide();
            $("#place_known").show();
        }

        // 动画显示地点栏
        function showAnimatedPlaces() {
            $("#unknown_place").slideUp();
            $("#place_known").delay(500).slideDown();
        }

        // 显示地点有误
        function wrongPlace() {
            if ($("#unknown_place").css("display") != "none") return;
            $("#unknown_place").css("height", "166px");
            $("#unknown_content").prepend("<div id=\"WrongPlace\"><h3>地点有误？</h3><div class=\"white_line\"></div></div>");
            $("#place_known").slideUp();
            $("#unknown_place").delay(500).slideDown();
        }

        // 点击回复，显示姓名
        function showReplyText(textid, name) {
            $(textid).focus().val("回复" + $.trim(name) + "：");
        }

        // 显示发帖区
        function showPostArea() {
            $('#NewPostArea').animate({ height: '80px' });
            $("#new_post").slideDown();
        }

        // 隐藏发帖区
        function hidePostArea() {
            var length = $("#NewPostArea").val().length;
            if (length > 0) return;
            $('#NewPostArea').animate({ height: '20px' });
            $("#new_post").slideUp();
        }

        // 检查字数
        function checkPost() {
            var length = $("#NewPostArea").val().length;
            if (length > 140) {
                $("#NewPostArea").val($("#NewPostArea").val().substr(0, 140));
                return;
            }
            $("#chars_count").html(length);
        }

        // 闲聊按钮点击
        function onTabChatClick() {
            $('#tab_help').css('background-position', '0 0');
            $('#tab_chat').css('background-position', '-195px -25px');
            $('#SearchPostTextBox').val('');
            $('#DiscussArea').fadeTo(300, 0);
            discussAnimation = true;
        }

        // 帮助按钮点击
        function onTabHelpClick() {
            $('#tab_help').css('background-position', '-195px 0');
            $('#tab_chat').css('background-position', '0 -25px');
            $('#SearchPostTextBox').val('');
            $('#DiscussArea').fadeTo(300, 0);
            discussAnimation = true;
        }
    </script>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
                <ContentTemplate>
                    <div id="head">
                        <a id="logo" href="home.aspx">清华晒课厅</a>
                        <div id="search_box">
                            <asp:TextBox ID="search_input" runat="server" />
                            <ajax:TextBoxWatermarkExtender ID="SearchExtender" runat="server" WatermarkText="课程名、课程号或老师名"
                                                           WatermarkCssClass="search_promp" TargetControlID="search_input" />
                            <asp:Button ID="search_button" Text="搜索" runat="server" OnClick="HeaderSearchBox_Click"
                                        OnClientClick="return $('#search_input').val()!='课程名、课程号或老师名'" />
                        </div>
                        <div id="bread_crumbs">
                            <a href="home.aspx">首页</a> <span class="arrow">&gt;</span> <a href="search.aspx?type=1&value=<% =CurrentCourse.Department%>">
                                                                                           <% =CurrentCourse.Department%></a> <span class="arrow">&gt;</span>
                            <% =CurrentCourse.CourseName%>
                        </div>
                    </div>
                    <div id="content" style="margin-top: -20px;">
                        <h1>
                            <% =CurrentCourse.CourseName%><asp:Literal ID="NotExist" runat="server" /></h1>
                        <div class="line_bold" style="width: 542px;">
                            <div class="bold_left">
                            </div>
                            <div class="bold_right">
                            </div>
                        </div>
                        <div id="course_content">
                            <div class="pop_up" style="right: -22px;" id="pop_up">
                                <a href="javascript:$('#pop_up').fadeOut();" class="pop_close"></a>
                                <div class="pop_content" style="margin-top: 22px;">
                                    <div class="title">
                                        我来评分</div>
                                    <table cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="38">
                                                含金量
                                            </td>
                                            <td width="134">
                                                <div class="v1">
                                                    <asp:TextBox ID="TextBox1" runat="server" Style="display: none;" /></div>
                                                <div class="indication">
                                                    课程水不水</div>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="CourseGold" MaxLength="2" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                轻松度
                                            </td>
                                            <td>
                                                <div class="v2">
                                                    <asp:TextBox ID="TextBox2" runat="server" Style="display: none;" />
                                                </div>
                                                <div class="indication">
                                                    点名、签到、作业…你懂的</div>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="CourseRelax" MaxLength="2" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                成绩值
                                            </td>
                                            <td>
                                                <div class="v3">
                                                    <asp:TextBox ID="TextBox3" runat="server" Style="display: none;" />
                                                </div>
                                                <div class="indication">
                                                    给分厚不厚道，够不够意思</div>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="CourseMark" MaxLength="2" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:Button ID="ok" Text="确定" runat="server" OnClientClick="$('#pop_up').fadeOut();$('#recommend').animate({top:'180px'});scored=true;"
                                                OnClick="Score_Click" Enabled="False" />
                                </div>
                            </div>
                            <ajax:SliderExtender ID="SliderExtender1" TargetControlID="TextBox1" runat="server"
                                                 Maximum="10" BoundControlID="CourseGold" HandleImageUrl="image/empty.png" HandleCssClass="slider1"
                                                 RailCssClass="v1" />
                            <ajax:SliderExtender ID="SliderExtender2" TargetControlID="TextBox2" runat="server"
                                                 Maximum="10" BoundControlID="CourseRelax" HandleImageUrl="image/empty.png" HandleCssClass="slider2"
                                                 RailCssClass="v2" />
                            <ajax:SliderExtender ID="SliderExtender3" TargetControlID="TextBox3" runat="server"
                                                 Maximum="10" BoundControlID="CourseMark" HandleImageUrl="image/empty.png" HandleCssClass="slider3"
                                                 RailCssClass="v3" />
                            <div id="commentary">
                                <table cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td>
                                            含金量
                                        </td>
                                        <td>
                                            <div class="bar">
                                                <div class="bar1_head">
                                                </div>
                                                <div class="bar1_body" style="width: <% =Math.Floor(CurrentCourse.CourseInfo.Gold/10*123)%>px;">
                                                </div>
                                                <div class="bar1_foot">
                                                    <span>
                                                        <% =BLL.Utility.Round(CurrentCourse.CourseInfo.Gold)%></span>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            轻松度
                                        </td>
                                        <td>
                                            <div class="bar">
                                                <div class="bar2_head">
                                                </div>
                                                <div class="bar2_body" style="width: <% =Math.Floor(CurrentCourse.CourseInfo.Relax/10*123)%>px;">
                                                </div>
                                                <div class="bar2_foot">
                                                    <span>
                                                        <% =BLL.Utility.Round(CurrentCourse.CourseInfo.Relax)%></span>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            成绩值
                                        </td>
                                        <td>
                                            <div class="bar">
                                                <div class="bar3_head">
                                                </div>
                                                <div class="bar3_body" style="width: <% =Math.Floor(CurrentCourse.CourseInfo.Mark/10*123)%>px;">
                                                </div>
                                                <div class="bar3_foot">
                                                    <span>
                                                        <% =BLL.Utility.Round(CurrentCourse.CourseInfo.Mark)%></span>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                                <p>
                                    <span>
                                        <% =CurrentCourse.CourseInfo.ScoredNum%></span>人评价</p>
                            </div>
                            <asp:Panel ID="my_rating" runat="server">
                                <p>
                                    我的评分</p>
                                <div class="bar_list">
                                    <div class="plain_text">
                                        <span class="bar_label" style="margin-left: 4px;">含金量</span> <span class="number">
                                                                                                         <asp:Literal ID="MyGold" runat="server" /></span>
                                    </div>
                                    <div class="plain_text">
                                        <span class="bar_label">轻松度</span> <span class="number">
                                                                               <asp:Literal ID="MyRelax" runat="server" /></span>
                                    </div>
                                    <div class="plain_text">
                                        <span class="bar_label" style="margin-right: 0;">成绩值</span> <span class="number"
                                                                                                          style="margin-right: 0;">
                                                                                                        <asp:Literal ID="MyMark" runat="server" /></span>
                                    </div>
                                </div>
                            </asp:Panel>
                            <asp:Panel runat="server" ID="recommend">
                                <asp:Button ID="RcmdButton" runat="server" Text="推荐" OnClick="RcmdButton_Click" />
                                <p>
                                    <asp:Label ID="RcmdNum" runat="server" Text="" />人推荐</p>
                            </asp:Panel>
                            <ul id="list_view">
                                <li style="clear: both; margin-right: 0;"><span>主讲教师</span><a href="teacher.aspx?id=<% =CurrentCourse.TeacherID%>"><% =CurrentCourse.Teacher.TeacherName%></a></li>
                                <li id="unknown_place" style="margin: -2px -4px 6px -4px; padding: 2px 4px; width: 262px; height: 136px;"><span>上课地点</span>
                                    <div style="float: left; width: 200px;" id="unknown_content">
                                        <div class="text">
                                            知道地点？</div>
                                        <div class="know_place">
                                            <asp:TextBox ID="place_input" CssClass="place_input" runat="server" onkeyup="if (window.event.keyCode == 13) $('#place_publish').click();" />
                                            <asp:Button ID="place_publish" CssClass="place_publish" runat="server" Text="发布"
                                                        OnClick="PlacePublish_Click" OnClientClick="$('#WrongPlace').slideUp();publishPlaceClicked=true;" />
                                        </div>
                                        <div class="line_light">
                                            <div class="light_left">
                                            </div>
                                            <div class="light_right">
                                            </div>
                                        </div>
                                        <div class="text">
                                            不知道地点？</div>
                                        <asp:Button ID="AskForHelpButton" runat="server" Text="向好友求助" class="place_help" OnClick="AskForHelpButton_Click" />
                                    </div>
                                </li>
                                <li style="clear: both; margin-right: 0; width: 260px; display: none;" id="place_known">
                                    <span>上课地点</span><asp:Literal ID="PlaceLabel" runat="server" />
                                    <input type="button" id="quiz" value="地点有疑问" onclick="wrongPlaceClicked=true;wrongPlace(); " />
                                    <asp:Panel runat="server" ID="quiz_num"></asp:Panel>
                                    <div id="donator">
                                        <div class="arrow_up">
                                        </div>
                                        <div id="donator_content">
                                            <div id="content_top">
                                            </div>
                                            <div id="content_mid" style="height: 58px;">
                                                <asp:Literal ID="PlacePublisherImg" runat="server" />
                                                <div class="words">
                                                    感谢<asp:Literal ID="PlacePublisher" runat="server" /><br />的分享</div>
                                                <div class="date">
                                                    <asp:Literal ID="PlacePublishDate" runat="server" /></div>
                                            </div>
                                            <ul id="history">
                                                <asp:Repeater ID="HistoryRepeater" runat="server">
                                                    <ItemTemplate>
                                                        <li>
                                                            <a href="<%#BLL.Utility.GetRenrenUrl(((CoursePlcace) Container.DataItem).EditorId)%>" target="_blank"><img src="<%# BLL.UserThingBll.GetPic(((CoursePlcace) Container.DataItem).EditorId)%>" width="50" height="50" /></a>
                                                            <div class="words">
                                                                <a href="<%#BLL.Utility.GetRenrenUrl(((CoursePlcace) Container.DataItem).EditorId)%>" target="_blank">
                                                                    <%#((CoursePlcace) Container.DataItem).EditorName%></a><br />
                                                                <%#((CoursePlcace) Container.DataItem).Place%></div>
                                                            <div class="date">
                                                                <%#((CoursePlcace) Container.DataItem).EditTime.ToLongDateString()%></div>
                                                        </li>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </ul>
                                            <a href="javascript:togglePlaceHistory()" id="expand_history">
                                                <div id="expand_arrow" style="margin-top: 2px;">
                                                </div>
                                            </a>
                                        </div>
                                    </div>
                                </li>
                                <li style="clear: both; margin-right: 0; width: 270px"><span>时间</span><% =CurrentCourse.Time%></li>
                                <li style="clear: both; margin-right: 0;"><span>课容量</span><% =CurrentCourse.CapacityForUnder%>/<% =CurrentCourse.CapacityForGra%></li>
                                <li><span>学分</span><% =CurrentCourse.Credit%></li>
                                <li style="clear: both; margin-right: 0;"><span>课程号</span><% =CurrentCourse.CourseId%></li>
                                <li><span>课序号</span><% =CurrentCourse.CourseSn %></li>
                                <li style="clear: both; margin-right: 0;"><span>开课系</span><a href="search.aspx?type=1&value=<% =CurrentCourse.Department%>"><% =CurrentCourse.Department%></a></li>
                                <asp:Literal ID="CourseType" runat="server" />
                                <li style="clear: both; margin-right: 0; width: 494px;"><span>课程简介</span>
                                    <p>
                                        <% =CurrentCourse.Introduction%></p>
                                </li>
                            </ul>
                            <div class="section" style="width: 500px; margin: 0;">
                                <ul id="course_nav">
                                    <li>
                                        <asp:LinkButton ID="tab_help" runat="server" Text="求助" OnClick="tab_help_Click" OnClientClick="onTabHelpClick();" /></li>
                                    <!--li>
                                        <asp:LinkButton ID="tab_chat" runat="server" Text="闲谈" OnClick="tab_chat_Click" OnClientClick="onTabChatClick();" /></li-->
                                </ul>
                                <div id="tab_right">
                                    <div id="commend_search">
                                        <asp:TextBox ID="SearchPostTextBox" runat="server" onkeyup="if (window.event.keyCode == 13) $('#search_post').click();" />
                                        <ajax:TextBoxWatermarkExtender ID="SearchPostExtender" runat="server" TargetControlID="SearchPostTextBox"
                                                                       WatermarkText="搜索帖子" WatermarkCssClass="search_post_promp" />
                                        <asp:Button ID="search_post" Text="搜索" runat="server" OnClick="search_post_Click"
                                                    OnClientClick="return $('#SearchPostTextBox').val()!='搜索帖子'&&$('#SearchPostTextBox').val()!=''" />
                                    </div>
                                    <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">我的帖子</asp:LinkButton>
                                </div>
                                <div class="line_bold">
                                    <div id="bold_left">
                                    </div>
                                    <div class="bold_right">
                                    </div>
                                </div>
                                <div id="DiscussArea" style="background-color: White; float:left">
                                    <asp:Repeater ID="Helps" runat="server" OnItemDataBound="HelpsItemBound">
                                        <ItemTemplate>
                                            <div id="help_item<%#Container.ItemIndex%>" class="news_list" style="width: 100%;">
                                                <a href="<%#BLL.Utility.GetRenrenUrl(((Help) Container.DataItem).UserId)%>" target="_blank">
                                                    <img alt="" height="50" src="<%#((Help) Container.DataItem).UserPic%>" width="50" /></a>
                                                <div class="news_content" style="width: 436px;">
                                                    <h3>
                                                        <a href="<%#BLL.Utility.GetRenrenUrl(((Help) Container.DataItem).UserId)%>" target="_blank">
                                                            <%#((Help) Container.DataItem).UserName%></a></h3>
                                                    <span class="time_another">
                                                        <%#BLL.Utility.GetTimeSpan(((Help) Container.DataItem).Time)%>发表/<%#BLL.Utility.GetTimeSpan(((Help) Container.DataItem).UpdateTime)%>更新</span>
                                                    <div class="content_container">
                                                        <div class="quotation_left">
                                                        </div>
                                                        <p class="added_third">
                                                        <%#((Help) Container.DataItem).Content%><p>
                                                                                                <div class="quotation_right"></div>
                                                    </div>
                                                    <div class="comment_num">
                                                        <a href="javascript:toggleHelpReply('<%#Container.ItemIndex%>');"><span>
                                                                                                                         <%#((Help) Container.DataItem).HelpReplys.Count%></span>回复</a></div>
                                                </div>
                                                <div class="news_reply" id="help_reply<%#Container.ItemIndex%>">
                                                    <div class="arrow_up">
                                                    </div>
                                                    <div class="reply_content">
                                                        <asp:Repeater ID="replies" runat="server">
                                                            <ItemTemplate>
                                                                <div id="help_replyitem<%#((HelpReply) Container.DataItem).HelpID%>_<%#Container.ItemIndex%>"
                                                                     style="float: left">
                                                                    <a href="<%#BLL.Utility.GetRenrenUrl(((HelpReply) Container.DataItem).UserId)%>" target="_blank">
                                                                        <img alt="" src="<%#((HelpReply) Container.DataItem).UserPic%>" width="50" height="50" /></a>
                                                                    <div class="news_content" style="width: 422px;">
                                                                        <h3>
                                                                            <a id="helpreply_name<%#((HelpReply) Container.DataItem).HelpID%>_<%#Container.ItemIndex%>"
                                                                               href="<%#BLL.Utility.GetRenrenUrl(((HelpReply) Container.DataItem).UserId)%>" target="_blank">
                                                                                <%#((HelpReply) Container.DataItem).UserName%></a></h3>
                                                                        <span class="time_another">
                                                                            <%#BLL.Utility.GetTimeSpan(((HelpReply) Container.DataItem).Time)%></span>
                                                                        <div class="content_container">
                                                                            <div class="quotation_left">
                                                                            </div>
                                                                            <p class="added_third_reply">
                                                                                <%#((HelpReply) Container.DataItem).Content%></p>
                                                                            <div class="quotation_right">
                                                                            </div>
                                                                        </div>
                                                                        <div class="comment_num">
                                                                            <a href="javascript:showReplyText('#helpreply_frame<%#((RepeaterItem) Container.Parent.Parent).ItemIndex%> textarea', $('#helpreply_name<%#((HelpReply) Container.DataItem).HelpID%>_<%#Container.ItemIndex%>').html());">
                                                                                回复</a></div>
                                                                    </div>
                                                                    <div class="white_line">
                                                                    </div>
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                        <div class="reply_frame" id="helpreply_frame<%#Container.ItemIndex%>">
                                                            <asp:TextBox ID="HelpReplyArea" TextMode="MultiLine" runat="server" />
                                                            <asp:Button ID="HelpReplyButton" OnClick="HelpReplyClick" runat="server" CssClass="reply_button"
                                                                        Text="<%#((Help) Container.DataItem).ID%>" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <SeparatorTemplate>
                                            <div class="line_light">
                                                <div class="light_left">
                                                </div>
                                                <div class="light_right">
                                                </div>
                                            </div>
                                        </SeparatorTemplate>
                                    </asp:Repeater>
                                    <asp:Repeater ID="Chats" runat="server" OnItemDataBound="ChatsItemBound">
                                        <ItemTemplate>
                                            <div id="chat_item<%#Container.ItemIndex%>" class="news_list" style="width: 100%;">
                                                <a href="<%#BLL.Utility.GetRenrenUrl(((Chat) Container.DataItem).UserId)%>" target="_blank">
                                                    <img alt="" height="50" src="<%#((Chat) Container.DataItem).UserPic%>" width="50" /></a>
                                                <div class="news_content" style="width: 436px;">
                                                    <h3>
                                                        <a href="<%#BLL.Utility.GetRenrenUrl(((Chat) Container.DataItem).UserId)%>" target="_blank">
                                                            <%#((Chat) Container.DataItem).UserName%></a></h3>
                                                    <span class="time_another">
                                                        <%#BLL.Utility.GetTimeSpan(((Chat) Container.DataItem).Time)%>发表/<%#BLL.Utility.GetTimeSpan(((Chat) Container.DataItem).UpdateTime)%>更新</span>
                                                    <div class="content_container">
                                                        <div class="quotation_left">
                                                        </div>
                                                        <p class="added_third">
                                                        <%#((Chat) Container.DataItem).Content%><p>
                                                                                                <div class="quotation_right">
                                                                                                </div>
                                                    </div>
                                                    <div class="comment_num">
                                                        <a href="javascript:toggleChatReply('<%#Container.ItemIndex%>');"><span>
                                                                                                                         <%#((Chat) Container.DataItem).ChatReplys.Count%></span>回复</a></div>
                                                </div>
                                                <div class="news_reply" id="chat_reply<%#Container.ItemIndex%>">
                                                    <div class="arrow_up">
                                                    </div>
                                                    <div class="reply_content">
                                                        <asp:Repeater ID="replies" runat="server">
                                                            <ItemTemplate>
                                                                <div id="chat_replyitem<%#((ChatReply) Container.DataItem).ChatID%>_<%#Container.ItemIndex%>"
                                                                     style="float: left">
                                                                    <a href="<%#BLL.Utility.GetRenrenUrl(((ChatReply) Container.DataItem).UserId)%>" target="_blank">
                                                                        <img alt="" src="<%#((ChatReply) Container.DataItem).UserPic%>" width="50" height="50" /></a>
                                                                    <div class="news_content" style="width: 422px;">
                                                                        <h3>
                                                                            <a id="chatreply_name<%#((ChatReply) Container.DataItem).ChatID%>_<%#Container.ItemIndex%>"
                                                                               href="<%#BLL.Utility.GetRenrenUrl(((ChatReply) Container.DataItem).UserId)%>" target="_blank">
                                                                                <%#((ChatReply) Container.DataItem).UserName%></a></h3>
                                                                        <span class="time_another">
                                                                            <%#BLL.Utility.GetTimeSpan(((ChatReply) Container.DataItem).Time)%></span>
                                                                        <div class="content_container">
                                                                            <div class="quotation_left">
                                                                            </div>
                                                                            <p class="added_third_reply">
                                                                                <%#((ChatReply) Container.DataItem).Content%></p>
                                                                            <div class="quotation_right">
                                                                            </div>
                                                                        </div>
                                                                        <div class="comment_num">
                                                                            <a href="javascript:showReplyText('#chatreply_frame<%#((RepeaterItem) Container.Parent.Parent).ItemIndex%> textarea', $('#chatreply_name<%#((ChatReply) Container.DataItem).ChatID%>_<%#Container.ItemIndex%>').html());">
                                                                                回复</a></div>
                                                                    </div>
                                                                    <div class="white_line">
                                                                    </div>
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                        <div class="reply_frame" id="chatreply_frame<%#Container.ItemIndex%>">
                                                            <asp:TextBox ID="ChatReplyArea" TextMode="MultiLine" runat="server" />
                                                            <asp:Button ID="ChatReplyButton" OnClick="ChatReplyClick" runat="server" CssClass="reply_button"
                                                                        Text="<%#((Chat) Container.DataItem).ID%>" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <SeparatorTemplate>
                                            <div class="line_light">
                                                <div class="light_left">
                                                </div>
                                                <div class="light_right">
                                                </div>
                                            </div>
                                        </SeparatorTemplate>
                                    </asp:Repeater>
                                </div>
                                    <div id="page_indicator" style="margin: 12px 0;">
                                        <asp:Button ID="page_down" runat="server" Text="下一页" OnClick="page_down_Click" OnClientClick="$('#DiscussArea').fadeTo(300, 0);discussAnimation=true;" />
                                        <ul id="pages">
                                            <asp:Repeater ID="PageIndicator" OnItemDataBound="PageDataBound" runat="server">
                                                <ItemTemplate>
                                                    <asp:Label ID="item" runat="server" />
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </ul>
                                    </div>
                                <div class="line_mid">
                                    <div class="mid_left">
                                    </div>
                                    <div class="mid_right">
                                    </div>
                                </div>
                                <div id="publish_aera">
                                    <asp:TextBox ID="NewPostArea" runat="server" TextMode="MultiLine" onblur="hidePostArea()" onfocus="showPostArea()" oninput="checkPost()" onpropertychange="checkPost()" />
                                    <ajax:TextBoxWatermarkExtender ID="NewPostAreaWatermark" TargetControlID="NewPostArea" WatermarkCssClass="publish_aera_span"
                                                                   WatermarkText="写新帖子" runat="server" />
                                    <div id="new_post" style="display: none;">
                                        <div id="word_limit">
                                            <div style="display: inline; color: #998675;" id="chars_count">0</div>
                                            /140</div>
                                        <div id="push_news">
                                            <asp:CheckBox ID="SendNews" runat="server" Checked="true" />
                                            <div style="display: inline; margin-left: 4px;">发布到新鲜事</div>
                                        </div>
                                        <asp:Button ID="PublishButton" Text="发布" CssClass="publish_button" runat="server" OnClick="PublishButton_Click"
                                                    OnClientClick="replies=new Array();" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <asp:Panel ID="SameNameCoursePanel" runat="server" CssClass="side">
                            <div class="side_top">
                            </div>
                            <div class="side_mid">
                                <h3>同名课程<span><asp:Literal ID="SameNameCourseNum" runat="server" /></span></h3>
                                <a href="search.aspx?type=11&value=<% = CurrentCourse.CourseName %>" class="more">查看全部</a>
                                <ul>
                                    <asp:Repeater ID="SameNameCourses" runat="server">
                                        <ItemTemplate>
                                            <li>
                                                <a href="course.aspx?id=<%# ((Course) Container.DataItem).ID %>"><%# ((Course) Container.DataItem).CourseName %>
                                                <div class="stress"><p><%# ((Course) Container.DataItem).Teacher.TeacherName %></p></div></a>
                                                <div class="bar_list">
                                                    <div class="plain_text">
                                                        <span class="bar_label">含金量</span> <span class="number"><%# BLL.Utility.Round(((Course)Container.DataItem).CourseInfo.Gold) %></span>
                                                    </div>
                                                    <div class="plain_text">
                                                        <span class="bar_label">轻松度</span> <span class="number"><%# BLL.Utility.Round(((Course) Container.DataItem).CourseInfo.Relax) %></span>
                                                    </div>
                                                    <div class="plain_text">
                                                        <span class="bar_label" style="margin-right: 0;">成绩值</span> <span class="number"><%# BLL.Utility.Round(((Course) Container.DataItem).CourseInfo.Mark) %></span>
                                                    </div>
                                                </div>
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </div>
                            <div class="side_bottom">
                            </div>
                        </asp:Panel>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </form>
        <script type="text/javascript" src="/Scripts/renren.js"></script>
        <script type="text/javascript">
            Renren.init({ appId: 140824 });
        </script>
    </body>
</html>