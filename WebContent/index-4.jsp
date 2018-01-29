<%@page import="java.net.InetAddress"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="http://releases.flowplayer.org/js/flowplayer-3.2.13.min.js"></script>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page session="true"%>

</head>
<body class="index-1">
	<!--==============================header=================================-->
	<%@ include file="header.jsp"%>

	<!--=======content================================-->
	<section id="content">
	<div class="full-width-container block-1">
		<div class="container">
			<div class="row" style="margin: 0px 0px 0px 0px;">
				<div class="grid_12">
					<header>
					<h2>
						<span id="stream_title">Show Stream</span>
					</h2>
					</header>
				</div>

				<div style="position: relative; display: block; height: 0; padding: 0; overflow: hidden; padding-bottom: 56.25%; border: 1px solid red">
				<a id="player" style="position: absolute; top: 0; left: 0; bottom: 0; height: 100%; width: 100%; border: 0;"></a>
				<script type="text/javascript">
					flashembed(
							"player",
							"http://releases.flowplayer.org/swf/flowplayer-3.2.18.swf",
							{
								config : {
									clip : <% out.print("'"+ request.getParameter("url") +"'"); %>,
									plugins : {
									}
								}
							});
				</script>
				</div>
				<div id="chat_container">
	
    <!-- 로그인한 상태일 경우와 비로그인 상태일 경우의 chat_id설정 -->
	<c:set var="login" value='<%= session.getAttribute("signedUser") %>' />	
    <c:if test="${(login ne '') and !(empty login)}">
        <input type="hidden" value='${login }' id='chat_id' />
    </c:if>
    <c:if test="${(login eq '') or (empty login)}">
        <input type="hidden" value='<%= session.getId().substring(0, 6) %>'
            id='chat_id' />
    </c:if>
    
    <!--     채팅창 -->
    <div id="_chatbox" style="display: none;">
        <fieldset>
            <div id="messageWindow" style="border:1px solid gray; height:200px; overflow-x:hidden; overflow-y:auto;"></div>
            <br /> <input id="inputMessage" type="text" onkeyup="enterkey()" />
            <input type="submit" value="send" onclick="send()" />
        </fieldset>
    </div>
    <img class="chat" src="./images/JKTALK.png" alt="없음"/>
	<span id="chat_describe">채팅창을 보려면 이미지 버튼을 클릭하세요.</span>
<!-- 채팅창 포커스 관련 -->
<script>
	$("#messageWindow").click(function(){
   		$("#inputMessage").focus();
	});
	$("#messageWindow").hover(function(){		
	    $("#messageWindow").bind('mousewheel', function(e){
            if (e.originalEvent.wheelDelta /120 > 0) 
            {
                var elem = document.getElementById('messageWindow');
                elem.scrollTop -= 5;
                
                e.preventDefault();
                e.stopPropagation();
             }
            else
            {
                var elem = document.getElementById('messageWindow');
                elem.scrollTop += 5;
                
                e.preventDefault();
                e.stopPropagation();
            }

	    });
	});
</script>

<!-- 말풍선아이콘 클릭시 채팅창 열고 닫기 -->
<script>
    $(".chat").on({
        "click" : function() {
            if ($(this).attr("src") == "./images/JKTALK.png") {
                $(".chat").attr("src", "./images/JKTALKX.png");
                $("#_chatbox").css("display", "block");
                $("#chat_describe").html("채팅창을 닫으려면 이미지 버튼을 클릭하세요.<br>/ID OOO 를 이용해 귓속말을 할 수 있습니다.");
            } 
            else if ($(this).attr("src") == "./images/JKTALKX.png") {
                $(".chat").attr("src", "./images/JKTALK.png");
                $("#_chatbox").css("display", "none");
                $("#chat_describe").html("채팅창을 보려면 이미지 버튼을 클릭하세요.");
            }
        }
    });
</script>

<script type="text/javascript">
    var textarea = document.getElementById("messageWindow");
    var webSocket = new WebSocket('ws://223.194.153.111:80/StreamingService/broadcasting');
    var inputMessage = document.getElementById('inputMessage');
    webSocket.onerror = function(event) {
        onError(event)
    };
    webSocket.onopen = function(event) {
        onOpen(event)
        
        var elem = document.getElementById('messageWindow');
        elem.scrollTop = elem.scrollHeight;
    };
    webSocket.onmessage = function(event) {
        onMessage(event)
        
        var elem = document.getElementById('messageWindow');
        elem.scrollTop = elem.scrollHeight;
    };
    function onMessage(event) {
        var message = event.data.split("|");
        var sender = message[0];
        var content = message[1];
        if (content == "") {
            
        } else {
            if (content.match("/")) {
                if (content.match(("/" + $("#chat_id").val()))) {
                    var temp = content.replace("/" + $("#chat_id").val(), "(귓속말) :").split(":");
                    if (temp[1].trim() == "") {
                    } else {
                        $("#messageWindow").html($("#messageWindow").html() + "<p class='whisper' style='color:blue;'>"
                            + sender + content.replace("/" + $("#chat_id").val(), "(귓속말) :") + "</p>");
                    }
                } else {
                }
            } else {
                if (content.match("!")) {
                    $("#messageWindow").html($("#messageWindow").html()
                        + "<p class='chat_content'><b class='impress'>" + sender + " : " + content + "</b></p>");
                } else {
                    $("#messageWindow").html($("#messageWindow").html()
                        + "<p class='chat_content'>" + sender + " : " + content + "</p>");
                }
            }
        }	        
    }
    function onOpen(event) {
        $("#messageWindow").html("<p class='chat_content'>채팅에 참여하였습니다.</p>");
    }
    function onError(event) {
        alert(event.data);
    }
    function send() {
        if (inputMessage.value == "") {
        } 
        else {
            $("#messageWindow").html($("#messageWindow").html()
                + "<p class='chat_content'>나 : " + inputMessage.value + "</p>");
        }
        webSocket.send($("#chat_id").val() + "|" + inputMessage.value);
        inputMessage.value = "";
        
		//채팅이 많아져 스크롤바가 넘어가더라도 자동적으로 스크롤바가 내려가게함
        var elem = document.getElementById('messageWindow');
        elem.scrollTop = elem.scrollHeight;
    }
    //엔터키를 통해 send함
    function enterkey() {
        if (window.event.keyCode == 13) {
            send();
        }
    }
</script>
				</div>
			</div>
		</div>
	</div>
	</section>

	<!--=======footer=================================-->
	<%@ include file="footer.jsp"%>
</body>
</html>