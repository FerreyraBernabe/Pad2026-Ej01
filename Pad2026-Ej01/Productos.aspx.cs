using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Pad2026_Ej01
{
    public partial class Productos : System.Web.UI.Page
    {
        
        private void LoadProducts(string nombreProd="") 
        {
            SqlConnection connection = new SqlConnection(
                "Data Source=(LocalDB)\\MSSQLLocalDB;" +
                "AttachDbFilename=\"C:\\Users\\User\\Documents\\U\\4to año\\" +
                "Programación de Aplicaciones Distribuidas\\Pad2026Ej01\\Pad2026-Ej01\\Pad2026-Ej01\\App_Data\\StarCO.mdf\";" +
                "Integrated Security=True"); //TODO: refactorizar esto para que lo lea de otro lado y todos puedan acceder...
            connection.Open();
            SqlCommand query = new SqlCommand();
            query.Connection = connection;
            if (!nombreProd.IsNullOrWhiteSpace()) 
            {
                query.CommandText= $"SELECT IdProd, Descripcion, Precio FROM Producto WHERE Descripcion LIKE @nombreProd";
                query.Parameters
                    .Add("@nombreProd", SqlDbType.NVarChar,50)
                    .Value = "%" + nombreProd + "%";
            }
            else 
            {
                query.CommandText = "SELECT IdProd," +
                    " Descripcion, " +
                    "Precio " +
                    "FROM Producto";
            }
            DataTable data = new DataTable();
            using (SqlDataAdapter adapter = new SqlDataAdapter(query)) 
            {
                adapter.Fill(data);
            }
            gvProductos.DataSource = data;
            gvProductos.DataBind();
            
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) 
            {
                LoadProducts();
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            LoadProducts(txtBuscar.Text);
        }

        protected void gvProductos_SelectedIndexChanged(object sender, EventArgs e)
        {
        }
    }
}