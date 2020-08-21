# Sort Project Server Timesheet Line Classifications in Add an existing task pag

## Original Links

- [x] Original Technet URL [Sort Project Server Timesheet Line Classifications in Add an existing task pag](https://gallery.technet.microsoft.com/Sort-Server-Timesheet-Line-d2634985)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Sort-Server-Timesheet-Line-d2634985/description)
- [x] Download: [Download Link](Download\JS-SortTimeLineClassification.txt)

## Output from Technet Gallery

Hi,

I was thinking of uploading this solution earlier when I was struggling to get Project Server 2010 timesheet line classification sorted in ascending order under "Add an existing task" dialogue box. But due to stretch assignments got delayed but as said it's  always good to be late then never :) :)

The underlying problem is OOTB feature displays first the native "**Standard**" line and then all my custom classifications by alphabetical order.

Surprisingly same configuration used to work in PS 2007 environment.Means in PS 2007 dialogue box displays the timesheet line classification in exact ascending sort order whether it 's default or custom line classification.

But this OOTB feature from PS 2010 was not at all accepted by my client. So as quick solution thought of writing the javascript which will sort Timesheet line classification dropdown list in ascending order.

So to achieve this add this attached javascript code to "**Select Task Dlg.aspx**" page which is the aspx page for "**Add and existing task**" modal dialogue box.

Add the attached code under function **Body\_OnLoad() **after function **Init();**call

Here I have attached 2 attachment first contains the JS code to sort the Timesheet Line Classification and second I have attached the "**Modiofied-Select Task Dlg.aspx**" which has that JS code  added in page which you can replace with  your actual page in PS 2010 environment

Note: Before updating the **Select Task Dlg.aspx **page please take a backup copy of this page. Also please implement this solution in Dev environment first and then move accordingly towards PROD deployment**.

**

