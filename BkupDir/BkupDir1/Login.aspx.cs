using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //set initial cursor position in User Name field 
        Page.Form.DefaultFocus = Login1.FindControl("Username").ClientID;
    }

}