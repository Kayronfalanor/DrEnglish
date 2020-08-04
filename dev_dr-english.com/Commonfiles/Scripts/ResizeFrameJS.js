var ifrm_resize_try_cnt = 0
function Resize_Frame(name)
{
	try
	{   
		ifrm_resize_try_cnt = ifrm_resize_try_cnt + 1;

		var oBody 	= document.frames(name).document.body;

		var oFrame 	= document.all(name);

		oFrame.style.width 
				= oBody.scrollWidth + (oBody.offsetWidth-oBody.clientWidth);
		oFrame.style.width
				=	"100%";
		oFrame.style.height 
				= oBody.scrollHeight + (oBody.offsetHeight-oBody.clientHeight);

		if (oFrame.style.height == "0px" || oFrame.style.width == "0px")
		{
			oFrame.style.width = "100%";
			oFrame.style.height = "200px"; 
			window.status = 'iframe resizing fail.';
			if ( ifrm_resize_try_cnt < 2 )
			{
				window.status = 'resizing failed. retrying..';
				Resize_Frame(name);
			}
		}
		else
		{
			window.status = '';
		}
	}
	catch(e)
	{
		window.status = 'Error: ' + e.number + '; ' + e.description;
	}
}

// 리사이즈 함수 추가 - 2012-06-16
function iframeAutoResize(arg) {
	try
	{
		 arg.height = eval(arg.name+".document.body.scrollHeight");
		 document.documentElement.scrollTop = 0;
		 document.body.scrollTop = 0;
	}
	catch(e)
	{
		window.status = 'Error: ' + e.number + '; ' + e.description;
	}
 }
 