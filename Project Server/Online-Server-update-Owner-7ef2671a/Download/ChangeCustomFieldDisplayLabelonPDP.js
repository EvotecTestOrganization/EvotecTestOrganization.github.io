<script type="text/javascript" src="/sites/pwa/Style%20Library/jquery-2.1.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(".ms-accentText").filter(function () {
		return $(this).text() == "Owner";
	}).text('Project Manager');
});
</script>