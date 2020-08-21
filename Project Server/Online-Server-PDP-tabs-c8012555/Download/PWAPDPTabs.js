<!--Copyright (C) 2014, jQuery Foundation

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
-->
      <link  type="text/css" href = "//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel = "stylesheet">
	  <script type="text/javascript" src = "//code.jquery.com/jquery-3.3.1.js"></script>
	  <script type="text/javascript" src = "//code.jquery.com/ui/1.12.0/jquery-ui.js"></script>

<!-- Update the list and divs for your web part details -->
<div id="tabs">  
    <ul>
        <li id="projDetails" onclick="showDetails()" ><a href="#details">Project Details</a></li>
        <li id="projInfo" onclick="showInfo()" ><a href="#info">Project Information</a></li>
    </ul>
	<div id="details">		
	</div>
	<div id="info">		
	</div>
</div>

<script type="text/javascript">
//replace all web part references such as MSOZoneCell_WebPartWPQ4 with the correct web parts for your PDP
//if you add or remove to the list above, ensure to update the functions below as required
$(document).ready(function () {
$("#MSOZoneCell_WebPartWPQ4").hide();
$("#MSOZoneCell_WebPartWPQ3").appendTo("#details");
$("#MSOZoneCell_WebPartWPQ4").appendTo("#info");
});

$(function() {
        $('#tabs').tabs();
            });

function showDetails() {
	$("#MSOZoneCell_WebPartWPQ3").show();
	$("#MSOZoneCell_WebPartWPQ4").hide();
}

function showInfo() {
	$("#MSOZoneCell_WebPartWPQ3").hide();
	$("#MSOZoneCell_WebPartWPQ4").show();
}
</script>