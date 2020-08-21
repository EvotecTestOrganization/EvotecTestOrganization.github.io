<script type="text/javascript" src="/sites/PWA3/Shared%20Documents/jquery-2.1.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(".ms-textXSmall").filter(function () {
		return $(this).text() == "Specify a name for the Enterprise Project";
	}).text('Enter a name for the project');
});
</script>