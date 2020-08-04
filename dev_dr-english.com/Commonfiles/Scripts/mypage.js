/* 마이페이지 스크립트 */
var $mypage = {
/* 학습 현황 */
	study : {
		init : function() {
			if($(".cssBtns").length > 0) {
				$(".cssBtns").bind("click", function() { $mypage.study.actions[$(this).attr("caption")].call($(this)); });
			}

			// 학습현황 상세보기 매일 학습, 화상 수업 Start
			if($(".cssstudy").length > 0) {
				$(".cssstudy").bind("click", function() {
					$mypage.study.actions[$(this).attr("caption")].call(this);
				});
			}

			// 학습현황 매일 학습 학습하기
			if($(".cssbook").length > 0) {
				$(".cssbook").bind("click", function() {
					$mypage.study.actions.STUDYRUN.call(this);
				});
			}
		},
		actions : {
			REPORT : function() {
				if($(this).data("flag").trim() == "N") {
					alert("수업이 진행중이지 않습니다.");
					return;
				}

				$("INPUT[name='sche_seq']").val( $(this).data("seq") );
				$("FORM[name='Bform']").attr("action", "/MyPage/MypageView.asp").submit();
			},			
			BSTUDY : function() { // 교재 학습
				var winHei = $(document).height();
				var winWid = $(window).width();

				var win = window.open('', 'bookstudy', "toolbar=no,location=no, directories=no,status=no,menubar=no,scrollbars=no,resizable=no,height="+winHei+",width="+winWid+",top=0,left=0");
				$("FORM[name='Bform']").attr({
					"target" : "bookstudy",
					"action" : "List2.asp"
				}).submit();

				$("FORM[name='videofrom']").attr("action", "/MyPage/MypageView.asp");
			},
			ALERT : function() { // 화상 수업 시간 체크
				alert($(this).attr("message"));
				$("FORM[name='Bform']").submit();
				return;
			},
			POSTPONE : function() { // 수업 강사 휴강 체크 및 사유
				$("DIV[id='AlertMSG']").dialog({
					show:"blind",
					hide:"explode",
					resizeable:false,
					modal:true,
					buttons : {
						"수업시작" : function() {
							$mypage.study.actions.VIDEOVIEW.call();
							$(this).dialog("close");
						}
					}
				});
			},
			VIDEOVIEW : function() { // 화상 수업 Start
				//var win = window.open("", "video", "width=500 ,height=400 , top=0 ,left=200 ,scrollbars=NO ,status=NO");
				$("FORM[name='videofrom']").attr("target", "GetData").submit();
			},
			VIDEOVIEW2 : function() { // 화상 수업 Start
				//var win = window.open("", "video", "width=500 ,height=400 , top=0 ,left=200 ,scrollbars=NO ,status=NO");
				$("FORM[name='videofrom']").attr("target", "_blank").submit();
			},
			CERTI : function() { // 수강확인증
				var win = window.open("", "certificate", "width=427,height=570");
				$("FORM[name='Bform']").attr({
					"target" : "certificate",
					"action" : "certificate.asp"
				}).submit();

				$("FORM[name='Bform']").attr("action", "/MyPage/MypageView.asp");
			},
			STUDYRUN : function() {
				var winHei = $(document).height();
				var winWid = $(window).width();

				var ele = {
					url		: "http://" + $(this).data("url"),
					name	: "bookstudy",
					status  : "toolbar=no,location=no, directories=no,status=no,menubar=no,scrollbars=no,resizable=no,height="+ winHei +",width="+ winWid +",top=0,left=0"
				};

				$common.popup.call(this, ele);
			}
		}
	},
/* 나의 성적표 */
	report : {
		init : function() {
			// 나의 성적표 Buttons
			if($(".cssRBtns").length > 0) {
				$(".cssRBtns").bind("click", function() {
					$mypage.report.actions[$(this).attr("caption")].call(this);
					return;
				});				
			}

			// 나의 성적표 내용 확인 view
			if($(".cssview").length > 0) {
				$(".cssview").bind("click", function() {
					$mypage.report.actions.VIEW.call(this);
					return;
				});
			}
		},
		actions : {
			LEVELTEST : function() {
				var ele = {
					url		: "LevelTestView.asp",
					name	: "LevelTest",
					status	: "width=690 ,height=650 , top=0 ,left=0 ,scrollbars=YES ,status=NO"
				};
				$common.popup.call(this, ele);
			},
			VIEW : function() {
				$("INPUT[name='imr_seq']").val( $(this).data("seq") );
				$("FORM[name='Bform']").attr("action", "ReportView.asp").submit();
			}
		}
	},
/* 영어일기, To My Teacher */
	diary : {
		init : function() {
			if($(".cssBtns").length > 0) {
				$(".cssBtns").bind("click", function() {
					$mypage.diary.actions[$(this).attr("caption")].call(this, $(".cssinput"));
				});
			}

			// 글보기 class
			if($(".csshref").length > 0) {
				$(".csshref").bind("click", function() {
					$mypage.diary.actions.VIEW.call(this);
					return;
				});
			}
		},
		actions : {
			LIST : function() {
				$("INPUT[name='seq']").val("");
				$("FORM[name='Bform']").attr("action", "List.asp").submit();
			},
			VIEW : function() {
				$("INPUT[name='seq']").val( $(this).data("seq") );
				$("FORM[name='Bform']").attr("action", "View.asp").submit();
			},
			WRITE : function() {
				$("FORM[name='Bform']").attr("action", "Write.asp").submit();
			},
			WRITEOK : function() {
				var bValidate = true;
				$(arguments[0]).each(function() {
					if($(this).val().trim() == "") {
						alert($(this).attr("caption") + "(을)를 입력해 주세요.!");
						$(this).focus();
						bValidate = false;
						return false;
					}
				});

				if(bValidate) {
					$("FORM[name='formdboard']").submit();
				}
			},
			DELETE : function() {
				if(confirm("정말 삭제하시겠습니까?")) {
					$("FORM[name='Bform']").attr("action", "Del.asp").submit();
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
/*  휴강신청 */
	PostPone : {
		init : function() {
			// 휴강 신청
			if($(".cssRequest").length > 0) {
				$(".cssRequest").bind("click", function() {
					$mypage.PostPone.actions.REQUEST.call(this);
				});
			}

			// 휴강신청 휴강, 보강일
			if($(".cssdate").length > 0) {
				$(".cssdate").each(function() {
					$mypage.PostPone.DateControl.changeDate.call(this);
				});
			}			

			// 목록, 글등록, 수정, 삭제 버튼 액션 설정
			if($(".cssPBtns").length > 0) {
				$(".cssPBtns").bind("click", function() {
					$mypage.PostPone.actions[$(this).attr("caption")].call(this, $(".cssinput"));
				});
			}
		},
		DateControl : {
			holidayChk : function(date) { // 센터 휴강일과 토요일, 일요일 선택 불가 체크
				var yyyy	= date.getFullYear();
				var mm		= date.getMonth() +1;
				mm			= (mm < 10) ? "0" + mm : mm;
				var dd		= (date.getDate() < 10) ? "0"+ date.getDate() : date.getDate();

				var arrHDay= $("INPUT[id='holiday']").val().split(",");
				for(i = 0; i < arrHDay.length; i++) {
					if($.inArray(yyyy + '-' + mm + '-' + dd, arrHDay) != -1) {
						return true;						
					}
				}

				return false;
			},
			noWeekendsOrHolidays : function(date) {			
				var WeekCode = date.getDay();
				var bHoliday = $mypage.PostPone.DateControl.holidayChk.call(this, date);

				return (bHoliday) ? true : [0 < WeekCode && WeekCode < 6];
			},
			changeDate : function() { //DatePicker
				$.datepicker.setDefaults({
					dateFormat: 'yy-mm-dd',
					defaultDate: "",
					changeMonth: true,
					changeYear: true
				});

				$(this).datepicker({
					beforeShowDay: $mypage.PostPone.DateControl.noWeekendsOrHolidays,
					minDate: "+2d",
					maxDate: new Date($(this).data("date"))
				});
			}
		},
		actions : {
			REQUEST : function() {
				if($("INPUT[name='req_seq']").length > 0) {
					$("INPUT[name='req_seq']").val( $(this).data("rseq") );
				}
				if($("INPUT[name='sche_seq']").length > 0) {
					$("INPUT[name='sche_seq']").val( $(this).data("sseq") );
				}
				$("FORM[name='Bform']").attr("action", "Write.asp").submit();
			},
			LIST	: function() {
				var url = ($("INPUT[id='ExecMode']").val().trim() == "INS") ? "WriteSelect.asp" : "List.asp";
				$("FORM[name='formdboard']").attr("action", url).submit();
			},
			REGIST	: function() {
				var bValidate = true;
				$(arguments[0]).each(function() {
					if($(this).val().trim() == "") {
						alert($(this).attr("caption"));
						$(this).focus();
						bValidate = false;
						return false;
					}
				});

				if(bValidate) {
					var hDate = $("#Hdate").val().trim();
					var bDate = $("#Bdate").val().trim();

					if(hDate == bDate) {
						alert("휴강 신청일과 보강 신청일을 다르게 선택해 주세요.");
						$("#Bdate").focus();
						return;
					}
					if(parseInt(hDate.replace(/-/g, "")) > parseInt(bDate.replace(/-/g, ""))) {
						alert("보강 신청일은 휴강 신청일 보다 커야 합니다.");
						$("#Bdate").focus();
						return;
					}

					$("FORM[name='formdboard']").attr("action", "WriteOK.asp").submit();
				}
			},
			DELETE	: function() {
				$("INPUT[id='ExecMode']").val("DEL");
				$("FORM[name='formdboard']").attr("action", "WriteOK.asp").submit();
			}
		}
	}
}