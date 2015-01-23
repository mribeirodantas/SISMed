using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SISMed
{
    public partial class Site_Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var userId = Session["UsuarioId"] ?? "";
            var userTypeId = Session["TipoDeUsuarioId"] ?? "";

            if (string.IsNullOrWhiteSpace(userId.ToString()))
            {
                Response.Redirect(ResolveUrl("~/Login/Default.aspx?redirect=" + Request.RawUrl));
            }
            else
            {
                if (string.IsNullOrWhiteSpace(userTypeId.ToString()) || int.Parse(userTypeId.ToString()) < 3)
                    Response.Redirect(ResolveUrl("~/Dashboard/Default.aspx"));
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Session.Contents.RemoveAll();
            Response.Redirect("/Login/Default.aspx");
        }

        protected void Menu_MenuItemDataBound(object sender, MenuEventArgs e)
        {
            SiteMapNode item = e.Item.DataItem as SiteMapNode;
            if (item != null && !string.IsNullOrWhiteSpace(Session["TipoDeUsuarioId"].ToString()))
            {
                if (string.IsNullOrEmpty(item["userTypeId"]) || int.Parse(Session["TipoDeUsuarioId"].ToString()) < int.Parse(item["userTypeId"].ToString()))
                {
                    (sender as Menu).Items.Remove(e.Item);
                }
            }
        }
    }
}