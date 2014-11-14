using System;

using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
//using System.Data.SqlClient.SqlConnection;
using System.Configuration;


public partial class UpdateeWorkoutType : System.Web.UI.Page
{
    WorkoutType myWorkoutType;
    protected void Page_Load(object sender, EventArgs e)
    {
        txtNewWorkoutType.Focus();        
        lblUserIndicator.Text = Page.User.Identity.Name;
    }

    protected void btnEnterData_Click(object sender, EventArgs e)
    {
        int KategoriID = int.Parse(Request.QueryString["id"]);  
        Response.Redirect("EnterLog.aspx");
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            myWorkoutType = new WorkoutType();
            myWorkoutType.UserEmail = Page.User.Identity.Name;
            myWorkoutType.TypeOfWorkout = txtNewWorkoutType.Text;
            if (WorkoutObjectDB.InsertWorkoutType(myWorkoutType)==1)
                ; //all good
            //SqlDataSource2.Insert();
            //SqlDataSource1.Insert();
            lblUpdateStatus.Text = "New Workout Type \"" + txtNewWorkoutType.Text + "\" has been successfully added";
        }
    }
    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
                                  //args.Value below -- was passed in from txtNewWorkoutType.Text
        args.IsValid = VerifyNoDups(args.Value, Page.User.Identity.Name);
        //args.IsValid = VerifyNoDups(args.Value, "jayb@mymail.com");
    }
    public static Boolean VerifyNoDups(string argsValue, string username)
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TrainingConnectionString"].ConnectionString);
        Boolean NoDupExistsFlag = false;
        string sel = "SELECT UserEmail, TypeOfWorkout  " +
                     "FROM  WorkoutType " +
                     "WHERE  TypeOfWorkout = @TypeOfWorkout " +
                     "AND  UserEmail = @UserEmail ";
        SqlCommand cmd = new SqlCommand(sel, conn);
        cmd.Parameters.AddWithValue("@TypeOfWorkout", argsValue);
        cmd.Parameters.AddWithValue("@UserEmail", username);

        conn.Open();
        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);

        if(rdr.HasRows )
            NoDupExistsFlag = false;
        else
            NoDupExistsFlag = true;

        conn.Close();
         return NoDupExistsFlag;
    }
}