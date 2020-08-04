var $popup = {
	setCookie : function(name, value, exprie) {
		var today_date = new Date();
		var expire_date = new Date();
		expire_date.setDate( today_date.getDate() + exprie);
		document.cookie = name + "=" + escape(value) + "; expires=" + expire_date.toGMTString() + "; path=/"; 
	},
	getCookie : function(name) {
		var from_idx = document.cookie.indexOf(name+"=");
		if (from_idx != -1) { 
			from_idx += name.length + 1
			to_idx = document.cookie.indexOf(";", from_idx) 

			if (to_idx == -1) {
				to_idx = document.cookie.length
			}
			return unescape(document.cookie.substring(from_idx, to_idx))
		}
	},
	clearCookie : function(name) {
		var today = new Date();
		//어제 날짜를 쿠키 소멸 날짜로 설정한다.
		var expire_date = new Date(today.getTime() - 60*60*24*1000);
		document.cookie = name + "= " + "; expires=" + expire_date.toGMTString() + "; path=/";
	}
}