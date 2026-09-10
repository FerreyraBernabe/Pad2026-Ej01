<%@ Page Title="Productos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="Pad2026_Ej01.Productos" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main>
        <header>
            <h1>Consultá nuestra lista de productos</h1>
        </header>
        <div class="search-bar">
            <label>Buscar</label>
            <asp:TextBox ID="txtBuscar" type="text" runat="server"/>
            <asp:Button ID="btnBuscar" type="submit" runat="server" Text="Realizar búsqueda" OnClick="btnBuscar_Click"/>
        </div>
<<<<<<< HEAD
        <asp:GridView ID="gvProductos" runat="server" Height="267px" Width="476px" AllowSorting="True" OnSorting="gvProductos_OnSorting">
            
=======
        <asp:GridView ID="gvProductos" runat="server" Height="267px" Width="476px">
         
>>>>>>> feat/alta-pedido
        </asp:GridView>


        <button type="button" id="btnAbrirModal" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAgregarProducto"> Agregar Producto</button>
     
        
    <div class="modal fade"
         id="modalAgregarProducto"
         tabindex="-1"
         aria-labelledby="tituloModalProducto"
         aria-hidden="true">

        <asp:Label
            ID="lblErrorProducto"
            runat="server"
            CssClass="text-danger d-block mb-3"
            role ="alert"/>


         <div class="modal-dialog">
            <div class="modal-content">

                <div class="modal-header">
                    <h2 class="modal-title fs-5" id="tituloModalProducto">
                        Agregar Producto
                    </h2>

                    <button type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Cerrar">
                    </button>
                </div>

                <div class="modal-body">
                    <asp:Label
                        runat="server"
                        AssociatedControlID="txtDescripcion"
                        Text="Descripción" />

                    <asp:TextBox
                        ID="txtDescripcion"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="250" />

                    <asp:Label
                        runat="server"
                        AssociatedControlID="txtPrecio"
                        Text="Precio"
                        CssClass="mt-3" />

                    <asp:TextBox
                        ID="txtPrecio"
                        runat="server"
                        CssClass="form-control" />
                </div>

                <div class="modal-footer">
                    <button type="button"
                            class="btn btn-secondary"
                            data-bs-dismiss="modal">
                        Cancelar
                    </button>

                    <asp:Button
                        ID="btnGuardarProducto"
                        runat="server"
                        Text="Guardar"
                        CssClass="btn btn-primary"
                        ValidationGroup="AltaProducto"
                        onClick="btnGuardarProducto_Click"/>
                </div>

            </div>
        </div>
    </div>
    
    </main>

    

</asp:Content>
