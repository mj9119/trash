using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EnterLog : System.Web.UI.Page
{
    DailyWorkout thisDaysWorkout;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DateTime dtNow = DateTime.Now;
            string todaysDate = dtNow.ToString("MM/dd/yyyy");
            txtEntryDate.Text = todaysDate;
            clnDate.Visible = false;

            //Load HRS & MINS in the Bike & Swimming dropdown lists
            for (int i = 0; i <= 24; i++)
            {
                ddlHrsBike.Items.Add(i.ToString());
                ddlHrsSwim.Items.Add(i.ToString());
            }
            for (int i = 0; i <= 59; i++)
            {
                ddlMinsBike.Items.Add(i.ToString());
                ddlMinsSwim.Items.Add(i.ToString());
            }

            //determine user who is currently logged in
            lblCurrUser.Text = Page.User.Identity.Name;
            
            DailyWorkout thisDaysWorkout = new DailyWorkout();
            //retrieve this users Workout for todays date if one exists then places it on the screen
            thisDaysWorkout = WorkoutDB.RetrieveScreenFields(dtNow, Page.User.Identity.Name);
            PopulateScreenFields(thisDaysWorkout);

            // Write thisDaysWorkout to Session State
            Session["sessThisDaysWorkout"] = thisDaysWorkout;
            lblLoggedInUser.Text = Page.User.Identity.Name;
        }
    }
    protected void ibtnCalendar_Click(object sender, ImageClickEventArgs e)
    {
        clnDate.Visible = true;
        ibtnCalendar.Visible = false;  
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {            
            if (Session["sessThisDaysWorkout"] != null)
                thisDaysWorkout = (DailyWorkout)Session["sessThisDaysWorkout"];

            thisDaysWorkout.TrainingDate =  Convert.ToDateTime(txtEntryDate.Text);
            thisDaysWorkout.WorkoutType  = ddlWorkoutTypes.SelectedValue;

            thisDaysWorkout.TotalMilesRun = txtTotalMilesRun.Text;
            thisDaysWorkout.QualityMilesRun = txtQualityMilesRun.Text;

            int tempBikeMins = 
            (Convert.ToInt32(ddlMinsBike.SelectedValue))
            +
            (Convert.ToInt32(ddlHrsBike.SelectedValue) * 60);
            thisDaysWorkout.BikeMins = Convert.ToString(tempBikeMins);

            int tempSwimMins = 
            (Convert.ToInt32(ddlMinsSwim.SelectedValue))
            +
            (Convert.ToInt32(ddlHrsSwim.SelectedValue) * 60);
            thisDaysWorkout.SwimMins = Convert.ToString(tempSwimMins);

            thisDaysWorkout.OverallWorkoutDescription = txtWorkoutDesc.Text;

            if (thisDaysWorkout.insertOrUpdateFlag == "Update")
                WorkoutObjectDB.UpdateWorkoutDay(thisDaysWorkout);
                //SqlDataSource3.Update();
            else
                WorkoutObjectDB.InsertWorkoutDay(thisDaysWorkout);
                //SqlDataSource2.Insert();
                //SqlDataSource3.Insert();           

            lblTrainingInfoUpdate.Text = "Training database was successfully updated for " + txtEntryDate.Text;
            //thisDaysWorkout = new DailyWorkout();

            Session.Remove("sessThisDaysWorkout");
            // Write thisDaysWorkout to Session State
            thisDaysWorkout = WorkoutDB.RetrieveScreenFields(Convert.ToDateTime(txtEntryDate.Text), Page.User.Identity.Name);

            PopulateScreenFields(thisDaysWorkout);
            // Write thisDaysWorkout to Session State
            Session["sessThisDaysWorkout"] = thisDaysWorkout;            
        }
    }
    protected void clnDate_SelectionChanged(object sender, EventArgs e)
    {
        txtEntryDate.Text = clnDate.SelectedDate.ToShortDateString();
        clnDate.Visible = false;
        ibtnCalendar.Visible = true;

        thisDaysWorkout = WorkoutDB.RetrieveScreenFields(clnDate.SelectedDate, Page.User.Identity.Name);
        PopulateScreenFields(thisDaysWorkout);
        Session.Remove("sessThisDaysWorkout");
        // Write thisDaysWorkout to Session State
        Session["sessThisDaysWorkout"] = thisDaysWorkout;
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        ddlWorkoutTypes.SelectedIndex = -1;
        txtTotalMilesRun.Text = "0";
        txtQualityMilesRun.Text = "0";
        ddlHrsBike.SelectedIndex = -1;
        ddlMinsBike.SelectedIndex = -1;
        ddlHrsSwim.SelectedIndex = -1;
        ddlMinsSwim.SelectedIndex = -1;
        txtWorkoutDesc.Text = "";
        clnDate.Visible = false;
        ibtnCalendar.Visible = true;
    }

    protected void btnReturnToReport_Click(object sender, EventArgs e)
    {
        Response.Redirect("DisplayLog.aspx");
    }
    protected void btnAddWorkoutType_Click(object sender, EventArgs e)
    {
        DailyWorkout holdDailyWorkout = new DailyWorkout();
        holdDailyWorkout.TrainingDate = Convert.ToDateTime(txtEntryDate.Text);
        holdDailyWorkout.WorkoutType  = "";
        holdDailyWorkout.TotalMilesRun = txtTotalMilesRun.Text;
        holdDailyWorkout.QualityMilesRun = txtQualityMilesRun.Text;
        holdDailyWorkout.BikeMins = ddlMinsBike.SelectedValue + (Convert.ToInt32(ddlHrsSwim.SelectedValue) * 60);
        holdDailyWorkout.SwimMins = ddlMinsSwim.SelectedValue + (Convert.ToInt32(ddlHrsSwim.SelectedValue) * 60);
        holdDailyWorkout.OverallWorkoutDescription = txtWorkoutDesc.Text;

        // Write holdDailyWorkout to Session State
        Session["currWorkoutType"] = holdDailyWorkout;

        Response.Redirect("UpdateWorkoutType.aspx");
    }
    protected void PopulateScreenFields(DailyWorkout myDailyWorkout)
    {
        ddlWorkoutTypes.SelectedValue = myDailyWorkout.WorkoutType;

        txtTotalMilesRun.Text = myDailyWorkout.TotalMilesRun;
        txtQualityMilesRun.Text = myDailyWorkout.QualityMilesRun;
                
        decimal totalBikeMins = (Convert.ToDecimal(myDailyWorkout.BikeMins));
        if ((totalBikeMins) >= 60)
        {
            decimal highOrderDigit = Math.Truncate(totalBikeMins / 60); 
            ddlHrsBike.SelectedValue = Convert.ToString((highOrderDigit));
            ddlMinsBike.SelectedValue = Convert.ToString((totalBikeMins % 60));
        }
        else 
        {
            ddlHrsBike.SelectedValue = "0";
            ddlMinsBike.SelectedValue = myDailyWorkout.BikeMins;  //no need to convert datatype
        }

        decimal totalSwimMins = (Convert.ToDecimal(myDailyWorkout.SwimMins));
        if ((totalSwimMins) >= 60)
        {
            decimal highOrderDigit = Math.Truncate((totalSwimMins / 60));
            ddlHrsSwim.SelectedValue = Convert.ToString((highOrderDigit));
            ddlMinsSwim.SelectedValue = Convert.ToString((totalSwimMins % 60));
        }
        else
        {
            ddlHrsSwim.SelectedValue = "0";
            ddlMinsSwim.SelectedValue = myDailyWorkout.SwimMins;  //no need to convert datatype
        }

        txtWorkoutDesc.Text = myDailyWorkout.OverallWorkoutDescription;

    }
}