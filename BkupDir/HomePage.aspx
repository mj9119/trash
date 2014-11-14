<%@ Page Title="test123" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="HomePage.aspx.cs" Inherits="HomePage" %>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">

        <div class="clear hideSkiplink">
            <asp:Menu ID="NavigationMenu" runat="server" CssClass="menu" EnableViewState="false" IncludeStyleBlock="false" Orientation="Horizontal">
                <Items>
                    <asp:MenuItem NavigateUrl="~/HomePage.aspx" Text="Home"/>
                    <asp:MenuItem NavigateUrl="http://joeboman.com/Default.aspx" target="_blank" Text="Murray Casings Converted to ASP.Net"/>
                    <asp:MenuItem NavigateUrl="~/Training_Code/TrainingReport.aspx" Text="Training Log Application"/>
                    <asp:MenuItem NavigateUrl="~/Training_Code/UpdateWorkoutType.aspx" Text="Timberlakes Power-Outages"/>
                    <asp:MenuItem NavigateUrl="~/Training_Code/UpdateWorkoutType.aspx" Text="Orion Game Calls - Ecommerce"/>
                </Items>
            </asp:Menu>
        </div>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h1>Welcome to the Home page </h1>
    <br />
            
</asp:Content>

