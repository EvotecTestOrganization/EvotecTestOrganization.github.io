# Protecting Baseline Fields in Proj

## Original Links

- [x] Original Technet URL [Protecting Baseline Fields in Proj](https://gallery.technet.microsoft.com/Protecting-Baseline-Fields-514f6345)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Protecting-Baseline-Fields-514f6345/description)
- [x] Download: [Download Link](Download\Plan.mpp)

## Output from Technet Gallery

Baseline refers to approved estimates. After you have set the baseline in Project, the approved estimates can be displayed by inserting the Baseline fields such as Baseline Start, Baseline Finish, Baseline Work, Baseline Cost and Baseline Duration. Depending on the view these columns are inserted, Project can either display the approved estimates of tasks, resources or assignments.

Project does not have feature to lock the approved estimates. You can change the baseline fields and Project doesn’t stop you from doing that. A better solution is capture the event and having VBA handlers for it.

If you user changes the task related fields, the event **ProjectBeforeTaskChange **is fired and writing an event handler to cancel the change if done on the Baseline fields will protect the Baseline Fields.

A code snippet can be seen below (full code in the download):

Visual Basic

```
Public WithEvents App As Application
Private Sub App_ProjectBeforeAssignmentChange(ByVal asg As Assignment, ByVal Field As PjAssignmentField, ByVal NewVal As Variant, Cancel As Boolean)
    Select Case Field
        Case pjAssignmentBaselineStart
            Cancel = True
        Case pjAssignmentBaselineFinish
            Cancel = True
        Case pjAssignmentBaselineWork
            Cancel = True
       Case pjAssignmentBaselineCost
            Cancel = True
    End Select
End Sub
Private Sub App_ProjectBeforeResourceChange(ByVal res As Resource, ByVal Field As PjField, ByVal NewVal As Variant, Cancel As Boolean)
    Select Case Field
```

 You can read more about the usage of these handlers and code in this blog: https://bsaiprasad.wordpress.com/2014/11/05/protecting-baseline-fields/

