using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SISMed.Models;
using SISMed.App_Code;

namespace SISMed.Administracao.Usuarios
{
    public partial class New : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void edsUsuario_Inserting(object sender, EntityDataSourceChangingEventArgs e)
        {
            SISMed.Models.Usuario u = e.Entity as SISMed.Models.Usuario;
            u.Senha = Password.HashPassword(u.Senha);
        }

        protected void edsUsuario_Inserted(object sender, EntityDataSourceChangedEventArgs e)
        {
            SISMed.Models.Usuario u = e.Entity as SISMed.Models.Usuario;
            if (u.TipoDeUsuarioId > 1)
            {
                sdsMedico.InsertParameters.Add(new Parameter("Usuario_Id", TypeCode.String, u.Id.ToString()));
                sdsMedico.InsertParameters.Add(new Parameter("UsuarioId", TypeCode.String, u.Id.ToString()));
                sdsMedico.Insert();
            }
            Response.Redirect(string.Format("./Show.aspx?id={0}&success=VXN1w6FyaW8gY2FkYXN0cmFkbyBjb20gc3VjZXNzby4=", u.Id));
        }

    }
}