SQL


/* MIS 325, SPR 2023, Assignment #7 - Updating Summary Data in Dimension Tables 

Submission from: <Aldo Cruz-Ramos> */



Imports System.Data
Imports System.Data.SqlClient
Partial Class ClassMIS_Default
Inherits System.Web.UI.Page
Public Shared con2 As New SqlConnection("Data Source
=cb-ot-devst06.ad.wsu.edu; initial catalog = MF31aldo.cruz; Persist Security Info =
True;User ID = aldo.cruz;Password=f926e8d7")
Public Shared gdaRentalReserve As New SqlDataAdapter("SELECT * FROM
VehicleRent", con2)
Public Shared gcbRentalCar As New SqlCommandBuilder(gdaRentalReserve)
Public Shared gdtRentalReserve, gdtRentItems As New DataTable
Public Shared gdaGet1Item As New SqlDataAdapter("SELECT * FROM VehicleRent
WHERE ReservationID = @p1", con2)
Public Shared gdt1Item As New DataTable
Public Shared daSummaryDepartment As New SqlDataAdapter("SELECT * From
SummaryDepartment", con2)
Public Shared daSummaryVehicleID As New SqlDataAdapter("SELECT * From
SummaryVehicleID", con2)
Public Shared daSummaryVehicleType As New SqlDataAdapter("SELECT * From
SummaryVehicleType", con2)
Public Shared daSummaryGrandTotal As New SqlDataAdapter("SELECT * From
SummaryGrandTotal", con2)
Public Shared dtSummaryDepartment As New DataTable
Public Shared dtSummaryVehicleID As New DataTable
Public Shared dtSummaryVehicleType As New DataTable
Public Shared dtSummaryGrandTotal As New DataTable
Private Sub ClassMIS_Default_Init(sender As Object, e As EventArgs) Handles
Me.Init
gdaRentalReserve.FillSchema(gdtRentalReserve, SchemaType.Source)
If gdtRentItems.Rows.Count > 0 Then
gdtRentItems.Rows.Clear()
End If
Try
gdaRentalReserve.Fill(gdtRentItems)
With gvRent
.DataSource = gdtRentItems
.DataBind()
End With
With ddlItem
.DataSource = gdtRentItems
.DataTextField = "ReservationID"
.DataValueField = "ReservationID"
.DataBind()
End With
Catch ex As Exception
Response.Write(ex.Message)
End Try
Try
If dtSummaryVehicleID.Rows.Count > 0 Then
dtSummaryVehicleID.Rows.Clear()
daSummaryVehicleID.Fill(dtSummaryVehicleID)
gvSummaryID.DataSource = dtSummaryVehicleID
gvSummaryID.DataBind()
With rblVehicleID
.DataSource = dtSummaryVehicleID
.DataTextField = "VehicleID"
.DataValueField = "VehicleID"
.DataBind()
End With
Catch ex As Exception
Response.Write(ex.Message)
End Try
Try
If dtSummaryVehicleType.Rows.Count > 0 Then
dtSummaryVehicleType.Rows.Clear()
daSummaryVehicleType.Fill(dtSummaryVehicleType)
gvSummaryType.DataSource = dtSummaryVehicleType
gvSummaryType.DataBind()
With rblVehicleType
.DataSource = dtSummaryVehicleType
.DataTextField = "VehicleName"
.DataValueField = "VehicleName"
.DataBind()
End With
Catch ex As Exception
Response.Write(ex.Message)
End Try
Try
If dtSummaryDepartment.Rows.Count > 0 Then
dtSummaryDepartment.Rows.Clear()
daSummaryDepartment.Fill(dtSummaryDepartment)
gvSummaryDepartment.DataSource = dtSummaryDepartment
gvSummaryDepartment.DataBind()
With ddlDepartment
.DataSource = dtSummaryDepartment
.DataTextField = "DepartmentName"
.DataValueField = "DepartmentName"
.DataBind()
End With
Catch ex As Exception
Response.Write(ex.Message)
End Try
Try
If dtSummaryGrandTotal.Rows.Count > 0 Then
dtSummaryGrandTotal.Rows.Clear()daSummaryGrandTotal.Fill(dtSummaryGrandTotal)
gvGrandTotal.DataSource = dtSummaryGrandTotal
gvGrandTotal.DataBind()
Catch ex As Exception
Response.Write(ex.Message)
End Try
End Sub
Protected Sub rblEdit_SelectedIndexChanged(sender As Object, e As EventArgs)
Handles rblEdit.SelectedIndexChanged
If rblEdit.SelectedIndex = 1 Then
ddlItem.Visible = True
Else
ddlItem.Visible = False
End If
End Sub
Protected Sub btnReserve_Click(sender As Object, e As EventArgs) Handles
btnReserve.Click
If rblVehicleType.SelectedIndex = -1 OrElse IsNothing(txtCheckIn.Text) = True
OrElse ddlDepartment.SelectedIndex = -1 OrElse IsNothing(txtMillage.Text) OrElse
rblDamages.SelectedIndex = -1 Then
Response.Write("please select or enter something for every box")
End If
Dim dr As DataRow = gdtRentalReserve.NewRow
Dim ts As TimeSpan
Dim TimeCharge As Decimal
Dim VehicleCost As Decimal
Dim MillageCost As Decimal
Dim DamageCost As Decimal
Dim TotalDays As Decimal
Select Case rblVehicleType.SelectedIndex > -1
Case rblVehicleType.SelectedIndex = 0
VehicleCost = 30
Case rblVehicleType.SelectedIndex = 1
VehicleCost = 70
Case rblVehicleType.SelectedIndex = 2
VehicleCost = 80
End Select
Select Case rblDamages.SelectedIndex > -1
Case rblDamages.SelectedIndex = 0
DamageCost = 0
Case rblDamages.SelectedIndex = 1
DamageCost = 100
Case rblDamages.SelectedIndex = 2
DamageCost = 500
End Select
ts = DateTime.Parse(txtCheckIn.Text) - DateTime.Parse(txtCheckOut.Text)
MillageCost = Convert.ToDecimal(txtMillage.Text) * 0.25
TotalDays = ts.TotalDays
TimeCharge = ts.TotalDays * VehicleCost
dr("Vehicle") = rblVehicleType.SelectedItem.Text
dr("Department") = ddlDepartment.SelectedItem.Text
dr("CheckOutDate") = Date.Parse(txtCheckOut.Text)
dr("CheckInDate") = Date.Parse(txtCheckIn.Text)
dr("MilesDriven") = Convert.ToDecimal(txtMillage.Text)
dr("Damages") = rblDamages.SelectedItem.Text & " $" & DamageCost
dr("DailyCost") = VehicleCost
dr("TotalCost") = DamageCost + MillageCost + TimeCharge
gdtRentalReserve.Rows.Add(dr)
Try
gdaRentalReserve.Update(gdtRentalReserve)
gdtRentalReserve.Rows.Clear()
gdaRentalReserve.Fill(gdtRentalReserve)
gvRent.DataSource = gdtRentalReserve
gvRent.DataBind()
Catch ex As Exception
Response.Write(ex.Message)
End Try
Dim cmdUpdateSumVehicleType As New SqlCommand("UPDATE
SummaryVehicleType SET NumberDaysRented += @p2, NumberMiles += @p3,
NumberTimesRented += 1, TotalRevenue += @p4, TotalDamages += @p5 WHERE
VehicleName = @p6", con2)
With cmdUpdateSumVehicleType.Parameters
.Clear()
.AddWithValue("@p2", TotalDays)
.AddWithValue("@p3", Convert.ToDecimal(txtMillage.Text))
.AddWithValue("@p4", DamageCost + MillageCost + TimeCharge)
.AddWithValue("@p5", DamageCost)
.AddWithValue("@p6", rblVehicleType.SelectedValue)
End With
Dim cmdUpdateSumVehicleID As New SqlCommand("UPDATE
SummaryVehicleID SET NumberDaysRented += @p7, NumberMiles += @p8,
NumberTimesRented += 1, TotalRevenue += @p9, TotalDamages += @p10 WHERE
VehicleID = @p11", con2)
With cmdUpdateSumVehicleID.Parameters
.Clear()
.AddWithValue("@p7", TotalDays)
.AddWithValue("@p8", Convert.ToDecimal(txtMillage.Text))
.AddWithValue("@p9", DamageCost + MillageCost + TimeCharge)
.AddWithValue("@p10", DamageCost)
.AddWithValue("@p11", rblVehicleID.SelectedValue)
End With
Dim cmdUpdateSumDepartment As New SqlCommand("UPDATE
SummaryDepartment SET NumberDaysRented += @p12, NumberMiles += @p13,
NumberTimesRented += 1, TotalRevenue += @p14, TotalDamages += @p15 WHERE
DepartmentName = @p16", con2)
With cmdUpdateSumDepartment.Parameters
.Clear()
.AddWithValue("@p12", TotalDays)
.AddWithValue("@p13", Convert.ToDecimal(txtMillage.Text))
.AddWithValue("@p14", DamageCost + MillageCost + TimeCharge)
.AddWithValue("@p15", DamageCost)
.AddWithValue("@p16", ddlDepartment.SelectedValue)
End With
Dim cmdUpdateSumGrandTotal As New SqlCommand("UPDATE
SummaryGrandTotal SET NumberDayRented += @p17, NumberMiles += @p18,
NumberTimesRented += 1, TotalRevenue += @p19, TotalDamages += @p20", con2)
With cmdUpdateSumGrandTotal.Parameters
.Clear()
.AddWithValue("@p17", TotalDays)
.AddWithValue("@p18", Convert.ToDecimal(txtMillage.Text))
.AddWithValue("@p19", DamageCost + MillageCost + TimeCharge)
.AddWithValue("@p20", DamageCost)
End With
Try
If con2.State = ConnectionState.Closed Then con2.Open()
cmdUpdateSumDepartment.ExecuteNonQuery()
cmdUpdateSumGrandTotal.ExecuteNonQuery()
cmdUpdateSumVehicleID.ExecuteNonQuery()
cmdUpdateSumVehicleType.ExecuteNonQuery()
If dtSummaryDepartment.Rows.Count > 0 Then
dtSummaryDepartment.Rows.Clear()
daSummaryDepartment.Fill(dtSummaryDepartment)
gvSummaryDepartment.DataSource = dtSummaryDepartment
gvSummaryDepartment.DataBind()
If dtSummaryVehicleID.Rows.Count > 0 Then
dtSummaryVehicleID.Rows.Clear()
daSummaryVehicleID.Fill(dtSummaryVehicleID)
gvSummaryID.DataSource = dtSummaryVehicleID
gvSummaryID.DataBind()
If dtSummaryVehicleType.Rows.Count > 0 Then
dtSummaryVehicleType.Rows.Clear()
daSummaryVehicleType.Fill(dtSummaryVehicleType)
gvSummaryType.DataSource = dtSummaryVehicleType
gvSummaryType.DataBind()
If dtSummaryGrandTotal.Rows.Count > 0 Then
dtSummaryGrandTotal.Rows.Clear()
daSummaryGrandTotal.Fill(dtSummaryGrandTotal)
gvGrandTotal.DataSource = dtSummaryGrandTotal
gvGrandTotal.DataBind()
Catch ex As Exception
Response.Write(ex.Message)
End Try
End Sub
Protected Sub btnClear_Click(sender As Object, e As EventArgs) Handles
btnClear.Click
rblVehicleType.SelectedIndex = -1
rblDamages.SelectedIndex = -1
ddlDepartment.SelectedIndex = -1
txtCheckOut.Text = Nothing
txtCheckIn.Text = Nothing
txtMillage.Text = Nothing
rblEdit.SelectedIndex = 0
End Sub
Protected Sub ddlItem_SelectedIndexChanged(sender As Object, e As EventArgs)
Handles ddlItem.SelectedIndexChanged
Dim CheckOutDate As DateTime
Dim CheckInDate As DateTime
If gdt1Item.Rows.Count > 0 Then
gdt1Item.Rows.Clear()
End If
With gdaGet1Item.SelectCommand.Parameters
.Clear()
.AddWithValue("@p1", ddlItem.SelectedValue)
End With
Try
gdaGet1Item.Fill(gdt1Item)
With gvRent
.DataSource = gdt1Item
.DataBind()
End With
With gdt1Item.Rows(0)
rblVehicleType.SelectedValue = .Item("Vehicle")
ddlDepartment.SelectedValue = .Item("Department")
rblDamages.SelectedValue = .Item("Damages")
CheckOutDate = .Item("CheckOutDate")
txtCheckOut.Text = CheckOutDate.ToString("yyyy-MM-dd")
CheckInDate = .Item("CheckInDate")
txtCheckIn.Text = CheckInDate.ToString("yyyy-MM-dd")
txtMillage.Text = .Item("MilesDriven")
End With
Catch ex As Exception
Response.Write(ex.Message)
End Try
End Sub
Protected Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles
btnUpdate.Click
Dim ts As TimeSpan
Dim TimeCharge As Decimal
Dim VehicleCost As Decimal
Dim MillageCost As Decimal
Dim DamageCost As Decimal
Dim totaldays As Decimal
Select Case rblVehicleType.SelectedIndex > -1
Case rblVehicleType.SelectedIndex = 0
VehicleCost = 30
Case rblVehicleType.SelectedIndex = 1
VehicleCost = 70
Case rblVehicleType.SelectedIndex = 2
VehicleCost = 80
End Select
Select Case rblDamages.SelectedIndex > -1
Case rblDamages.SelectedIndex = 0
DamageCost = 0
Case rblDamages.SelectedIndex = 1
DamageCost = 100
Case rblDamages.SelectedIndex = 2
DamageCost = 500
End Select
ts = DateTime.Parse(txtCheckIn.Text) - DateTime.Parse(txtCheckOut.Text)
MillageCost = Convert.ToDecimal(txtMillage.Text) * 0.25
TotalDays = ts.TotalDays
TimeCharge = ts.TotalDays * VehicleCost
With gdt1Item.Rows(0)
.Item("Vehicle") = rblVehicleType.SelectedValue
.Item("Department") = ddlDepartment.SelectedValue
.Item("CheckOutDate") = DateTime.Parse(txtCheckOut.Text)
.Item("CheckInDate") = DateTime.Parse(txtCheckIn.Text)
.Item("MilesDriven") = CDec(txtMillage.Text)
.Item("Damages") = rblDamages.SelectedValue
.Item("DailyCost") = VehicleCost
.Item("TotalCost") = DamageCost + MillageCost + TimeCharge
End With
Try
gdaRentalReserve.Update(gdt1Item)
If gdtRentItems.Rows.Count > 0 Then
gdtRentItems.Rows.Clear()
End If
gdaRentalReserve.Fill(gdtRentItems)
With gvRent
.DataSource = gdtRentItems
.DataBind()
End With
Catch ex As Exception
Response.Write(ex.Message)
End Try
End Sub
Protected Sub btnDelete_Click(sender As Object, e As EventArgs) Handles
btnDelete.Click
Dim DeleteRow As New SqlCommand("DELETE FROM VehicleRent WHERE
ReservationID = @p1", con2)
If ddlItem.SelectedIndex = -1 Then
Response.Write("No reservation selected for erasure")
Exit Sub
End If
With DeleteRow.Parameters
.Clear()
.AddWithValue("@p1", ddlItem.SelectedValue)
End With
Try
If con2.State = ConnectionState.Closed Then con2.Open()
DeleteRow.ExecuteNonQuery()
con2.Close()
If gdtRentItems.Rows.Count > 0 Then
gdtRentItems.Rows.Clear()
End If
gdaRentalReserve.Fill(gdtRentItems)
With gvRent
.DataSource = gdtRentItems
.DataBind()
End With
Catch ex As Exception
Response.Write(ex.Message)
End Try
End Sub
Protected Sub LinkAdd_Click(sender As Object, e As EventArgs) Handles
LinkAdd.Click
MultiView1.ActiveViewIndex = 0
End Sub
Protected Sub LinkSum_Click(sender As Object, e As EventArgs) Handles
LinkSum.Click
MultiView1.ActiveViewIndex = 1
End Sub
End Class

