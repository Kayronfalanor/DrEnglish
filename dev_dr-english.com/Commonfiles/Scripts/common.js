function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
   var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}


/* String */
String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g,'');
}

/* 메인 */
var $main = {
	init : function() {		
		/* Quick Menu Image Toggle */
		if($("IMG[name='quickBtns']").length > 0) {
			$main.actions.toggleImg.call($("IMG[name='quickBtns']"));
		};

		/* Login Input set Background Image */
		if($(".b_normal").length > 0) {			
			$main.actions.setInit.call($(".b_normal"));
		}

		/* Login Check */
		if($("IMG[id='btnLogin']").length > 0) {
			$("IMG[id='btnLogin']").bind("click", function() {
				$main.actions.login.call($(".b_normal"));
			});
		}

		/* dial menu */
		if($(".cssroll").length > 0) {
			$(".cssroll").each(function() { $common.toggleImg.call(this); });
		}

		/* popup */
		if($(".csspopup > li").length > 0) {
			
			$(".csspopup > li").each(function() {
				if($.cookie($(this).data("name")) != "no") {
					$main.actions.Popup.call(this);
				}
			});
		}
	},
	actions : {
		// 로그인 체크
		login : function() {
			var bLoginChk = true;
			$(this).each(function() {
				if($(this).val().trim() == "") {
					alert($(this).attr("caption") + "를 입력해 주세요.");
					$(this).focus();
					bLoginChk = false;
					return false;
				}
			});

			if(bLoginChk) {
				$("FORM[name='Lform']").submit();
			}
		},
		// 로그인 Input Box 이미지 설정
		setInit : function() {
			$(this).each(function() {
				$(this).addClass( $(this).attr("id") );

				$(this).bind("blur", function() {
					if($(this).val().trim() == "") {
						$(this).removeClass("b_active");
						$(this).addClass( $(this).attr("id") );
					}
				});

				$(this).bind("focus", function() {
					$(this).addClass("b_active");
					$(this).removeClass( $(this).attr("id") );
				});
				return;
			});
		},
		/*  팝업 */
		Popup : function() {
			console.log('Popup start');
			if($(this).data("type") == "1") {				
				$("INPUT[name='pop_img']").val( $(this).text() );
				$("INPUT[name='pop_name']").val( $(this).data("name") );
				var attr = "toolbar=no,location=no, directories=no,status=no,menubar=no,scrollbars=no,resizable=no";
				var ele = {
					form    :	$("FORM[name='popupform']"),
					name	:	$(this).data("name"),
					status	:	attr+",width="+ $(this).data("width") +", height="+ $(this).data("height") +", left="+ $(this).data("left") +", top="+ $(this).data("top")
				}

				
				$common.popup3.call(this, ele);
			} else {
				// 레이어 팝업
				var html;
				html = "<div name='divPopup' id='divPopup' style='overflow:auto;background-color:#fff;border:1px solid red;position:absolute;width:"+ $(this).data("width") +"px;height:"+ $(this).data("height") +"px;left:"+ $(this).data("left") +"px;top:"+ $(this).data("top") +"px;z-index:999;'>";
				html += "<ul style='margin:0;padding:0;'>";
				html += "<li><img src='"+ $(this).data("path") +"UT001/"+ $(this).text() +"' border='0' /><li>";
				html += "<li style='text-align:right;height:20px;'><input type='checkbox' name='popupchk' value='"+ $(this).data("name") +"' /> 오늘 하루 열지 않기</li>";
				html += "</ul>";
				html += "</div>";

				$("body").prepend(html);
				
				if($("DIV[name='divPopup']").length > 0) {
					var divObj;
					
					$("DIV[name='divPopup']").each(function() {
						divObj = $(this);
						//$(this).draggable({revert : false, cursor : "move", stack : ".draggable", opacity : 0.7});
					});
					

					$("INPUT[name='popupchk']").bind("click", function() {
						console.log('cookie write');
						//setCookie($(this).val(), "no", 1);
						$.cookie($(this).val(), "no", {path : "/", expires : 1});
						//$(divObj).fadeOut("slow");
						$(divObj).hide();
					});
				}					
			}
		}
	}
}

var $common = {
	/* F5 새로고침시 main 프레임 리로드 */
	refresh : {
		init : function() {
			$(this).bind("keydown", function(e) {
				if(e.keyCode == 116) {
					e.keyCode = 505;
					//parent.$("FRAME[name='main']")[0].contentWindow.location.reload(true);
					//location.replace(arguments[0]);
					return false;
				}
			});
		}
	},
	regExps : {
		KOR		: /[a-z0-9]/gi,
		ENG		: /[^a-z]/gi,
		NUM		: /[^0-9]/gi,
		ENUM	: /[^a-z0-9]/gi,
		EMAIL	: /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/
	},
	/* element 입력 값 제한 */
	keyPermit : function() {

		var attr = {
			KOR : /[a-z0-9]/gi,
			ENG : /[^a-z]/gi,
			NUM : /[^0-9]/gi,
			ENUM: /[^a-z0-9]/gi
		};
			
		var regEx = $common.regExps[arguments[0]];

		$(this).bind("blur keypress", function(e) {
			if(!(e.keyCode >= 37 && e.keyCode <= 40)) {
				$(this).val( $(this).val().trim().replace(regEx,''));
			}
		});
	},
	chkEmail : function() {
		var emailValue = $(arguments[0].email1).val().trim() + "@" + $(arguments[0].email2).val().trim();
		if(!$common.regExps.EMAIL.test(emailValue)) {
			return false;
		}
		return true;
	},
	popup : function() {
		window.open(arguments[0].url, arguments[0].name, arguments[0].status);
	},
	popup2 : function(url, name, status) {
		window.open(url, name, status);
	},
	popup3 : function() {
		var win = window.open('', arguments[0].name, arguments[0].status);
		$(arguments[0].form).attr("target", arguments[0].name).submit();
	},
	goPage : function() {
		if($(document.forms[0]).length > 0) {
			$("INPUT[name='currPage']").val( arguments[0] );

			$(document.forms[0]).submit();
		}
	},
	// 퀵 메뉴 이미지 마우스 Toggle 
	toggleImg : function() {
		$(this).bind("mouseover", function() {
			$(this).attr("src", $(this).attr("src").replace("off", "on"));
			return;
		});
		$(this).bind("mouseleave", function() {
			$(this).attr("src", $(this).attr("src").replace("on", "off"));
			return;
		});
	}
}