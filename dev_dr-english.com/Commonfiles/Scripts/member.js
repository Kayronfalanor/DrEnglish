/* 서대문 회원정보 */
var $member = {
	init : function() {
		/* 로그인 */
		/*
		if($("IMG[id='loginBtn']").length > 0) {
			$("IMG[id='loginBtn']").bind("click", function() {
				$member.login.call($(".txt_box"));
			});
		}
		*/

		if($("#loginBtn").length > 0) {
			$("#loginBtn").bind("click", function() {			
				$member.login.call($(".txt_box"));
			});
		}
		
		$(".txt_box").each(function() {
			$(this).bind("keypress", function(e) {
				if(e.keyCode == 13) {
					$member.login.call($(".txt_box"));
					return false;
				}
			});
		});

		/* 회원 가입 실명확인 및 약관 동의 */
		/*if($("IMG[id='confirmBtn']").length > 0) {
			$("IMG[id='confirmBtn']").bind("click", function() {
				$member.regist.agree.call(this, { agree : $(".box"), user : $(".cssbirthday")});			
			});			
		}
		*/
		if($("#confirmBtn").length > 0) {
			$("#confirmBtn").bind("click", function() {
				$member.regist.agree.call(this, { agree : $(".box"), user : $(".cssbirthday")});			
			});			
		}

		/* 생년 선택시 해당 년, 월에 해당하는 일수 구하기 */
		if($(".cssbirthday").length > 0) {
			// 이름에 한글만 입력
			$common.keyPermit.call($(".cssbirthday").eq(0), "KOR");

			$(".cssbirthday").eq(1).bind("change", function() {
				$member.regist.setLastDay.call($(".cssbirthday"));
				return;
			});
			$(".cssbirthday").eq(2).bind("change", function() {
				$member.regist.setLastDay.call($(".cssbirthday"));				
			});
		}

		/* 회원 기본정보 */
		$common.keyPermit.call($("INPUT[id='PName']"), "KOR");

		if($(".cssregBtns").length > 0) {
			$(".cssregBtns").bind("click", function() { 
				$member.regist.commands[$(this).attr("caption")].call(this, { parent : $(".csspinput"), user : $(".cssinput")});
			});
		};
		/* 회원 기본 정보 숫자만 입력 */
		if($(".cssnumber").length > 0) { 
			$(".cssnumber").each(function() { 
				$(this).numeric(); 
				$(this).css("ime-mode", "disabled"); 
				// 크롬에서의 한글 써지는 문제 추가 적용
				$common.keyPermit.call($(this), "NUM");
			}); 
		}

		/* 회원 기본 정보 영어이름 영문만 입력 */
		if($(".alpha").length > 0) { 
			$(".alpha").alphanumeric(); 
			$(".alpha").css("ime-mode", "disabled");
			// 크롬에서의 한글 써지는 문제 추가 적용
			$common.keyPermit.call($(".alpha").eq(0), "ENUM");
		}

		/* 레벨 테스트 */
		// 신청 여부
		$("INPUT[name='LevelFlag']").bind("click", function() {
			if($(this).val().trim() == "N") {
				$("TR[id='trLevel']").hide('slow');
			} else {
				$("TR[id='trLevel']").show('slow');
			}
		});
		// 수업시간/날짜 Add Event OnChage 
		if($(".csstest").length > 0) {
			$(".csstest").eq(0).bind("change", function() {
				$member.regist.setTestTime.call($(this), $(".csstest").eq(1));
			});
		}

		// 회원가입시에는 학생 메일 입력이 없었는데 수정에서 입력 항목이 생김...,
		if($("SELECT[name='SearchEmail3']").length > 0) {
			$("SELECT[name='SearchEmail3']").bind("change", function() {
				if($(this).val().trim() == "00") {
					$("#EmailForm").show();
					$("INPUT[name='SearchEmail2']").focus();
				} else {
					$("#EmailForm").hide();
					$(this).focus();
				}
			});
		}
	},
	/* 로그인 체크 */
	login : function() {
		var bLoginChk = true;
		$(this).each(function(i) {
			if($(this).val().trim() == "") {						
				alert($(this).attr("title") + "를 입력해 주세요.");
				$(this).focus();
				bLoginChk = false;
				return false;
			}
		});

		if(bLoginChk) {

			$("FORM[name='Gform']").submit();
		}		
	},
	regist : {
		/* 년, 월로 해당 월의 마지막 일 수 구하기 */
		setLastDay : function() {			
			$(this).eq(3).find("option").remove(".cssday");

			if($(this).eq(1).val().trim() != "" && $(this).eq(2).val().trim() != "") {
				var year	= parseInt($(this).eq(1).val().trim());
				var month	= parseInt($(this).eq(2).val().trim());
				var last_day= 31;

				switch(parseInt(month)) {
					case(1) : last_day = 31; break;
					case(2) : last_day = (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) ? 29 : 28; break;
					case(3) : last_day = 31; break;
					case(4) : last_day = 30; break;
					case(5) : last_day = 31; break;
					case(6) : last_day = 30; break;
					case(7) : last_day = 31; break;
					case(8) : last_day = 31; break;
					case(9) : last_day = 30; break;
					case(10): last_day = 31; break;
					case(11): last_day = 30; break;
					case(12): last_day = 31; break;
					default : last_day = 31; break;
				}
			} else {
				return;
			}

			var html = "";
			for(var i=1; i<=last_day; i++) {
				html += "<option value='"+ i +"' class='cssday'>"+ i +"일</option>"
			}
			$(this).eq(3).append(html);
		},
		/* 회원 약관 동의 */
		agree : function() {
			var bAgree = true
			$(arguments[0].agree).each(function() {
				if( !$(this).is(':checked') ) {
					alert("이용자 약관 및 개인정보취급방침 동의에 체크하십시요~!!");
					$(this).focus();
					bAgree = false;
					return false;
				}
			});

			if(bAgree) {
				$(arguments[0].user).each(function() {
					if($(this).val().trim() == "") {
						alert($(this).attr("caption") + "을 입력해 주세요.");
						$(this).focus();
						bAgree = false;
						return false;
					}
				});					

				if(bAgree) {
					var bYear = $(arguments[0].user).eq(1).val().trim();
					var utype = (Number($("INPUT[id='year']").val().trim()) < Number(bYear) + 13) ? "J" : "G";

					$("INPUT[id='utype']").val( utype );

					$("FORM[name='Cform']").submit();
				}
			}
		},
		commands : {
			/* 아이디 중복 체크 */
			OVERLAP : function() {
				var ele = {
					url		: "/UserMember/UserIdCheck.asp",
					name	: "idcheck",
					status	: "status=no ,height=240,width=300,left=100,top=100"
				};

				$common.popup.call(this, ele);
			},
			/* 우편번호 검색 */
			FINDZIP	: function() {
				var ele = {
					url		: "/UserMember/zipCheck.asp",
					name	: "zipcheck",
					status	: "height=350,width=418,left=200,top=200, toolbar=no,menubar=no,scrollbars=Yes,status=no"
				};

				$common.popup.call(this, ele);
			},
			REG		: function() {
				var bValidate = true;
				// 법정대리인 폼 유효성 체크
				if($("INPUT[name='utype']").val().trim() == "J") {
					$(arguments[0].parent).each(function(i) {
						if($(this).val().trim() == "") {
							alert('법정대리인 '+ $(this).attr("caption") + "(을)를 입력해 주세요.");
							$(this).focus();
							bValidate = false;
							return false;
						}
					});
				}
				
				if(bValidate) {
					// 이메일 검증 체크
					
					if($("INPUT[name='utype']").val().trim() == "J") {
						if( !$common.chkEmail.call(this, {email1 : $("#PEmail1"), email2 : $("#PEmail2")}) ) {
							alert("Email 주소 형식이 틀립니다.");
							$("#PEmail2").focus();
							return false;
						}
					}
					
					// 기본 정보 폼 유효성 체크
					$(arguments[0].user).each(function() {
						if($(this).val().trim() == "") {
							alert($(this).attr("caption") + "(을)를 입력해 주세요.");
							bValidate = false;
							$(this).focus();
							return false;
						}
					});
				
					if(bValidate) {
						
						

						var $pw = $("#UserPW");
						var $pwConfirm = $("#UserPW2");
						var pw12 = $("#UserPW").val();
						var pw13 = $("#UserPW2").val();
						var vid = "";
						
						if(pw12=='') {
							alert('비밀번호를 입력하세요.');
							$pw.focus();
							return ;
						}	
						
						if(pw12.length < 9 || pw12.length > 16)
						{
							alert("비밀번호를 9자 이상 16자 이하로 입력해주세요.");  
							$pw.focus();
							return  ; 
						}

						var pattern1 =pw12.search(/[0-9]/ig); 
						var pattern2 =pw12.search(/[a-zA-Z]/ig); 
						var pattern3 =pw12.search(/[~!@#$%^()_]/ig); 
						
					
						if (pattern1 < 0 || pattern2 < 0 || pattern3 < 0)   
					   { 
						   alert('비밀번호는 영문자와 숫자 그리고 특수문자 ( ~!@#$%^()_ ) 를 조합해 주세요.'); 
						   $pw.focus();
						   return ; 
						} 

						if($pwConfirm.val()=='') {
							alert('비밀번호 확인을 입력하세요.');
							$pwConfirm.focus();
							return ;
						}

						
						if($pwConfirm.val()!=$pw.val()) {
							alert('비밀번호가 서로 같지 않습니다.');
							$pwConfirm.val('');
							$pwConfirm.focus();
							return ;
						}

						//등록시
						if($("#UserID").length > 0) {
							if ($pw.val().indexOf($("#UserID").val()) > -1)
							{
								alert('비밀번호에는 아이디를 포함할 수 없습니다.');
								return ;
							}
						}
						//수정시
						if($("#oldUserID").length > 0) {
							if ($pw.val().indexOf($("#oldUserID").val()) > -1)
							{
								alert('비밀번호에는 아이디를 포함할 수 없습니다.');
								return ;
							}
						}



						  var SamePass_0 = 0;  //동일문자 카운트
							var SamePass_1 = 0;  //연속성(+) 카운드
							var SamePass_2 = 0;  //연속성(-) 카운드

							var chr_pass_0;
							var chr_pass_1;
							var chr_pass_2;


							for (var i = 0; i < $pw.val().length; i++) {

								if (i >= 2)
								{
								
									chr_pass_0 = $pw.val().charAt(i-2);
									chr_pass_1 = $pw.val().charAt(i-1);
									chr_pass_2 = $pw.val().charAt(i);

									//동일문자 카운트
									if ((chr_pass_0 == chr_pass_1) || (chr_pass_1 == chr_pass_2)) {
										SamePass_0++;
									}
									else {
										SamePass_0 = 0;
									}

									//연속성(+) 카운드

									if (chr_pass_0 - chr_pass_1 == 1 && chr_pass_1 - chr_pass_2 == 1) {
										SamePass_1++;
									}		
									else {
										SamePass_1 = 0;
									}

									//연속성(-) 카운드
									if (chr_pass_0 - chr_pass_1 == -1 && chr_pass_1 - chr_pass_2 == -1) {
										SamePass_2++;		
									}
									else {
										SamePass_2 = 0;
									}
								}
							}

							if (SamePass_0 > 0) {
								alert("동일문자,숫자,특수문자를 2자 연속 사용할 수 없습니다.");
								return  ;
							}
						
						if($("#UserPhone2_1").val() == "") {
							alert("휴대전화 앞자리를 입력해주세요.!");
							$("#UserPhone2_1").focus();
							return;
						}

						if($("#UserPhone2_2").val() == "") {
							alert("휴대전화 중간자리를 입력해주세요.!");
							$("#UserPhone2_2").focus();
							return;
						}

						if($("#UserPhone2_3").val() == "") {
							alert("휴대전화 끝자리를 입력해주세요.!");
							$("#UserPhone2_3").focus();
							return;
						}

						// 학생 이메일 검증 처리
					
						if($("#SearchEmail1").val().trim() == "") {
							alert("이메일 주소를 입력해 주세요.!");
							$("#SearchEmail1").focus();
							return;
						}
						if($("#SearchEmail2").val().trim() == "") {
							alert("이메일 뒷 주소를 입력해 주세요.!");
							$("#SearchEmail2").focus();
							return;
						}
						
						if( !$common.chkEmail.call(this, {email1 : $("#SearchEmail1"), email2 : $("#SearchEmail2")}) ) {
							alert("Email 주소 형식이 틀립니다.");
							$("#SearchEmail2").focus();
							return false;
						}
						
						
						$("FORM[name='Uform']").submit();
					}
				}
			},
			MOD		: function() {
			},
			DEL		: function() {
			},
			CANCEL	: function() {
				//history.go(-1);
				top.location.href="/";
			}
		},
		levelTest : function() {
			if($(".csstest").length > 0) {
				if($(".csstest").eq(0).val().trim() == "") {
					alert("레텔테스트 "+ $(".csstest").eq(0).attr("caption") + "(을)를 선택해 주세요.");
					$(".csstest").eq(0).focus();
					return false;
				}
				if($(".csstest").eq(1).val().trim() == "") {
					alert("레텔테스트 "+ $(".csstest").eq(1).attr("caption") + "(을)를 선택해 주세요.");
					$(".csstest").eq(1).focus();
					return false;
				}
				if($(".csstest").eq(2).val().trim() == "") {
					alert("레텔테스트 "+ $(".csstest").eq(2).attr("caption") + "(을)를 선택해 주세요.");
					$(".csstest").eq(2).focus();
					return false;
				}

				if($(".csstest").eq(0).val().trim() == "2012-05-28") {
					alert("6월 레벨테스트 신청이 종료되었습니다.");
					$(".csstest").eq(0).focus();
					return false;
				}
				
				if($(".csstest").eq(0).val().trim() == $("INPUT[name='today']").val().trim()) {
					if(parseInt($(".csstest").eq(1).val().trim()) >= parseInt($("INPUT[name='todayhour']").val().trim())) {
						if(parseInt($(".csstest").eq(1).val().trim()) == parseInt($("INPUT[name='todayhour']").val().trim())) {
							if(parseInt($(".csstest").eq(2).val().trim()) < parseInt($("INPUT[name='todaymin']").val().trim())) {
								alert("금일신청은 현재시간 2시간 이후 등록이 가능합니다..");
								$(".csstest").eq(1).focus();
								return false;
							}
						}
					} else {
						alert("금일신청은 현재시간 2시간 이후 등록이 가능합니다..");
						$(".csstest").eq(1).focus();
						return false;
					}
				}

				if(!$("INPUT[name='PhoneChoice']").is(":checked")) {
					alert("레벨테스트 전화 타입을 선택하세요 ~!!");
					return false;
				}

				if(!$("INPUT[name='StudentLeveL']").is(":checked")) {
					alert("회원님께서 생각하는 영어실력을 선택하세요 ~!!");
					return false;
				}

				return true;
			} else {
				alert("레벨 테스트 신청에 필요한 요소를 찾을 수 없습니다.\n관리자에게 문의해 주세요.!");
				return false;
			}
		},
		// 레벨테스트 수업날짜 선택시 해당 날짜에 시작하는 수업 시간 설정하기
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
		}
	},

	/* ID / PW 찾기 */
	search : {
		init : function() {
			// 아이디, 비밀번호 
			if($(".cssfBtns").length > 0) {
				$(".cssfBtns").bind("click", function() {
					$member.search.actions[$(this).attr("caption")].call(this);
				});
			}
		},
		actions : {
			FIND	: function() {				
				var bCheck = true;
				$($(this).data("class")).each(function() {
					if($(this).val().trim() == "") {
						alert($(this).attr("caption"));
						$(this).focus();
						bCheck = false;
						return false;
					}
				});

				if(bCheck) {
					$("FORM[name='"+ $(this).data("form") +"']").submit();
				}
			}, 
			CANCEL	: function() {
				location.href = "/";
			}
		}
	},

	/* 탈퇴 */
	out : {
		init : function() {
			if($("#outBtns").length > 0) {
				$("#outBtns").bind("click", function() {
					$member.out.actions.OUT.call($(".cssinput"));
				});
			}
		},
		actions : {
			OUT		: function() {
				var bValidate = true;
				var endMsg;
				$(this).each(function() {
					endMsg = ( $(this).prop("tagName") == "INPUT") ? "입력하세요." : "선택하세요.";

					if($(this).val().trim() == "") {
						alert($(this).attr("caption") + "(을)를 "+ endMsg);
						$(this).focus();
						bValidate = false;
						return false;
					}
				});

				if(bValidate) {					
					if(confirm("정말 탈퇴하시겠습니까?")) {
						$("FORM[name='Dform']").submit();
					} else {
						return;
					}
				}
			}
		}
	}
}
