<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Pad2026_Ej01._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main>
        <header>
            <h1>Bienvenido a STAR Company</h1>
            <img source="~/"
                alt="imagen-piola-para-el-inicio" />
        </header>
        <article class="noticias">
            <h2>Ultimas noticias</h2>
            <section class="cards-noticias">
                <div class="single-card-noticias">
                    Noticias 1
                </div>
                <div class="single-card-noticias">
                    Noticias 2
                </div>
                <div class="single-card-noticias">
                    Noticias 3
                </div>
            </section>
        </article>
        <article>
            <h2>¿Por qué elegirnos?</h2>
            <p>Nuestros clientes nos avalan como la empresa líder en productos tecnológicos. 
                Contamos con un personal serio y garantizamos seguridad en todas tus transacciones.</p>
        </article>
    </main>

</asp:Content>
