using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;

public partial class TrainingReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DateTime saveNow = DateTime.Now;
            string myString = saveNow.ToString("MM/dd/yyyy");
            txtEnd.Text = myString;

            string twoWeeksAgo = saveNow.AddDays(-14).ToString("MM/dd/yyyy");
            txtStart.Text = twoWeeksAgo;

            clnStart.Visible = false;
            clnEnd.Visible = false;

            //string userName = Page.User.Identity.Name;
            lblLoggedInUser.Text = Page.User.Identity.Name;
        }
        // Since the Image Button that launches this page has validation turned off (so the user is able to launch the calendar
        // and resolve the unrelated issue of Start Date > End date) the page is validated.  The code below however 
        // detects when the user has manually entered invalid Date into either the Start Date or End Date fields.
        // When invalid date is detected, An arbitrary valid date 11/11/1111 is entered in lieu of the program blowing up with bad data.

        Page.Validate();
        // DateTime.TryParseExact Method tests whether user input is valid
        if (!Page.IsValid)
        {
            DateTime td;
            int p;
            if
            (
            (DateTime.TryParseExact(txtStart.Text, "MM/dd/yyyy", new CultureInfo("en-US"), DateTimeStyles.None, out td)
            ||
            (DateTime.TryParseExact(txtStart.Text, "M/dd/yyyy", new CultureInfo("en-US"), DateTimeStyles.None, out td)
            ||
            (DateTime.TryParseExact(txtStart.Text, "MM/d/yyyy", new CultureInfo("en-US"), DateTimeStyles.None, out td)
            ||
            (DateTime.TryParseExact(txtStart.Text, "M/d/yyyy", new CultureInfo("en-US"), DateTimeStyles.None, out td)
            )))))   
                p = 1;
            else
                txtStart.Text = "11/11/1111";

            if 
            (
            (DateTime.TryParseExact(txtEnd.Text, "MM/dd/yyyy", new CultureInfo("en-US"), DateTimeStyles.None, out td)
            ||
            (DateTime.TryParseExact(txtEnd.Text, "M/dd/yyyy", new CultureInfo("en-US"), DateTimeStyles.None, out td)
            ||
            (DateTime.TryParseExact(txtEnd.Text, "MM/d/yyyy", new CultureInfo("en-US"), DateTimeStyles.None, out td)
            ||
            (DateTime.TryParseExact(txtEnd.Text, "M/d/yyyy", new CultureInfo("en-US"), DateTimeStyles.None, out td)
            )))))       
                p = 2;
            else
                txtEnd.Text = "11/11/1111";
        }       

    }

    //for the ibtn's below
    //validation is turned off because if start date is set > 
    //end date there would be no way to click the button to modify date
    //because the flow of execution would never arrive here to change date
    protected void ibtnStart_Click(object sender, ImageClickEventArgs e)
    {
        clnStart.Visible = true;
        ibtnStart.Visible = false;
    }
    protected void ibtnEnd_Click(object sender, ImageClickEventArgs e)
    {
        clnEnd.Visible = true;
        ibtnEnd.Visible = false;
    }
    protected void clnStart_SelectionChanged(object sender, EventArgs e)
    {
        txtStart.Text = clnStart.SelectedDate.ToShortDateString();
        clnStart.Visible = false;
        ibtnStart.Visible = true;
        Page.Validate();
    }
    protected void clnEnd_SelectionChanged(object sender, EventArgs e)
    {
        txtEnd.Text = clnEnd.SelectedDate.ToShortDateString();
        clnEnd.Visible = false;
        ibtnEnd.Visible = true;
        Page.Validate();
    }
}