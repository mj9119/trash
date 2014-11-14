<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="TrainingReport.aspx.cs" Inherits="TrainingReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 100%;
            border: 1px solid #008000;
        }
        .style4
        {
            width: 100%;
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
                </Items>
            </asp:Menu>
        </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h1 style="text-align:center">Training Report</h1>
        <h3 style="text-align:center"> <asp:Label ID="lblPageMessage" runat="server" 
            Visible="False"></asp:Label>  </h3>    
<p>Start Date:
    <asp:TextBox ID="txtStart" runat="server" CausesValidation="True"></asp:TextBox> 
    <asp:ImageButton ID="ibtnStart"
        runat="server" ImageUrl="~/Images/Calendar.bmp" 
        onclick="ibtnStart_Click" CausesValidation="False" />

    <asp:RequiredFieldValidator ID="rfvStartDate" runat="server" 
        ControlToValidate="txtStart" 
        ErrorMessage=" Date is Required.  Must be in MM/DD/YYYY format" 
        ForeColor="#CC3300">
    </asp:RequiredFieldValidator>
    <br />
    <asp:CompareValidator ID="cvStartDate" runat="server" 
        ControlToValidate="txtStart" ErrorMessage="You must enter  a valid Start date" 
        ForeColor="#CC3300" Operator="DataTypeCheck" Type="Date" ValidationGroup="cvStartDateGRP">
    </asp:CompareValidator>

    <asp:Calendar ID="clnStart" runat="server" Visible="False" 
        onselectionchanged="clnStart_SelectionChanged">
    </asp:Calendar>

    
    <asp:CompareValidator ID="CompareValidator1" runat="server" 
        ErrorMessage="End Date must be greater than Start Date" 
        ControlToValidate="txtEnd" Operator="GreaterThanEqual" Type="Date" 
        ControlToCompare="txtStart" ForeColor="#CC3300"></asp:CompareValidator>
</p>

<p>   End&nbsp;&nbsp;Date:
    <asp:TextBox ID="txtEnd" runat="server" CausesValidation="True"></asp:TextBox> 
    <asp:ImageButton ID="ibtnEnd"
        runat="server" ImageUrl="~/Images/Calendar.bmp" onclick="ibtnEnd_Click" 
        CausesValidation="False" />
    
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
        ControlToValidate="txtEnd" 
        ErrorMessage=" Date is Required.  Must be in MM/DD/YYYY format" 
        ForeColor="#CC3300">
    </asp:RequiredFieldValidator>
    <br />
    <asp:CompareValidator ID="CompareValidator2" runat="server" 
        ControlToValidate="txtEnd" ErrorMessage="You must enter  a valid End date" 
        ForeColor="#CC3300" Operator="DataTypeCheck" Type="Date" ValidationGroup="CompareValidator2GRP">
    </asp:CompareValidator>
    
    <asp:Calendar ID="clnEnd" runat="server" Visible="False" 
        onselectionchanged="clnEnd_SelectionChanged">
    </asp:Calendar>
</p>

<div>
    <p>
        <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource3">
            <HeaderTemplate>
            
                <table class="style4">
                <tr>
                    <td style="width: 110px;font-weight:bold;"> Calendar<br />Date
                    </td>
                    <td style="width: 170px;font-weight:bold;">Workout<br />Type
                    </td>
                    <td style="width: 100px;font-weight:bold;">Total
                        <br />
                        Miles Run
                    </td>
                    <td style="width: 100px;font-weight:bold;">Quality
                        <br />
                        Miles Run
                    </td>
                    <td style="width: 100px;font-weight:bold;">Total
                        <br />
                        Mins Bike
                    </td>
                    <td style="width: 325px;font-weight:bold;">Total
                        <br />
                        Mins Swim
                    </td>
                </tr>
                </table>

            </HeaderTemplate>
            <ItemTemplate>

                <table class="style1">
                    <tr>
                        <td style="width: 108px">
                            <asp:Label ID="CalendarDateLabel0" runat="server" 
                                Text='<%# Eval("CalendarDate", "{0:d}") %>' />
                        </td>
                        <td style="width: 171px">
                            <asp:Label ID="TypeOfWorkoutLabel0" runat="server" 
                                Text='<%# Eval("TypeOfWorkout") %>' />
                        </td>
                        <td style="width: 100px">
                            <asp:Label ID="TotalMilesRunLabel0" runat="server" 
                                Text='<%# Eval("TotalMilesRun") %>' />
                        </td>
                        <td style="width: 100px">
                            <asp:Label ID="QualityMilesRunLabel0" runat="server" 
                                Text='<%# Eval("QualityMilesRun") %>' />
                        </td>
                        <td style="width: 100px">
                            <asp:Label ID="TotalMinsBikeLabel0" runat="server" 
                                Text='<%# Eval("TotalMinsBike") %>' />
                        </td>
                        <td style="width: 250px">
                            <asp:Label ID="TotalMinsSwimLabel0" runat="server" 
                                Text='<%# Eval("TotalMinsSwim") %>' />
                        </td>
                        <td>
                            &nbsp;</td>

                    </tr>
                    <tr>
                        <td colspan="7"> <span style="font-weight:bold">WorkoutDescription: </span>
                            <asp:Label ID="WorkoutDescriptionLabel0" runat="server" 
                                Text='<%# Eval("WorkoutDescription") %>' />
                        </td>
                    </tr>
                </table>
<br />
            </ItemTemplate>
        </asp:DataList>

        <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
            ConnectionString="<%$ ConnectionStrings:TrainingConnectionString %>"                       
            
            SelectCommand="SELECT [CalendarDate], [TypeOfWorkout], [TotalMilesRun], [QualityMilesRun], [TotalMinsBike], [TotalMinsSwim], [WorkoutDescription] FROM [TrainingLog] WHERE (([CalendarDate] &lt;= @CalendarDate) AND ([CalendarDate] &gt;= @CalendarDate2) AND ([UserEmail] = @UserEmail)) ORDER BY [CalendarDate] DESC">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtEnd" DbType="Date" Name="CalendarDate" 
                    PropertyName="Text" />
                <asp:ControlParameter ControlID="txtStart" DbType="Date" Name="CalendarDate2" 
                    PropertyName="Text" />
                <asp:ControlParameter ControlID="lblLoggedInUser" Name="UserEmail" 
                    PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

    End of Report <br />
    </p>
        <p style="text-align:center"> <asp:Label ID="lblLoggedInUser" runat="server" 
            Visible="False"></asp:Label>  </p>  
</div>

</asp:Content>

