<%@ Page Language="C#"  MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="UpdateWorkoutType.aspx.cs" Inherits="UpdateeWorkoutType" %>

<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>

<%--<html xmlns="http://www.w3.org/1999/xhtml">--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<%--<head runat="server">--%>
    <title></title>
    <style type="text/css">
        .style1
        {
            font-size: xx-large;
        }
        .style2
        {
            text-align: center;
        }
    </style>
</asp:Content>
<%--</head>--%>
<%--<body>
    <form id="form1" runat="server">
    <div>--%>

        <asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">

        <div class="clear hideSkiplink">
            <asp:Menu ID="NavigationMenu" runat="server" CssClass="menu" EnableViewState="false" IncludeStyleBlock="false" Orientation="Horizontal">
                <Items>
                    <asp:MenuItem NavigateUrl="~/HomePage.aspx" Text="Home"/>
                    <asp:MenuItem NavigateUrl="~/Training_Code/TrainingReport.aspx" Text="Training Report"/>
                    <asp:MenuItem NavigateUrl="~/Training_Code/EnterLog.aspx" Text="Training Updates"/>
                    <asp:MenuItem NavigateUrl="~/Training_Code/UpdateWorkoutType.aspx" Text="Add New Workout Type"/>
                </Items>
            </asp:Menu>
        </div>
</asp:Content>


    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="style2">
            <span class="style1">Add New Workout Type</span>
        </div>
        <p align="center">
            <asp:Label ID="lblUpdateStatus" runat="server" Text=" " ForeColor="#0066CC">&nbsp;</asp:Label>
        </p>
    <p>
    Enter New Workout Type:     
    <asp:TextBox ID="txtNewWorkoutType" runat="server" Width="206px"></asp:TextBox>
    <asp:CustomValidator ID="CustomValidator1" runat="server" 
        ErrorMessage="New Workout Type already exists!" ControlToValidate="txtNewWorkoutType" 
        onservervalidate="CustomValidator1_ServerValidate">
    </asp:CustomValidator>
    </p>
    <p>
    <p>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnUpdate" runat="server" Text="Add Workout Type" 
            onclick="btnUpdate_Click" />

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:TrainingConnectionString %>" 
            DeleteCommand="DELETE FROM [WorkoutType] WHERE [UserEmail] = @UserEmail AND [TypeOfWorkout] = @TypeOfWorkout" 
            InsertCommand="INSERT INTO [WorkoutType] ([UserEmail], [TypeOfWorkout]) VALUES (@UserEmail, @TypeOfWorkout)"            
            
            SelectCommand="SELECT [UserEmail], [TypeOfWorkout] FROM [WorkoutType] WHERE (([TypeOfWorkout] = @TypeOfWorkout) AND ([UserEmail] = @UserEmail))">
            <DeleteParameters>
                <asp:Parameter Name="UserEmail" Type="String" />
                <asp:Parameter Name="TypeOfWorkout" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="UserEmail" Type="String" />
                <asp:Parameter Name="TypeOfWorkout" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="txtNewWorkoutType" Name="TypeOfWorkout" 
                    PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="lblUserIndicator" Name="UserEmail" 
                    PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:TrainingConnectionString %>" 
            DeleteCommand="DELETE FROM [WorkoutType] WHERE [UserEmail] = @UserEmail AND [TypeOfWorkout] = @TypeOfWorkout" 
            InsertCommand="INSERT INTO [WorkoutType] ([UserEmail], [TypeOfWorkout]) VALUES (@UserEmail, @TypeOfWorkout)" 
            SelectCommand="SELECT [UserEmail], [TypeOfWorkout] FROM [WorkoutType] WHERE (([TypeOfWorkout] = @TypeOfWorkout2) AND ([UserEmail] = @UserEmail))">
            <DeleteParameters>
                <asp:Parameter Name="UserEmail" Type="String" />
                <asp:Parameter Name="TypeOfWorkout" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="UserEmail" Type="String" />
                <asp:Parameter Name="TypeOfWorkout" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="txtNewWorkoutType" Name="TypeOfWorkout2" 
                    PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="lblUserIndicator" Name="UserEmail" 
                    PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

    </p>
<%--    <br />
    <br />
    <asp:Button ID="btnEnterData" runat="server" 
    Text="Enter Daily Training Information" onclick="btnEnterData_Click" />--%>
        <asp:Label ID="lblUserIndicator" runat="server" Text="Label" Visible="False"></asp:Label>
    </p>
    </asp:Content>
<%--    </div>--%>
<%--    </form>
</body>
</html>--%>
