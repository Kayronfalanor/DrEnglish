var $contents = {
	board : {
		init : function() {
			// �ۺ���
			if($(".csshref").length > 0) {
				$(".csshref").bind("click", function() {
					$contents.board.actions.VIEW.call($(this));
				});
			}
			//������
			if($("#btnList").length > 0) {
				$("#btnList").bind("click", function() {
					$contents.board.actions[$(this).attr("caption")].call($(this));
				});
			}
		},
		actions : {
			VIEW : function() {
				$("INPUT[name='seq']").val( $(this).data("seq") );
				$("FORM[name='Bform']").attr("action", "View.asp").submit();

				$("FORM[name='Bform']").attr("action", "List.asp")
			}, 
			
			LIST : function() {
				$("FORM[name='Bform']").attr("action", "List.asp").submit();
			}
		}
	}
}