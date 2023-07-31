<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="jobworld.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>한국잡월드 신문사직업체험프로그램</title>
    <script type="text/javascript">
        var timer = 0;
        var totalvalues = "";

        var currentId = -1;
        var totalId = 0;
        var firstid = 0;
        $(document).ready(function () {
            $.ajax({
                url: 'getContent.aspx?type=2',
                type: "post",
                processData: false,
                contentType: false,
                async: false,
                success: function (data, textStatus, jqXHR) {
                    firstid = data;
                },
                error: function (jqXHR, textStatus, errorThrown) {
                }
            });

            loadlink();
            SetAction();
//            document.getElementById("li0").setAttribute("class", "on");
        });

        function loadlink() {
            $.ajax({
                url: 'getContent.aspx?type=1',
                type: "post",
                processData: false,
                contentType: false,
                async: false,
                success: function (data, textStatus, jqXHR) {
                    totalvalues = data;
                },
                error: function (jqXHR, textStatus, errorThrown) {
                }
            });
        }

        setInterval(function () {
            $.ajax({
                url: 'getContent.aspx?type=2',
                type: "post",
                processData: false,
                contentType: false,
                async: false,
                success: function (data, textStatus, jqXHR) {
                    if (firstid != data) {
                        location.reload();
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                }
            });
            loadlink();
        }, 3000);

        function SetAction() {
            var values = totalvalues.split(',');
            totalId = values.length - 1;

            if (currentId == totalId - 1) {
                currenId = 0;
                location.reload();
            }
            else {
                if (currentId >= 0 && currentId > 5) {
                    $('.btn_btm').click();
                }
                currentId++;
            }

            for (var i = 0; i < totalId; i++) {
                document.getElementById("li" + i).setAttribute("class", "");
            }
            document.getElementById("li" + currentId).setAttribute("class", "on");
            onShowContent(values[currentId]);


//            var rand = Math.floor(Math.random() * (values.length - 1));
        }
/*
        function setDelay()
        {
            if (timer == 1)
            {
                SetAction();
                timer = 0;
            }
        }

        setDelay();

        setInterval(function () {
            setDelay();
        }, 30000);
*/
        setInterval(function () {
//            if (timer == 0)
            {
                SetAction();
            }
        }, 180000);
        
        function onShowContentClick(cid, id)
        {
            currentId = cid;
            onShowContent(id);
            timer = 1;
        }

        function onShowContent(id)
        {
            $.ajax({
                url: 'getContent.aspx?type=0&id=' + id,
                type: "post",
                processData: false,
                contentType: false,
                async: false,
                success: function (data, textStatus, jqXHR) {
                    document.getElementById("showContent").src = data;
                },
                error: function (jqXHR, textStatus, errorThrown) {
                }
            });
        }

        function onClosePopup() {
            document.getElementById("article_showDetail").style.display = "none";
            document.getElementById("popupForm").style.display = "none";
        }

        function showLayoutTop(id1, id2) {
            if (document.getElementById("layout" + id1 + "_top" + id2).style.backgroundImage == "url(\"\")") {
                document.getElementById("popupForm").style.display = "";
                document.getElementById("article_showDetail").style.display = "";
                document.getElementById("articleDetailTitle").innerText = document.getElementById("layout" + id1 + "_top" + id2 + "_title").innerText;
                document.getElementById("articleDetailImage").src = document.getElementById("layout" + id1 + "_top" + id2 + "_image").src;
                if (id1 >= 6) {
                    document.getElementById("articleDetailText").innerText = document.getElementById("layout" + id1 + "_top" + id2 + "_summary").value.split('<br>').join('\n');
                    //                document.getElementById("articleDetailSummary").innerText = document.getElementById("layout" + id1 + "_top" + id2 + "_content").innerHTML.split('<br>').join('\n');
                }
                else {
                    document.getElementById("articleDetailText").innerText = document.getElementById("layout" + id1 + "_top" + id2 + "_content").innerText.split('<br>').join('\n');;
                    //                document.getElementById("articleDetailSummary").innerText = document.getElementById("layout" + id1 + "_top" + id2 + "_summary").value.split('<br>').join('\n');;
                }
            }
        }
    </script>
    <style type="text/css">
        .key_lft {background-color:#fff;}
        .key_lft_view {margin-top:59px;height:1445px;overflow:hidden;position:relative;}
        .key_lft_view ul{position:absolute;left:0;top:0;}
    </style>
    <style type="text/css">
        .wrap_key .key_rgt{background:initial;}
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrap_key">
        <div class="key_header">
	        <div class="header_txt">
                <strong>신문사</strong><p><img src="images/top_logo.png" alt="" /></p>
            </div>
        </div>

        <div class="wrap_con">
            <div class="key_lft">
	            <div class="key_lft_view">
		            <ul>
                        <asp:Literal ID="showcontentList" runat="server"></asp:Literal>
		            </ul>
	            </div>
		        <div class="btn_top"><button type="button"><img src="images/top_btn.png" alt="" /></button></div>
		        <div class="btn_btm"><button type="button"><img src="images/bot_btn.png" alt="" /></button></div>
            </div>
            <div class="key_con">
		        <div class="con_inner">
                    <iframe class="arg" id="showContent" style="width:828px;height:1415px;"></iframe>
                </div>
	        </div>
        </div>
        <div class="key_bottom">
	        <div class="bottom_txt"><img src="images/footer_txt.png" alt="" /></div>
        </div>
    </div>
</asp:Content>
