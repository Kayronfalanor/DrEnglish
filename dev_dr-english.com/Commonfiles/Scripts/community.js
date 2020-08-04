var $community = {
/* 수업 후기 */
	classafter : {
		init : function() {
			// 글쓰기 버튼 액션 설정
			if($("#btnWrite").length > 0) {
				$("#btnWrite").bind("click", function() {
					$community.classafter.actions[$(this).attr("caption")].call(this);
				});
			}

			// 글보기 액션
			if($(".csshref").length > 0) {
				$(".csshref").bind("click", function() {
					$community.classafter.actions.VIEW.call(this);
				});
			}

			/* 글 삭제, 수정, 코멘트 등록, 수정, 삭제 */
			
			//코멘트 수정
			if($(".cssBtns").length > 0) {
				$(".cssBtns").bind("click", function() {
					$community.classafter.actions[$(this).attr("caption")].call(this, $(".cssinput"));
				});
			}
		},
		actions : {
			// 리스트
			LIST : function() {
				$("FORM[name='Bform']").attr("action", "List.asp").submit();
			},
			// 쓰기
			WRITE : function() {
				$("FORM[name='Bform']").attr("action", "Write.asp").submit();
				$("FORM[name='Bform']").attr("action", "List.asp");
			},
			WRITEOK : function() {
				var bValidate = true;
				$(arguments[0]).each(function() {
					if($(this).val().trim() == "") {
						alert($(this).attr("caption") +"(을)를 입력해 주세요.");
						$(this).focus();
						bValidate = false;
						return false;
					}
				});

				if(bValidate) {
					$("FORM[name='formdboard']").attr("action", "WriteOK.asp").submit();
				}
			},
			// 글 보기
			VIEW : function() {
				$("INPUT[name='seq']").val( $(this).data("seq") );
				$("FORM[name='Bform']").attr("action", "View.asp").submit();
				$("FORM[name='Bform']").attr("action", "List.asp");
			},
			MOD : function() {
				if(confirm("해당 글 내용을 수정하시겠습니까?")) {
					$("FORM[name='Bform']").attr("action", "Update.asp").submit();
				} else {
					return;
				}
			},
			UPDATEOK : function() {
				var bValidate = true;
				$(arguments[0]).each(function() {
					if($(this).val().trim() == "") {
						alert($(this).attr("caption") +"(을)를 입력해 주세요.");
						$(this).focus();
						bValidate = false;
						return false;
					}
				});

				if(bValidate) {
					$("FORM[name='formdboard']").attr("action", "UpdateOK.asp").submit();
				}
			},
			DELETE : function() {
				if(confirm("정말 삭제하시겠습니까?")) {
					if($("INPUT[id='strcomment']").val().trim() == "Y") {
						alert("등록된 댓글이 있어 삭제가 불가능합니다.");
						return;
					} else {
						$("FORM[name='Bform']").attr("action", "Del.asp").submit();	
					}					
				} else {
					return;
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
			}
		}
	},

/* 영어 끝말 잇기 */
	word : {
		init : function() {
			// 등록
			if($("#btnRegist").length > 0) {
				$("#btnRegist").bind("click", function() {
					$community.word.actions.REGIST.call($(".cssinput"));
				});
			}
			// 삭제
			if($(".cssdel").length > 0) {
				$(".cssdel").bind("click", function() {
					$community.word.actions.DELETE.call($(this));
				});
			}
		},
		actions : {
			REGIST	: function() {
				var bValidate = true;
				$(this).each(function() {
					if($(this).val().trim() == "") {
						alert($(this).attr("caption") + "(을)를 입력하세요.");
						$(this).focus();
						bValidate = false;
						return false;
					}
				});
				if(bValidate) {
					if($(this).eq(0).val().search(/\s/) != -1) {
						alert("영어단어를 뛰어쓰기없이 입력하세요.");
						$(this).eq(0).focus();
						return;
					}

					$("FORM[name='Bform']").attr("action", "WriteOK.asp").submit();
					$("FORM[name='Bform']").attr("action", "List.asp");
				}
			},				
			DELETE	: function() {
				$("INPUT[name='seq']").val( $(this).data("seq") );

				if(confirm("정말 삭제하시겠습니까?")) {
					$("FORM[name='Bform']").attr("action", "Del.asp").submit();
					$("FORM[name='Bform']").attr("action", "List.asp")
				} else {
					return;
				}
			}
		}
	},

/* 영어 수다 떨기 */
	talk : {
		init : function() {
			// 등록
			if($("#btnRegist").length > 0) {
				$("#btnRegist").bind("click", function() {
					$community.talk.actions.REGIST.call($(".cssinput"));
				});
			}
			// 삭제
			if($(".cssdel").length > 0) {
				$(".cssdel").bind("click", function() {
					$community.talk.actions.DELETE.call($(this));
				});
			}
		},
		actions : {
			REGIST	: function() {
				var bValidate = true;
				$(this).each(function() {
					if($(this).val().trim() == "") {
						alert($(this).attr("caption") + "을 입력하세요.");
						$(this).focus();
						bValidate = false;
						return false;
					}
				});
				if(bValidate) {
					$("FORM[name='Bform']").attr("action", "WriteOK.asp").submit();
					$("FORM[name='Bform']").attr("action", "List.asp");
				}
			},				
			DELETE	: function() {
				$("INPUT[name='seq']").val( $(this).data("seq") );

				if(confirm("정말 삭제하시겠습니까?")) {
					$("FORM[name='Bform']").attr("action", "Del.asp").submit();
					$("FORM[name='Bform']").attr("action", "List.asp")
				} else {
					return;
				}
			}
		}
	}
}