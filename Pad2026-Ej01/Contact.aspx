<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Pad2026_Ej01.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title">
        <section>
            <h1>Nuestras oficinas</h1>
            <p>
                En STAR, priorizamos el vínculo con el cliente. 
                Por ello, abrimos las puertas de nuestras oficinas para que puedan conocer más sobre nosotros.
            </p>
            <h2>Encontranos en</h2>
            <p>
                <strong>Provincia:
                </strong>
            </p>
            <p>
                <strong>Calle:
                </strong>
            </p>
            <p>
                <strong>Código Postal:
                </strong>
            </p>
        </section>
        <section>
            <h2>Contacta con nosotros</h2>
            <form>
                <label>Nombre: </label>
                <input type="text" />
                <label>Email: </label>
                <input type="email" />

                <button name="btn-enviar">Enviar</button>
            </form>
        </section>
        <section>
            <h3>Nuestras redes</h3>
            <section class="redes">
                <div class="card-redsocial">
                    Facebook
                </div>
                <div class="card-redsocial">
                    Twitter
                </div>
                <div class="card-redsocial">
                    Instagram
                </div>
            </section>
        </section>
    </main>
</asp:Content>
