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
        <asp:GridView ID="gvProductos" runat="server" Height="267px" Width="476px" AllowSorting="True" OnSorting="gvProductos_OnSorting">
            
        </asp:GridView>
    </main>

</asp:Content>
