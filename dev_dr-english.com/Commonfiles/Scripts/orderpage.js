/* 수강신청 스크립트 */
var $order = {
/* 무료 레벨 테스트 */
	levelTest : {
		init : function() {
			// 수업시간/날짜 Add Event OnChage 
			if($(".csstest").length > 0) {
				$(".csstest").eq(0).bind("change", function() {
					$order.levelTest.setTestTime.call($(this), $(".csstest").eq(1));
				});
			}
			// 신청하기 및 결과보기
			if($(".cssBtns").length > 0) {
				$(".cssBtns").bind("click", function() {
					$order.levelTest.actions[$(this).attr("caption")].call(this, $(".csstest"));
				});
			}

			// 전화번호 숫자만 입력
			if($(".cssnumber").length > 0) { 
				$(".cssnumber").each(function() { 
					$(this).numeric(); 
					$(this).css("ime-mode", "disabled"); 
					// 크롬에서의 한글 써지는 문제 추가 적용
					$common.keyPermit.call($(this), "NUM");
				}); 
			}
		},
		setTestTime : function() {
			$(arguments[0]).find("option").remove().end().append("<option value=''>선택</option>");

			// 기수방식인 학생의 경우 기수 코드 설정
			$("INPUT[name='UserBalanceSeq']").val( $(":selected", $(this)).attr("seq") );

			if($(this).val().trim() != "") {
				var sObj = $(":selected", $(this));
				var html = "";
				for(var i = parseInt($(sObj).attr("sHour")); i<= parseInt($(sObj).attr("eHour")); i++) {
					html += "<option value='"+ i +"'>"+ i +"</option>";
				}

				$(arguments[0]).append(html);
			}
		},
		actions : {
			APPLY	: function() {
				var bValidate = true;
				$(arguments[0]).each(function() {
					if($(this).val().trim() == "") {
						alert($(this).attr("caption") +"(을)를 선택해 주세요.");
						$(this).focus();
						bValidate = false;
						return false;
					}
				});

				if(bValidate) {
					if($(arguments[0]).eq(0).val().trim() == $("INPUT[name='today']").val().trim()) {
						if(parseInt($(arguments[0]).eq(1).val().trim()) >= parseInt($("INPUT[name='todayhour']").val().trim())) {
							if(parseInt($(arguments[0]).eq(1).val().trim()) == parseInt($("INPUT[name='todayhour']").val().trim())) {
								if(parseInt($(arguments[0]).eq(2).val().trim()) < parseInt($("INPUT[name='todaymin']").val().trim())) {
									alert("금일신청은 현재시간 2시간 이후 등록이 가능합니다..");
									$(arguments[0]).eq(1).focus();
									return false;
								}
							}
						} else {
							alert("금일신청은 현재시간 2시간 이후 등록이 가능합니다..");
							$(arguments[0]).eq(1).focus();
							return false;
						}
					}

					if(!$("INPUT[name='PhoneChoice']").is(":checked")) {
						alert("레벨테스트 전화 타입을 선택하세요 ~!!");
						return false;
					}	

					if($("INPUT[name='PhoneChoice']:checked").val().trim() == "P") {
						if($("SELECT[name='L_UserPhone1_1']").val().trim() == "") {
							alert("지역번호를 선택해 주세요.");
							$("SELECT[name='L_UserPhone1_1']").focus();
							return;
						}
						if($("INPUT[name='L_UserPhone1_2']").val().trim() == "") {
							alert("전화번호를 입력해 주세요.");
							$("INPUT[name='L_UserPhone1_2']").focus();
							return;
						}
						if($("INPUT[name='L_UserPhone1_3']").val().trim() == "") {
							alert("전화번호를 입력해 주세요.");
							$("INPUT[name='L_UserPhone1_3']").focus();
							return;
						}
					}
					if($("INPUT[name='PhoneChoice']:checked").val().trim() == "C") {
						if($("SELECT[name='L_UserPhone2_1']").val().trim() == "") {
							alert("통신사를 선택해 주세요.");
							$("SELECT[name='L_UserPhone2_1']").focus();
							return;
						}
						if($("INPUT[name='L_UserPhone2_2']").val().trim() == "") {
							alert("전화번호를 입력해 주세요.");
							$("INPUT[name='L_UserPhone2_2']").focus();
							return;
						}
						if($("INPUT[name='L_UserPhone2_3']").val().trim() == "") {
							alert("전화번호를 입력해 주세요.");
							$("INPUT[name='L_UserPhone2_3']").focus();
							return;
						}
					}

					if(!$("INPUT[name='StudentLeveL']").is(":checked")) {
						alert("회원님께서 생각하는 영어실력을 선택하세요 ~!!");
						return false;
					}

					$("FORM[name='Uform']").submit();
				}
			},
			VIEW	: function() {
				var ele = {
					url		: "LevelTestView.asp",
					name	: "LevelTest",
					status	: "width=690 ,height=650 , top=0 ,left=0 ,scrollbars=YES ,status=NO"
				};
				$common.popup.call(this, ele);
			}
		}
	},
/* 수강 신청 내역 */
	signup : {
		init : function() {
			// 수강 신청 내역 view
			if($(".cssorder").length > 0) {
				$(".cssorder").bind("click", function() {
					$order.signup.actions.VIEW.call(this);
					return;
				});
			}

			// 결제 취소 버튼
			if($(".csscancel").length > 0) {
				$(".csscancel").bind("click", function() {
					$order.signup.actions.CANCEL.call(this);
				});
				return;
			}
		},
		actions : {
			VIEW : function() {
				$("INPUT[name='order_seq']").val( $(this).data("seq") );
				$("FORM[name='Bform']").attr("action", "myLectureView.asp").submit();
			},
			CANCEL : function() {
				if($("INPUT[name='order_seq']").val().trim() == "") {
					alert("주문 정보가 없습니다.\n다시 이용해 주세요.");
					return;
				}

				if(confirm("정말 취소하시겠습니까?")) {
					$("FORM[name='Bform']").submit();
				} else {
					return;
				}
			}
		}
	}
}