<script type="text/javascript"> 
	var old_answer = "";
	function toggle3(index) {
		var now_answer = document.getElementById('a'+index);
		var now_line = document.getElementById('q'+index);
		var now_title = document.getElementById('title'+index);
		if(old_answer != now_answer) {
			if(old_answer != "") {
				old_answer.style.display = "none";
				old_title.className = "init";
			}
			now_answer.style.display = "block";
			now_title.className = "acti";
			old_title = now_title;
			old_answer = now_answer;
 
		}else {
			now_answer.style.display = "none";
			now_title.className = "init";
			old_title = "";
			old_answer = "";
		}
	} 
</script>

<table width="670" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td><table width="660" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td background="../img/board/gbox_lbg.gif">&nbsp;</td>
          <td width="623" align="left" bgcolor="#FFFFFF"><table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr> 
                <td height="70"><img src="../img/sub/s06_g_title05.gif" alt="장애관련Q&A" /></td>
              </tr>
              <tr id='title1' onclick='javascript:toggle3(1); return false;' style='cursor:hand;'> 
                <td height="40"><img src="../img/sub/icon_q.gif" align="absmiddle" /> 
                  <span class="point">수강생 말을 선생님께서 듣지 못해요.</span></td>
              </tr>
              <tr  id="a1" style="display:none;"> 
                <td height="40"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td height="30"><span class="point02"><strong> A1. PC와 헤드셋과의 
                        연결 상태를 확인합니다.</strong></span> <br />
                        ① 아날로그 헤드셋 연결 - 두 개의 아날로그 단자로 구성된 일반 헤드셋일 경우 색깔에 맞춰 각 
                        단자에 연결 <br />
                        - 컴퓨터 앞면 단자의 경우 메인보드 설정에 따라 작동하지 않는 경우가 많으니, 뒷면 단자 연결 
                        권장.</td>
                    </tr>
                    <tr> 
                      <td height="30"><table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="10"><img src="../img/sub/bot_box01.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box02.gif"></td>
                            <td width="10"><img src="../img/sub/bot_box03.gif" width="10" height="10" /></td>
                          </tr>
                          <tr> 
                            <td background="../img/sub/bot_box08.gif">&nbsp;</td>
                            <td width="275"><img src="../img/sub/sub03_info_img14.gif" /></td>
                            <td background="../img/sub/bot_box04.gif">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td><img src="../img/sub/bot_box07.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box06.gif"></td>
                            <td><img src="../img/sub/bot_box05.gif" width="10" height="10" /></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td height="20"> </td>
                    </tr>
                    <tr> 
                      <td height="30"> ② 디지털 헤드셋 연결<br />
                        - USB 형태의 디지털 헤드셋일 경우 USB단자에 연결</td>
                    </tr>
                    <tr> 
                      <td height="20"> </td>
                    </tr>
                    <tr> 
                      <td height="30"> <span class="point02"> <strong>A2. 헤드셋 
                        설정을 확인합니다.</strong><br />
                        </span> ① 바탕화면 오른쪽 하단의 볼륨컨트롤을 실행합니다.</td>
                    </tr>
                    <tr> 
                      <td><table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="10"><img src="../img/sub/bot_box01.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box02.gif"></td>
                            <td width="10"><img src="../img/sub/bot_box03.gif" width="10" height="10" /></td>
                          </tr>
                          <tr> 
                            <td background="../img/sub/bot_box08.gif">&nbsp;</td>
                            <td><img src="../img/sub/sub03_info_img01.gif" /></td>
                            <td background="../img/sub/bot_box04.gif">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td><img src="../img/sub/bot_box07.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box06.gif"></td>
                            <td><img src="../img/sub/bot_box05.gif" width="10" height="10" /></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td height="20"> </td>
                    </tr>
                    <tr> 
                      <td height="30"> ② 마이크를 음소거 체크합니다. 자신의 마이크 소리를 자기가 듣는 옵션이므로, 
                        반드시 음소거 시켜줍니다. </td>
                    </tr>
                    <tr> 
                      <td><table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="10"><img src="../img/sub/bot_box01.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box02.gif"></td>
                            <td width="10"><img src="../img/sub/bot_box03.gif" width="10" height="10" /></td>
                          </tr>
                          <tr> 
                            <td background="../img/sub/bot_box08.gif">&nbsp;</td>
                            <td width="283"><img src="../img/sub/sub03_info_img02.gif" /></td>
                            <td background="../img/sub/bot_box04.gif">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td><img src="../img/sub/bot_box07.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box06.gif"></td>
                            <td><img src="../img/sub/bot_box05.gif" width="10" height="10" /></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td height="20"> </td>
                    </tr>
                    <tr> 
                      <td height="30"> ③ 볼륨컨트롤 메뉴 중, [옵션]선택 후 [속성]을 클릭하여 볼륨조정 
                        부분의 [녹음]선택 후 [확인]을 클릭합니다. </td>
                    </tr>
                    <tr> 
                      <td><table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="10"><img src="../img/sub/bot_box01.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box02.gif"></td>
                            <td width="10"><img src="../img/sub/bot_box03.gif" width="10" height="10" /></td>
                          </tr>
                          <tr> 
                            <td background="../img/sub/bot_box08.gif">&nbsp;</td>
                            <td><img src="../img/sub/sub03_info_img03.gif" /></td>
                            <td background="../img/sub/bot_box04.gif">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td><img src="../img/sub/bot_box07.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box06.gif"></td>
                            <td><img src="../img/sub/bot_box05.gif" width="10" height="10" /></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td height="20"> </td>
                    </tr>
                    <tr> 
                      <td>④ 마이크가 선택되어 있는지 확인합니다. 녹음하는 기기를 선택하는 내용이므로 반드시 마이크를 
                        선택합니다. </td>
                    </tr>
                    <tr> 
                      <td><table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="10"><img src="../img/sub/bot_box01.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box02.gif"></td>
                            <td width="10"><img src="../img/sub/bot_box03.gif" width="10" height="10" /></td>
                          </tr>
                          <tr> 
                            <td background="../img/sub/bot_box08.gif">&nbsp;</td>
                            <td><img src="../img/sub/sub03_info_img04.gif" /></td>
                            <td background="../img/sub/bot_box04.gif">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td><img src="../img/sub/bot_box07.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box06.gif"></td>
                            <td><img src="../img/sub/bot_box05.gif" width="10" height="10" /></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td height="20"> </td>
                    </tr>
                    <tr> 
                      <td> <span class="point02"><strong>A3. 마이크 구동을 확인합니다.</strong></span> 
                        <br />
                        ① 볼륨컨트롤을 실행합니다.<br />
                        ② 옵션 -> 속성 -> 볼륨조정 부분의 [녹음]또는 믹서장치의 [Input] 장치 선택 -><br />
                        내용 중 [마이크]와 [Stereo Mix]를 체크 후 확인 </td>
                    </tr>
                    <tr> 
                      <td><table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="10"><img src="../img/sub/bot_box01.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box02.gif"></td>
                            <td width="10"><img src="../img/sub/bot_box03.gif" width="10" height="10" /></td>
                          </tr>
                          <tr> 
                            <td background="../img/sub/bot_box08.gif">&nbsp;</td>
                            <td><img src="../img/sub/sub03_info_img17.gif" /></td>
                            <td background="../img/sub/bot_box04.gif">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td><img src="../img/sub/bot_box07.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box06.gif"></td>
                            <td><img src="../img/sub/bot_box05.gif" width="10" height="10" /></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td height="20"> </td>
                    </tr>
                    <tr> 
                      <td> ③ 녹음장치를 ‘마이크’로 선택 </td>
                    </tr>
                    <tr> 
                      <td><table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="10"><img src="../img/sub/bot_box01.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box02.gif"></td>
                            <td width="10"><img src="../img/sub/bot_box03.gif" width="10" height="10" /></td>
                          </tr>
                          <tr> 
                            <td background="../img/sub/bot_box08.gif">&nbsp;</td>
                            <td><img src="../img/sub/sub03_info_img04.gif" /></td>
                            <td background="../img/sub/bot_box04.gif">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td><img src="../img/sub/bot_box07.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box06.gif"></td>
                            <td><img src="../img/sub/bot_box05.gif" width="10" height="10" /></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td>④ 녹음기 실행 [시작 -> 프로그램 -> 보조프로그램 -> 엔터테인먼트 -> ‘녹음기’실행<br />
                        ⑤ 녹음버튼을 눌러 녹음 후 [정지 -> 재생] 하여 마이크 상태와 헤드폰 상태 점검 녹음이 재대로 
                        되었다면 마이크 정상작동 하는 것입니다.</td>
                    </tr>
                    <tr> 
                      <td height="20"> </td>
                    </tr>
                  </table></td>
              </tr>
            </table>
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr id='title2' onclick='javascript:toggle3(2); return false;' style='cursor:hand;'> 
                <td height="40"><img src="../img/sub/icon_q.gif" align="absmiddle" /> 
                  <span class="point">잡음이 심해요.</span></td>
              </tr>
              <tr id="a2" style="display:none;"> 
                <td height="40"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td> <span class="point02">A. 내장형 마이크가 있을 경우 잡음이 심하며, 본인의 
                        목소리 전달이 정확히 되지 않을 수 있습니다. <br />
                        내장형 마이크를 사용안함으로 설정해주세요.</span> ;</td>
                    </tr>
                    <tr> 
                      <td> 1. 화면 좌측 하단의 [시작 -> 설정 -> 제어판]으로 이동하세요. <br />
                        제어판화면이 아래의 그림처럼 나온다면 [클래식보기로 전환]을 클릭합니다.</td>
                    </tr>
                    <tr> 
                      <td><table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="10"><img src="../img/sub/bot_box01.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box02.gif"></td>
                            <td width="10"><img src="../img/sub/bot_box03.gif" width="10" height="10" /></td>
                          </tr>
                          <tr> 
                            <td background="../img/sub/bot_box08.gif">&nbsp;</td>
                            <td><img src="../img/sub/sub03_info_img15.gif" /></td>
                            <td background="../img/sub/bot_box04.gif">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td><img src="../img/sub/bot_box07.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box06.gif"></td>
                            <td><img src="../img/sub/bot_box05.gif" width="10" height="10" /></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td height="20"> </td>
                    </tr>
                    <tr> 
                      <td>2. 제어판 화면에서 [시스템] 학목을 선택하세요. </td>
                    </tr>
                    <tr> 
                      <td><table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="10"><img src="../img/sub/bot_box01.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box02.gif"></td>
                            <td width="10"><img src="../img/sub/bot_box03.gif" width="10" height="10" /></td>
                          </tr>
                          <tr> 
                            <td background="../img/sub/bot_box08.gif">&nbsp;</td>
                            <td><img src="../img/sub/sub03_info_img16.gif" /></td>
                            <td background="../img/sub/bot_box04.gif">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td><img src="../img/sub/bot_box07.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box06.gif"></td>
                            <td><img src="../img/sub/bot_box05.gif" width="10" height="10" /></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td height="20"> </td>
                    </tr>
                    <tr> 
                      <td> 3. 하드웨어 탭으로 이동후, [장치관리자(D)]를 선택하세요. </td>
                    </tr>
                    <tr> 
                      <td><table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="10"><img src="../img/sub/bot_box01.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box02.gif"></td>
                            <td width="10"><img src="../img/sub/bot_box03.gif" width="10" height="10" /></td>
                          </tr>
                          <tr> 
                            <td background="../img/sub/bot_box08.gif">&nbsp;</td>
                            <td><img src="../img/sub/sub03_img21.gif" /></td>
                            <td background="../img/sub/bot_box04.gif">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td><img src="../img/sub/bot_box07.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box06.gif"></td>
                            <td><img src="../img/sub/bot_box05.gif" width="10" height="10" /></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td height="20"> </td>
                    </tr>
                    <tr> 
                      <td> 4. 사운드, 비디오 및 게임 컨트롤러 항목을 확인하세요. 마이크가 내장되어 있는 웹캠이나 
                        노트북의 경우 아래와 같이 오디오 장치가 2개 이상으로 보입니다. 이럴 경우 <span class="point02">내장형 
                        마이크를 선택하여 [사용안함]</span> 으로 변경해 주세요. <br />
                        예) Logitech Mic, Mircrosoft Mic, Web Cam Mic 등등..</td>
                    </tr>
                    <tr> 
                      <td><table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="10"><img src="../img/sub/bot_box01.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box02.gif"></td>
                            <td width="10"><img src="../img/sub/bot_box03.gif" width="10" height="10" /></td>
                          </tr>
                          <tr> 
                            <td background="../img/sub/bot_box08.gif">&nbsp;</td>
                            <td><img src="../img/sub/sub03_info_img18.gif" /></td>
                            <td background="../img/sub/bot_box04.gif">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td><img src="../img/sub/bot_box07.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box06.gif"></td>
                            <td><img src="../img/sub/bot_box05.gif" width="10" height="10" /></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td height="20"> </td>
                    </tr>
                  </table></td>
              </tr>
            </table>
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr id='title3' onclick='javascript:toggle3(3); return false;' style='cursor:hand;'> 
                <td height="40"><img src="../img/sub/icon_q.gif" align="absmiddle" /> 
                  <span class="point">영상이 나오지 않아요.</span></td>
              </tr>
              <tr id="a3" style="display:none;"> 
                <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td><span class="point02">A. 이미 다른 프로그램에서 화상캠을 구동하고 있을 경우, 
                        화상강의실에서 영상이 나오지 않습니다. 강의실 입장 전 모든 프로그램을 종료 후 입장해 주세요. 
                        </span> <br />
                        1. 화면 좌측 하단의 [시작 -> 설정 -> 제어판]으로 이동하세요. 제어판화면이 아래의 그림처럼 
                        나온다면 [클래식보기로 전환]을 클릭합니다.</td>
                    </tr>
                    <tr> 
                      <td><table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="10"><img src="../img/sub/bot_box01.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box02.gif"></td>
                            <td width="10"><img src="../img/sub/bot_box03.gif" width="10" height="10" /></td>
                          </tr>
                          <tr> 
                            <td background="../img/sub/bot_box08.gif">&nbsp;</td>
                            <td><img src="../img/sub/sub03_info_img15.gif" /></td>
                            <td background="../img/sub/bot_box04.gif">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td><img src="../img/sub/bot_box07.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box06.gif"></td>
                            <td><img src="../img/sub/bot_box05.gif" width="10" height="10" /></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td height="20"> </td>
                    </tr>
                    <tr> 
                      <td> 2. 제어판 화면에서 [시스템] 학목을 선택하세요. </td>
                    </tr>
                    <tr> 
                      <td><table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="10"><img src="../img/sub/bot_box01.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box02.gif"></td>
                            <td width="10"><img src="../img/sub/bot_box03.gif" width="10" height="10" /></td>
                          </tr>
                          <tr> 
                            <td background="../img/sub/bot_box08.gif">&nbsp;</td>
                            <td><img src="../img/sub/sub03_info_img16.gif" /></td>
                            <td background="../img/sub/bot_box04.gif">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td><img src="../img/sub/bot_box07.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box06.gif"></td>
                            <td><img src="../img/sub/bot_box05.gif" width="10" height="10" /></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td height="20"> </td>
                    </tr>
                    <tr> 
                      <td><p><span lang="EN-US" xml:lang="EN-US"> 3. 하드웨어 탭으로 
                          이동후, [장치관리자(D)]를 선택하세요.</span></p></td>
                    </tr>
                    <tr> 
                      <td><table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="10"><img src="../img/sub/bot_box01.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box02.gif"></td>
                            <td width="10"><img src="../img/sub/bot_box03.gif" width="10" height="10" /></td>
                          </tr>
                          <tr> 
                            <td background="../img/sub/bot_box08.gif">&nbsp;</td>
                            <td><img src="../img/sub/sub03_img21.gif" /></td>
                            <td background="../img/sub/bot_box04.gif">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td><img src="../img/sub/bot_box07.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box06.gif"></td>
                            <td><img src="../img/sub/bot_box05.gif" width="10" height="10" /></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td height="20"> </td>
                    </tr>
                    <tr> 
                      <td>4. 장치관리자 항목에 ]<img src="../img/sub/sub03_info_img022.gif" align="absmiddle" />가 
                        없다면 카메라 드라이버 설치가 잘못되었거나 설치가 안된 상태입니다. <span class="point02"> 
                        이 경우 드라이버를 다시 설치해 주시면 됩니다.</span></td>
                    </tr>
                    <tr> 
                      <td><table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="10"><img src="../img/sub/bot_box01.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box02.gif"></td>
                            <td width="10"><img src="../img/sub/bot_box03.gif" width="10" height="10" /></td>
                          </tr>
                          <tr> 
                            <td background="../img/sub/bot_box08.gif">&nbsp;</td>
                            <td><img src="../img/sub/sub03_info_img19.gif" /></td>
                            <td background="../img/sub/bot_box04.gif">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td><img src="../img/sub/bot_box07.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box06.gif"></td>
                            <td><img src="../img/sub/bot_box05.gif" width="10" height="10" /></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td height="20"> </td>
                    </tr>
                    <tr> 
                      <td>[이미징 장치] 또는 [기타 장치] 항목에 느낌표 표시가 나왔다면 드라이버 설치가 잘 못된 경우입니다.<span class="point02"> 
                        <br />
                        연결되어 있는 USB케이블을 다른 슬롯에 연결한 후 드라이버를 다시 설치해 주세요.</span></td>
                    </tr>
                    <tr> 
                      <td><table border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="10"><img src="../img/sub/bot_box01.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box02.gif"></td>
                            <td width="10"><img src="../img/sub/bot_box03.gif" width="10" height="10" /></td>
                          </tr>
                          <tr> 
                            <td background="../img/sub/bot_box08.gif">&nbsp;</td>
                            <td><img src="../img/sub/sub03_info_img020.gif" /></td>
                            <td background="../img/sub/bot_box04.gif">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td><img src="../img/sub/bot_box07.gif" width="10" height="10" /></td>
                            <td background="../img/sub/bot_box06.gif"></td>
                            <td><img src="../img/sub/bot_box05.gif" width="10" height="10" /></td>
                          </tr>
                        </table></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
          <td background="../img/board/gbox_rbg.gif">&nbsp;</td>
        </tr>
        <tr> 
          <td width="15"><img src="../img//board/gbox_lb.gif" width="15" height="15" /></td>
          <td background="../img/board/gbox_bbg.gif"></td>
          <td width="15"><img src="../img/board/gbox_rb.gif" width="15" height="15" /></td>
        </tr>
      </table></td>
  </tr>
</table>
