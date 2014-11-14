<%@ Page Language="C#"  MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="EnterLog.aspx.cs" Inherits="EnterLog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>EnterLog</title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 398px;
        }
        .style3
        {
            width: 319px;
        }
        .style4
        {
            font-size: xx-large;
            text-align: center;
        }
        .style5
        {
            height: 23px;
        }
        .style9
        {
            height: 23px;
            width: 319px;
        }
        .style11
        {
            width: 174px;
        }
        .style12
        {
            height: 23px;
            width: 174px;
        }
        .style16
        {
            width: 174px;
            height: 2px;
        }
        .style17
        {
            width: 319px;
            height: 2px;
        }
        .style18
        {
            height: 2px;
        }
        .style19
        {
            width: 174px;
            height: 3px;
        }
        .style20
        {
            width: 319px;
            height: 3px;
        }
        .style21
        {
            height: 3px;
        }
        .style28
        {
            height: 24px;
            width: 174px;
        }
        .style29
        {
            height: 24px;
            width: 319px;
        }
        .style30
        {
            height: 24px;
        }
        .style31
        {
            width: 174px;
            height: 7px;
        }
        .style32
        {
            width: 319px;
            height: 7px;
        }
        .style33
        {
            height: 7px;
        }
        .style40
        {
            width: 174px;
            height: 5px;
        }
        .style41
        {
            width: 319px;
            height: 5px;
        }
        .style42
        {
            height: 5px;
        }
        .style46
        {
            width: 174px;
            height: 30px;
        }
        .style47
        {
            width: 319px;
            height: 30px;
        }
        .style48
        {
            height: 30px;
        }
        .style49
        {
            height: 8px;
            width: 174px;
        }
        .style50
        {
            height: 8px;
            width: 319px;
        }
        .style51
        {
            height: 8px;
        }
        .style52
        {
            width: 174px;
            height: 37px;
        }
        .style53
        {
            width: 319px;
            height: 37px;
        }
        .style54
        {
            height: 37px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
        <div class="clear hideSkiplink">
            <asp:Menu ID="NavigationMenu" runat="server" CssClass="menu" EnableViewState="false" IncludeStyleBlock="false" Orientation="Horizontal">
                <Items>
                    <asp:MenuItem NavigateUrl="~/HomePage.aspx" Text="Home"/>
                    <asp:MenuItem NavigateUrl="~/Training_Code/TrainingReport.aspx" Text="Training Report"/>
                    <asp:MenuItem NavigateUrl="~/Training_Code/EnterLog.aspx" Text="Training Updates"/>
                    <asp:MenuItem NavigateUrl="~/Training_Code/UpdateWorkoutType.aspx" Text="Add New Workout Type"/>
                    <asp:MenuItem NavigateUrl="https://github.com/mj9119/TrainingLog" target="_blank" Text="Source Code on GitHub"/>
                </Items>
            </asp:Menu>
        </div>
</asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <table class="style1">
            <tr>
                <td class="style4" colspan="3">
                    Enter Daily Training Information</td>
                <asp:Label ID="lblLoggedInUser" runat="server" Text="Label" Visible="False"></asp:Label>
            </tr>
            <tr>
                <td class="style4" colspan="3">
                    <asp:Label ID="lblTrainingInfoUpdate" runat="server" ForeColor="#0066CC" 
                        style="font-size: large"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="style12"> 
                <!-- <p style="width: 317px"> -->
                    Date:
                    <asp:TextBox ID="txtEntryDate" runat="server" Width="95px"></asp:TextBox>&nbsp;
                    <asp:ImageButton ID="ibtnCalendar" runat="server" 
                        ImageUrl="~/Images/Calendar.bmp" onclick="ibtnCalendar_Click" CausesValidation="False" />
                <!-- </p>  -->
                    <asp:Calendar ID="clnDate" runat="server" Visible="False" 
                        onselectionchanged="clnDate_SelectionChanged"></asp:Calendar>
&nbsp;</td>
                <td class="style9" align="top" > 
                    <asp:Label ID="lblDateInfo" runat="server" 
                        ForeColor="#0066CC"></asp:Label>
                    <br />
                    <asp:RequiredFieldValidator ID="rfvDate" runat="server" 
                        ControlToValidate="txtEntryDate" 
                        ErrorMessage=" Date is Required.  Must be in MM/DD/YYYY format" 
                        ForeColor="#CC3300"></asp:RequiredFieldValidator>
                    <br />
                    <asp:CompareValidator ID="cvEntryDate" runat="server" 
                        ControlToValidate="txtEntryDate" ErrorMessage="You must enter  a valid date" 
                        ForeColor="#CC3300" Operator="DataTypeCheck" Type="Date"></asp:CompareValidator>
                    </td>
                <td class="style5">
                </td>
            </tr>
            <tr>
                <td class="style28">
                    Workout Type:<br />
                    <asp:DropDownList ID="ddlWorkoutTypes" runat="server" CausesValidation="True" 
                        DataSourceID="ObjectDataSource1" DataTextField="TypeOfWorkout" 
                        DataValueField="TypeOfWorkout">
                        <asp:ListItem>Select Workout Type</asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:TrainingConnectionString %>" 
                        SelectCommand="SELECT [TypeOfWorkout] FROM [WorkoutType] WHERE ([UserEmail] = @UserEmail)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="jayb@mymail.com" Name="UserEmail" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
                        TypeName="WorkoutObjectDB" OldValuesParameterFormatString="original_{0}" 
                        SelectMethod="GetWorkoutTypes" DataObjectTypeName="DailyWorkout" 
                        InsertMethod="InsertWorkoutDay">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblCurrUser" DefaultValue="" Name="userEmail" 
                                PropertyName="Text" Type="String" />
                        </SelectParameters>
                    </asp:ObjectDataSource>

                </td>
                <td class="style29">
                &nbsp;<asp:Button ID="btnEnterDailyWorkout" runat="server" onclick="Button1_Click" 
                        Text="Submit Daily Training Information" Width="225px" />
                    <br />
                    <asp:RequiredFieldValidator ID="rfvSelectWorkoutType" runat="server" 
                        ControlToValidate="ddlWorkoutTypes" 
                        ErrorMessage="You must Select a Workout Type from the DropDown List" ForeColor="#CC3300" 
                        InitialValue="Select Workout Type" Display="Dynamic" 
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                </td>
                <td class="style30">
                    <asp:Button ID="btnClear" runat="server" Text="Clear the Screen" Width="225px" 
                        CausesValidation="False" onclick="btnClear_Click" />
                    </td>
            </tr>
            <tr>
                <td class="style40">
                    </td>
                <td class="style41">
                    </td>
                <td class="style42">
                    </td>
            </tr>
            <tr>
                <td class="style49">
                    Total Miles Run:
                    <asp:TextBox ID="txtTotalMilesRun" runat="server"></asp:TextBox>
                </td>
                <td class="style50">
                    <br />
                    <br />
                    <asp:Label ID="lblTotalMilesRun" runat="server" 
                        Text="Example: 4.5" Font-Italic="True"></asp:Label>
                    <br />
                    <asp:CompareValidator ID="CompareValidator2" runat="server" 
                        ControlToValidate="txtTotalMilesRun" 
                        ErrorMessage="Total Miles must be a number GE 0" ForeColor="#CC3300" 
                        Operator="GreaterThanEqual" Type="Double" ValueToCompare="0"></asp:CompareValidator>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="txtTotalMilesRun" 
                        ErrorMessage="Total Miles Run cannot be blank" ForeColor="#CC3300"></asp:RequiredFieldValidator>
                </td>
                <td class="style51">
                    </td>
            </tr>
            <tr>
                <td class="style19">
                    </td>
                <td class="style20">
                    </td>
                <td class="style21">
                    </td>
            </tr>
            <tr>
                <td class="style31">
                    Quality Miles Run:
                    <asp:TextBox ID="txtQualityMilesRun" runat="server"></asp:TextBox>
                </td>
                <td class="style32">
                    <br />
                    <br />
                    <asp:Label ID="lblQualityMilesRun" runat="server" 
                        Text="Example: 1.75" Font-Italic="True"></asp:Label>
                    <br />
                    <asp:CompareValidator ID="CompareValidator1" runat="server" 
                        ControlToCompare="txtTotalMilesRun" ControlToValidate="txtQualityMilesRun" 
                        ErrorMessage="Quality Miles must be a number LE Total Miles" 
                        Operator="LessThanEqual" Type="Double" ForeColor="#CC3300"></asp:CompareValidator>
                    <br />
                    <asp:CompareValidator ID="CompareValidator3" runat="server" 
                        ControlToValidate="txtQualityMilesRun" 
                        ErrorMessage="Quality Miles must be a number GE 0" ForeColor="#CC3300" 
                        Operator="GreaterThanEqual" Type="Double" ValueToCompare="0"></asp:CompareValidator>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="txtQualityMilesRun" 
                        ErrorMessage="Quality Miles Run cannot be blank" ForeColor="#CC3300"></asp:RequiredFieldValidator>
                </td>
                <td class="style33">
                    </td>
            </tr>
            <tr>
                <td class="style16">
                    </td>
                <td class="style17">
                    </td>
                <td class="style18">
                    </td>
            </tr>
            <tr>
                <td class="style46">
                    Time On Bike:
                    <br />
                    Hrs:
                    <asp:DropDownList ID="ddlHrsBike" runat="server">
                    </asp:DropDownList>
                    &nbsp;Mins:
                    <asp:DropDownList ID="ddlMinsBike" runat="server">
                    </asp:DropDownList>
                </td>
                <td class="style47">
                    <asp:Label ID="lblTimeOnBike" runat="server" ForeColor="#0066CC"></asp:Label>
                </td>
                <td class="style48">
                    </td>
            </tr>
            <tr>
                <td class="style52">
                    Time Swimming:
                    <br />
                    Hrs:
                    <asp:DropDownList ID="ddlHrsSwim" runat="server">
                    </asp:DropDownList>
                    &nbsp;Mins:
                    <asp:DropDownList ID="ddlMinsSwim" runat="server">
                    </asp:DropDownList>
                </td>
                <td class="style53">
                    <asp:Label ID="lblTimeInSwim" runat="server" ForeColor="#0066CC"></asp:Label>
                    <br />
                </td>
                <td class="style54">
                    </td>
            </tr>
            <tr>
                <td class="style31">
                    </td>
                <td class="style32">
                    <asp:Label ID="lblSelectWorkoutType" runat="server" 
                        Text="Select Type of Workout Or Add Workout" Font-Italic="True" 
                        Visible="False"></asp:Label>
                </td>
                <td class="style33">
                    </td>
            </tr>
            <tr>
                <td class="style2" colspan="2">
                    Overall
                    Workout Description:<asp:TextBox ID="txtWorkoutDesc" runat="server" 
                        MaxLength="20" Rows="10" TextMode="MultiLine" Width="434px"></asp:TextBox>
                    <asp:Label ID="Label1" runat="server" ForeColor="#0066CC"></asp:Label>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style11">
                    &nbsp;</td>
                <td class="style3">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;

                <asp:Button 
                        ID="btnAddWorkoutType" runat="server" Text="Add New Workout Type" 
                        Width="162px" CausesValidation="False" onclick="btnAddWorkoutType_Click" 
                        Visible="False" />

                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style11">
                    &nbsp;</td>
                <td class="style3">
                    <%--<head runat="server">--%>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style11">
                    &nbsp;</td>
                <td class="style3">
                    <asp:Label ID="lblCurrUser" runat="server" Visible="False"></asp:Label>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
        </table>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:TrainingConnectionString %>" 
            DeleteCommand="DELETE FROM [TrainingLog] WHERE [UserEmail] = @UserEmail AND [CalendarDate] = @CalendarDate" 
            InsertCommand="INSERT INTO [TrainingLog] ([UserEmail], [CalendarDate], [TypeOfWorkout], [TotalMilesRun], [QualityMilesRun], [TotalMinsBike], [TotalMinsSwim], [WorkoutDescription]) VALUES (@UserEmail, @CalendarDate, @TypeOfWorkout, @TotalMilesRun, @QualityMilesRun, @TotalMinsBike, @TotalMinsSwim, @WorkoutDescription)" 
            SelectCommand="SELECT [UserEmail], [CalendarDate], [TypeOfWorkout], [TotalMilesRun], [QualityMilesRun], [TotalMinsBike], [TotalMinsSwim], [WorkoutDescription] FROM [TrainingLog] WHERE (([CalendarDate] = @CalendarDate) AND ([TypeOfWorkout] = @TypeOfWorkout) AND ([TotalMilesRun] = @TotalMilesRun) AND ([QualityMilesRun] = @QualityMilesRun) AND ([TotalMinsBike] = @TotalMinsBike) AND ([TotalMinsSwim] = @TotalMinsSwim) AND ([WorkoutDescription] = @WorkoutDescription) AND ([UserEmail] = @UserEmail))" 
            UpdateCommand="UPDATE [TrainingLog] SET [TypeOfWorkout] = @TypeOfWorkout, [TotalMilesRun] = @TotalMilesRun, [QualityMilesRun] = @QualityMilesRun, [TotalMinsBike] = @TotalMinsBike, [TotalMinsSwim] = @TotalMinsSwim, [WorkoutDescription] = @WorkoutDescription WHERE [UserEmail] = @UserEmail AND [CalendarDate] = @CalendarDate">
            <DeleteParameters>
                <asp:Parameter Name="UserEmail" Type="String" />
                <asp:Parameter DbType="Date" Name="CalendarDate" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter DefaultValue="jayb@mymail.com" Name="UserEmail" Type="String" />
                <asp:ControlParameter ControlID="txtEntryDate" DbType="Date" 
                    Name="CalendarDate" PropertyName="Text" />

                <asp:ControlParameter ControlID="ddlWorkoutTypes" Name="TypeOfWorkout" 
                    PropertyName="SelectedValue" Type="String" />
                <asp:ControlParameter ControlID="txtTotalMilesRun" Name="TotalMilesRun" 
                    PropertyName="Text" Type="Decimal" DefaultValue="0" />
                <asp:ControlParameter ControlID="txtQualityMilesRun" Name="QualityMilesRun" 
                    PropertyName="Text" Type="Decimal" DefaultValue="0" />

                <asp:ControlParameter ControlID="ddlMinsBike" Name="TotalMinsBike" 
                PropertyName="SelectedValue" Type="Int16" />

                <asp:ControlParameter ControlID="ddlMinsSwim" Name="TotalMinsSwim" 
                PropertyName="SelectedValue" Type="Int16" />

<%--                <asp:FormParameter FormField="ddlMinsSwim.SelectedValue + (ddlHrsSwim.SelectedValue * 60)" 
                    Name="TotalMinsSwim" Type="Int16" />--%>

                <asp:ControlParameter ControlID="txtWorkoutDesc" Name="WorkoutDescription" 
                    PropertyName="Text" Type="String" DefaultValue=" " />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="txtEntryDate" DbType="Date" 
                    Name="CalendarDate" PropertyName="Text" />
                <asp:ControlParameter ControlID="ddlWorkoutTypes" Name="TypeOfWorkout" 
                    PropertyName="SelectedValue" Type="String" />
                <asp:ControlParameter ControlID="txtTotalMilesRun" Name="TotalMilesRun" 
                    PropertyName="Text" Type="Decimal" />
                <asp:ControlParameter ControlID="txtQualityMilesRun" Name="QualityMilesRun" 
                    PropertyName="Text" Type="Decimal" />
                <asp:FormParameter FormField="ddlMinsBike.SelectedValue + (ddlHrsBike.SelectedValue * 60)" 
                    Name="TotalMinsBike" Type="Int16" />
                <asp:FormParameter FormField="ddlMinsSwim.SelectedValue + (ddlHrsSwim.SelectedValue * 60)" 
                    Name="TotalMinsSwim" Type="Int16" />
                <asp:ControlParameter ControlID="txtWorkoutDesc" Name="WorkoutDescription" 
                    PropertyName="Text" Type="String" />
                <asp:Parameter DefaultValue="jayb@mymail.com" Name="UserEmail" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="TypeOfWorkout" Type="String" />
                <asp:Parameter Name="TotalMilesRun" Type="Decimal" />
                <asp:Parameter Name="QualityMilesRun" Type="Decimal" />
                <asp:Parameter Name="TotalMinsBike" Type="Int16" />
                <asp:Parameter Name="TotalMinsSwim" Type="Int16" />
                <asp:Parameter Name="WorkoutDescription" Type="String" />
                <asp:Parameter Name="UserEmail" Type="String" />
                <asp:Parameter DbType="Date" Name="CalendarDate" />
            </UpdateParameters>
        </asp:SqlDataSource>
 
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
            ConnectionString="<%$ ConnectionStrings:TrainingConnectionString %>" 
            DeleteCommand="DELETE FROM [TrainingLog] WHERE [UserEmail] = @original_UserEmail AND [CalendarDate] = @original_CalendarDate" 
            InsertCommand="INSERT INTO [TrainingLog] ([UserEmail], [CalendarDate], [TypeOfWorkout], [TotalMilesRun], [QualityMilesRun], [TotalMinsBike], [TotalMinsSwim], [WorkoutDescription]) VALUES (@UserEmail, @CalendarDate, @TypeOfWorkout, @TotalMilesRun, @QualityMilesRun, @TotalMinsBike, @TotalMinsSwim, @WorkoutDescription)" 
            OldValuesParameterFormatString="original_{0}" 
            SelectCommand="SELECT * FROM [TrainingLog]" 
            
            
            UpdateCommand="UPDATE [TrainingLog] SET [TypeOfWorkout] = @TypeOfWorkout, [TotalMilesRun] = @TotalMilesRun, [QualityMilesRun] = @QualityMilesRun, [TotalMinsBike] = @TotalMinsBike, [TotalMinsSwim] = @TotalMinsSwim, [WorkoutDescription] = @WorkoutDescription WHERE [UserEmail] = @original_UserEmail AND [CalendarDate] = @original_CalendarDate">
            <DeleteParameters>
                <asp:Parameter Name="original_UserEmail" Type="String" />
                <asp:Parameter DbType="Date" Name="original_CalendarDate" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="UserEmail" Type="String" />
                <asp:Parameter DbType="Date" Name="CalendarDate" />
                <asp:Parameter Name="TypeOfWorkout" Type="String" />
                <asp:Parameter Name="TotalMilesRun" Type="Decimal" />
                <asp:Parameter Name="QualityMilesRun" Type="Decimal" />
                <asp:Parameter Name="TotalMinsBike" Type="Int16" />
                <asp:Parameter Name="TotalMinsSwim" Type="Int16" />
                <asp:Parameter Name="WorkoutDescription" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="TypeOfWorkout" Type="String" />
                <asp:Parameter Name="TotalMilesRun" Type="Decimal" />
                <asp:Parameter Name="QualityMilesRun" Type="Decimal" />
                <asp:Parameter Name="TotalMinsBike" Type="Int16" />
                <asp:Parameter Name="TotalMinsSwim" Type="Int16" />
                <asp:Parameter Name="WorkoutDescription" Type="String" />
                <asp:Parameter Name="original_UserEmail" Type="String" />
                <asp:Parameter DbType="Date" Name="original_CalendarDate" />
            </UpdateParameters>

        </asp:SqlDataSource>
    
</asp:Content>