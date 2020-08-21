<!--Copyright (C) 2014, jQuery Foundation

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
-->
<script type="text/javascript" src="//code.jquery.com/jquery-2.1.1.min.js"></script>

<script type="text/javascript">
 ExecuteOrDelayUntilScriptLoaded(getUser, "sp.js"); 
var PWAUsageListName = 'PWAUsageList' //update for correct list name
var browser
var userId
var userName
var currentUser

//get the current user
function getUser(){
    this.clientContext = new SP.ClientContext.get_current()
    this.oWeb = clientContext.get_web()
    currentUser = this.oWeb.get_currentUser()
    this.clientContext.load(currentUser)
    this.clientContext.executeQueryAsync(
		Function.createDelegate(this,this.onQuerySucceededUser), 
		Function.createDelegate(this,this.onQueryFailedUser))
}
function onQuerySucceededUser() {
	userId = currentUser.get_id() 
	userName = currentUser.get_title()
	browserType()
}
function onQueryFailedUser(sender, args) {
    alert('Request failed. \nError: ' + args.get_message() + '\nStackTrace: ' + args.get_stackTrace())
} 

//get browser version
function browserType() { 
if(navigator.userAgent.indexOf("Edge") != -1 )
    {
      browser = 'Edge' 
    }
    else if(navigator.userAgent.indexOf("Chrome") != -1 )
    {
      browser = 'Chrome'
    }
    else if(navigator.userAgent.indexOf("Firefox") != -1 ) 
    {
      browser = 'Firefox'
    }
    else if((navigator.userAgent.indexOf("MSIE") != -1 ) || (!!document.documentMode == true )) //for IE 10 or later
    {
      browser = 'IE'
    }
    else 
    {
      browser = 'other'
    }
	checkList()
}

//create entry on the PWA usage list if one doesnt exist for today
function checkList() {

	//todays date set to midnight
	var d = new Date();
	d.setHours(0, -d.getTimezoneOffset(), 0, 0)
	
	var data = $.ajax({url: _spPageContextInfo.siteAbsoluteUrl + "/_api/web/lists/getbytitle('" + PWAUsageListName +"')/items?$Filter=LogonDate gt '" + d.toISOString() + "' and WhoString eq '" + userName + "'",
					type: "GET",
					dataType: "json",
					headers: {Accept: "application/json;odata=verbose"	}       
					});
					
			data.done(function (data,textStatus, jqXHR){
				var results = data.d.results.length;
				if (data.d.results.length < 1){
					createListItem()
				}
			});
			data.fail(function (jqXHR,textStatus,errorThrown){
            alert("Error retrieving data: " + jqXHR.responseText)
			})
}	
	
function createListItem() {							
    var clientContext = new SP.ClientContext.get_current();
    var oList = clientContext.get_web().get_lists().getByTitle(PWAUsageListName)
        
    var itemCreateInfo = new SP.ListItemCreationInformation()
    this.oListItem = oList.addItem(itemCreateInfo)
    oListItem.set_item('Title', 'Usage Item')
    oListItem.set_item('Browser', browser)
	oListItem.set_item('Who', userId)
	oListItem.set_item('WhoString', userName)
	oListItem.update()

    clientContext.load(oListItem)
    clientContext.executeQueryAsync(
        Function.createDelegate(this, this.onQuerySucceeded), 
        Function.createDelegate(this, this.onQueryFailed)
    );
}
function onQuerySucceeded() {
	//alert('Item created')
}
function onQueryFailed(sender, args) {
    alert('Request failed. \nError: ' + args.get_message() + '\nStackTrace: ' + args.get_stackTrace())
}
</script>