using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
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
            SqlConnection connection = new SqlConnection(""); //TODO: refactorizar esto para que lo lea de otro lado y todos puedan acceder...
            if (connection.ConnectionString.IsNullOrWhiteSpace())
            {
                throw new Exception("PONE TU STRING CONNECTION ACÁ ARRIBA:v");
            }
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
        private void SortItems(string columna)
        {
            SqlConnection connection = new SqlConnection(""); //TODO: refactorizar esto para que lo lea de otro lado y todos puedan acceder...
            if (connection.ConnectionString.IsNullOrWhiteSpace())
            {
                throw new Exception("PONE TU STRING CONNECTION ACÁ ARRIBA:v");
            }
            connection.Open();
            SqlCommand query = new SqlCommand("SELECT IdProd, Descripcion, Precio FROM Producto");
            query.Connection = connection;

            DataTable data = new DataTable();

            using (SqlDataAdapter adapter = new SqlDataAdapter(query))
            {
                adapter.Fill(data);
            }
            DataView dv = data.DefaultView;
            dv.Sort = $"{columna} DESC";
            gvProductos.DataSource = dv;
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
        protected void gvProductos_OnSorting(object sender, GridViewSortEventArgs e)
        {
            SortItems(e.SortExpression);
        }
        protected void AbrirModalProducto()
        {
            string script = @"
                bootstrap.Modal.getOrCreateInstance(
                    document.getElementById('modalAgregarProducto')
                ).show();";
            System.Web.UI.ScriptManager.RegisterStartupScript(
                this,
                GetType(),
                "AbrirModalProducto",
                script,
                true
            );
        }

        protected void btnGuardarProducto_Click(object sender, EventArgs e)
        {
            lblErrorProducto.Text = "";

            Page.Validate("AltaProducto");

            if (!Page.IsValid)
            {
                AbrirModalProducto();
                return;
            }

            string descripcion = txtDescripcion.Text.Trim();

            if (string.IsNullOrWhiteSpace(descripcion) || descripcion.Length > 250)
            {
                lblErrorProducto.Text = "Ingresá una descripción de hasta 250 caracteres.";
                AbrirModalProducto();
                return;
            }

            bool precioValido = decimal.TryParse(
                txtPrecio.Text.Trim(),
                NumberStyles.AllowDecimalPoint,
                CultureInfo.GetCultureInfo("es-AR"),
                out decimal precio
            );

            if (!precioValido || precio < 0 || precio > 99999999.99m
                || decimal.Round(precio, 2) != precio)
            {
                lblErrorProducto.Text =
                    "Ingresá un precio entre 0 y 99999999,99, con hasta dos decimales. Usá coma y sin separador de miles.";

                AbrirModalProducto();
                return;
            }

            try
            {
                GuardarProducto(descripcion, precio);
            }
            catch (SqlException)
            {
                lblErrorProducto.Text = "No se pudo guardar el producto. Intentá nuevamente.";
                AbrirModalProducto();
                return;
            }

            txtDescripcion.Text = "";
            txtPrecio.Text = "";

            LoadProducts();
        }

        public void GuardarProducto(string descripcion, decimal precio)
        {
            SqlConnection connection = new SqlConnection("");
            if (connection.ConnectionString.IsNullOrWhiteSpace()) 
            {
                throw new Exception("PONE TU STRING CONNECTION ACÁ ARRIBA:v");
            }
            connection.Open();

            SqlCommand query = new SqlCommand("INSERT INTO dbo.Producto (Descripcion, Precio) VALUES (@Descripcion, @Precio)", connection);
            using (query)
            {
                query.Parameters.Add(
                   "@Descripcion",
                    SqlDbType.NVarChar,
                    250
                ).Value = descripcion;

                SqlParameter parametroPrecio =
                    query.Parameters.Add("@Precio", SqlDbType.Decimal);

                parametroPrecio.Precision = 10;
                parametroPrecio.Scale = 2;
                parametroPrecio.Value = precio;


                query.ExecuteNonQuery();
            }
        }
    }
}
