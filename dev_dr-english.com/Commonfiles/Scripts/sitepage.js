/* 고객 지원 */
var $site = {
// ##### // Notice, News #####
	board : {
		init : function() {
			// board 글보기
			if($(".csshref").length > 0) {
				$(".csshref").bind("click", function() {
					$site.board.actions.VIEW.call(this);					
				});
			}

			// List
			if($("#btnList").length > 0) {
				$("#btnList").bind("click", function() {
					$site.board.actions[$(this).attr("caption")].call(this);
				});
			}
		},
		actions : {
			VIEW : function() {
				if($("FORM[name='Bform']").length > 0) {
					$("INPUT[name='seq']").val( $(this).data("seq") );
					$("FORM[name='Bform']").attr("action", "View.asp").submit();
					$("FORM[name='Bform']").attr("action", "List.asp");
				}
			},
			LIST : function() {
				if($("FORM[name='Bform']").length > 0) {					
					$("FORM[name='Bform']").attr("action", "List.asp").submit();
				}
			}
		}
	},
// ##### Notice, News // #####

	// ##### // Event #####
	Event : {
		init : function() {
			// board 글보기
			if($(".csshref").length > 0) {
				$(".csshref").bind("click", function() {
					$site.Event.actions.VIEW.call(this);					
				});
			}

			// List
			if($("#btnList").length > 0) {
				$("#btnList").bind("click", function() {
					$site.Event.actions[$(this).attr("caption")].call(this);
				});
			}
		},
		actions : {
			VIEW : function() {
				if($("FORM[name='Bform']").length > 0) {
					$("INPUT[name='seq']").val( $(this).data("seq") );
					$("FORM[name='Bform']").attr("action", "SpecialEventView.asp").submit();
					$("FORM[name='Bform']").attr("action", "SpecialEvent.asp");
				}
			},
			LIST : function() {
				if($("FORM[name='Bform']").length > 0) {					
					$("FORM[name='Bform']").attr("action", "SpecialEvent.asp").submit();
				}
			}
		}
	},
// ##### Event // #####

// ##### // FAQ #####
	faq : {
		init : function() {
			// FAQ 카테고리 이벤트 
			if($(".cssftype").length > 0) {
				$(".cssftype").bind("click", function() {
					$site.faq.actions.toggleMenu.call($(this), $(".cssftype"), $(".cssftbl"));
					return;
				});

				$site.faq.actions.toggleFAQ.call($(".cssF01"));
			}
		},
		actions : {
			// FAQ 카테고리별 메뉴
			toggleMenu : function() {
				var obj = $(this);

				$(arguments[0]).each(function() {
					$(this).attr("src", $(this).attr("src").replace("on", ""));
				});

				var img = $(this).attr("src");
				img = img.split(".");
				$(this).attr("src", img[0] + "on." + img[1]);

				$(arguments[1]).each(function() {
					$(this).hide();
				});

				$("TABLE[id='tbl"+ $(this).data("ftype") +"']").show();

				$(".cssftr").each(function() {
					$(this).hide();
				});

				$site.faq.actions.toggleFAQ.call($(".css"+ $(this).data("ftype")));
			},
			// FAQ 내용 보기
			toggleFAQ : function() {
				var obj;
				$(this).toggle(
					function(e) {
						
						if($("TR[id='tr"+ $(obj).data("seq") +"']").length > 0) {
							if($(obj).data("seq") != $(this).data("seq")) {
								$("TR[id='tr"+ $(obj).data("seq") +"']").hide();
								$(obj).removeClass("on");
								$(obj).addClass("off");
							}
						}

						//$(".cssftr").each(function() { $(this).hide(); return; });
						$("TR[id='tr"+ $(this).data("seq") +"']").show();
						$(this).removeClass("off");
						$(this).addClass("on");

						obj = $(this);
					},
					function() {
						$("TR[id='tr"+ $(this).data("seq") +"']").hide();
						$(this).removeClass("on");
						$(this).addClass("off");
					}
				);
			}
		}
	},
// ##### FAQ // #####

// ##### // Q&A #####
	qna : {
		init : function() {
			// Q&A 글쓰기 페이지로 이동
			if($("#btnWrite").length > 0) {
				$("#btnWrite").bind("click", function() {
					$site.qna.actions.WRITE.call(this);
				});		

			}
		
			// Q&A 글쓰기
			if($("#btnRegist").length > 0) {
				$("#btnRegist").bind("click", function() {
					$site.qna.actions[$(this).attr("caption")].call($(".cssinput"));
				});
			}
			// Q&A 글보기
			if($(".csshref").length > 0) {
				$(".csshref").bind("click", function() {
					$site.qna.actions.VIEW.call(this);					
				});
			}
			//Q&A코멘트 등록, 수정, 삭제
			if($(".cssBtns").length > 0) {
				$(".cssBtns").bind("click", function() {
					$site.qna.actions[$(this).attr("caption")].call(this, $(".cssinput"));
				});
			}

							
		},
		actions : {
			WRITE : function() {
				if($("FORM[name='formdboard']").length > 0) {
					$("FORM[name='formdboard']").attr("action", "Write.asp").submit();
					$("FORM[name='formdboard']").attr("action", "List.asp")
				} else { return; }
			},
			
			REGIST: function() {
				if($(this).length > 0) {
					var bCheck = true;
					$(this).each(function() {
						if($(this).val().trim() == "") {
							alert($(this).attr("caption") +"을 입력해 주세요.\n");
							$(this).focus();
							bCheck = false;
							return false;
						}
					});

					if(bCheck) {
						if($("FORM[name='formdboard']").length > 0) {
							$("FORM[name='formdboard']").submit();
						} else { $site.qna.actions.Exception.call(this); }
					}

				} else { $site.qna.actions.Exception.call(this); }
			},
			VIEW : function() {				
				if($("INPUT[id='seq']").length > 0 || $("FORM[name='formdboard']").length > 0) {
					$("INPUT[id='seq']").val( $(this).data("seq") );
	
					$("FORM[name='formdboard']").attr("action", "View.asp").submit();
					$("FORM[name='formdboard']").attr("action", "List.asp");
				} else {
					$site.qna.actions.Exception.call(this);
				}
			},
			/* 코멘트 */
			COMMREG : function() {
				if($("TEXTAREA[id='comment']").val().trim() == "") {
					alert("내용을 입력해 주세요.");
					$("TEXTAREA[id='comment']").focus();
					return;
				}

				$("FORM[name='commFrm']").attr("action", "commentOK.asp").submit();
			},
			COMMMOD : function() {
				$("INPUT[id='cseq']").val( $(this).data("cseq") );
				$("TEXTAREA[id='comment']").val( $(this).data("comment") );

				$("IMG[id='btnComment']").attr("src", $("IMG[id='btnComment']").attr("src").replace("record", "modif"));
			},
			COMMDEL : function() {
				$("INPUT[id='cseq']").val( $(this).data("cseq") );
				if(confirm("정말 삭제하시겠습니까?")) {
					$("FORM[name='commFrm']").attr("action", "commentDelOK.asp").submit();
				} else {
					return;
				}
			},
			Exception : function() {
				alert("진행에 문제가 있습니다.\n관리자에게 문의해 주세요.!");
				return;
			}
		}
	}
// ##### Q&A // #####
}