

/* MIS 325, SPR 2023, Assignment #4 - Meal Planner

Submission from: <Aldo Cruz-Ramos> */



Partial Class ClassMIS_Default
Inherits System.Web.UI.Page
Public Shared gdecTotalCalories As Decimal
Protected Sub cblTopping_SelectedIndexChanged(sender As Object, e As EventArgs)
Handles cblTopping.SelectedIndexChanged
Dim strToppingList As String = Nothing
Dim decToppingCalories As Decimal = 0
Dim decCalorie As Decimal = 0
If rblSaladSize.SelectedIndex > -1 Then
decCalorie += rblSaladSize.SelectedValue
Else
txtOutput.Text = "Please Select Salad Size"
Exit Sub
End If
If cblTopping.SelectedIndex > -1 Then
Dim toppings As ListItem
For Each toppings In cblTopping.Items
If toppings.Selected = True Then
strToppingList &= toppings.Text & ","
decToppingCalories += toppings.Value
End If
Next
End If
gdecTotalCalories = decToppingCalories + decCalorie
If (decCalorie + decToppingCalories) > 1500 Then
imgStop.Visible = True
LblStop.Visible = True
imgCheck.Visible = False
LblCheck.Visible = False
Else
imgStop.Visible = False
LblStop.Visible = False
imgCheck.Visible = True
LblCheck.Visible = True
End If
txtOutput.Text = "Calories for the " & rblSaladSize.SelectedItem.Text & " salad is " &
rblSaladSize.SelectedValue & vbNewLine & vbNewLine
txtOutput.Text &= "Calories for the " & strToppingList & " are " &
decToppingCalories.ToString("N2") & vbNewLine & vbNewLine
txtOutput.Text &= "Total Calories for the meal is: " & decToppingCalories + decCalorie &
vbNewLine & vbNewLine
txtOutput.Text &= "Total Calories Left: " & 2000 - (decToppingCalories + decCalorie) &
vbNewLine & vbNewLine
txtOutput.Text &= gdecTotalCalories
End Sub
Protected Sub cblExercise_SelectedIndexChanged(sender As Object, e As EventArgs)
Handles cblExercise.SelectedIndexChanged
Dim strExercises As String = Nothing
Dim decTotalBurned As Decimal = 0
If cblExercise.SelectedIndex > -1 Then
Dim Exercise As ListItem
For Each Exercise In cblExercise.Items
If Exercise.Selected = True Then
strExercises &= Exercise.Text & ","
decTotalBurned += Exercise.Value
End If
Next
End If
gdecTotalCalories -= decTotalBurned
txtSum.Text &= "Calories Burned for" & strExercises & " are: " & decTotalBurned &
vbNewLine & vbNewLine
End Sub
Protected Sub btnClear1_Click(sender As Object, e As EventArgs) Handles btnClear1.Click
Dim toppings As ListItem
For Each toppings In cblTopping.Items
toppings.Selected = False
Next
txtOutput.Text = Nothing
rblSaladSize.SelectedIndex = -1
gdecTotalCalories = 0
End Sub
Protected Sub btnClear2_Click(sender As Object, e As EventArgs) Handles btnClear2.Click
Dim Exercise As ListItem
For Each Exercise In cblExercise.Items
Exercise.Selected = False
Next
txtSum.Text = Nothing
rblDinner.Text = Nothing
gdecTotalCalories = 0
End Sub
Protected Sub btnCalculate_Click(sender As Object, e As EventArgs) Handles
btnCalculate.Click
Dim decdinnercalories As Decimal
If rblDinner.SelectedIndex > -1 Then
decdinnercalories += rblDinner.SelectedValue
Else
txtSum.Text = "Please Select Dinner"
Exit Sub
End If
gdecTotalCalories += decdinnercalories
If gdecTotalCalories > 2000 Then
imgStop.Visible = True
LblStop.Visible = True
imgCheck.Visible = False
LblCheck.Visible = False
Else
imgStop.Visible = False
LblStop.Visible = False
imgCheck.Visible = True
LblCheck.Visible = True
End If
txtSum.Text &= "Calories for " & rblDinner.SelectedItem.Text & " is " &
rblDinner.SelectedValue & " Calories " & vbNewLine & vbNewLine
txtSum.Text &= "Total Calories: " & gdecTotalCalories
End Sub
End Class