<%@ Page Title="Usuário" Language="C#" MasterPageFile="~/Site.Admin.Master" AutoEventWireup="true" CodeBehind="Show.aspx.cs" Inherits="SISMed.Administracao.Usuarios.Show" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card inline-block">
        <asp:EntityDataSource ID="edsUsuario" runat="server" ConnectionString="name=SISMedEntities" DefaultContainerName="SISMedEntities" EnableFlattening="False" EnableUpdate="True" EntitySetName="Pessoas" EntityTypeFilter="Usuario" Include="EstadoCivil, TipoDeUsuario">
        </asp:EntityDataSource>
        <asp:FormView ID="fvUsuario" RenderOuterTable="false" runat="server" DataKeyNames="Id" DataSourceID="edsUsuario" DefaultMode="ReadOnly">
            <ItemTemplate>
                <h3 class="margin-bottom">
                    <%# Eval("Nome") %> <%# Eval("Sobrenome") %>
                    <% if (!string.IsNullOrWhiteSpace(Session["TipoDeUsuarioId"].ToString()) && int.Parse(Session["TipoDeUsuarioId"].ToString()) == 4)
                           { %>
                    <asp:HyperLink ID="EditButton" runat="server" CssClass="action"
                        NavigateUrl='<%# Eval("Id", "./Edit.aspx?id={0}") %>'>
                        <i class="fa fa-pencil-square"></i>
                    </asp:HyperLink>
                    <% } %>
                </h3>
                <% if(!string.IsNullOrEmpty(Request.QueryString["success"])) { %>
                    <asp:Panel runat="server" CssClass="notification success">
                        <%= Encoding.UTF8.GetString(Convert.FromBase64String(Request.QueryString["success"])) %>
                    </asp:Panel>
                <% } %>
                <fieldset>
                    <div class="legend">
                        Dados Pessoais
                    </div>
                    <div class="content">
                        <span class="label">Data de nascimento:</span> <%# Convert.ToDateTime(Eval("DataNascimento")).ToString("dd/MM/yyyy") %>
                        <br />
                        <span class="label">CPF:</span> <%# Eval("CPF") %>
                        <br />
                        <span class="label">RG:</span> <%# Eval("RG") %>
                        <br />
                        <span class="label">Sexo:</span> <%# Eval("Sexo").ToString() == "M" ? "Masculino" : "Feminino" %>
                        <br />
                        <span class="label">Estado Civil:</span> <%# Eval("EstadoCivil.Nome") %>
                        <br />
                        <span class="label">Telefone Celular:</span> <%# Eval("TelefoneCelular") %>
                        <br />
                        <span class="label">Telefone Residencial:</span> <%# Eval("TelefoneResidencial") %>
                    </div>
                </fieldset>
                <fieldset>
                    <div class="legend">
                        Conta
                    </div>
                    <div class="content">
                        <span class="label">Email:</span> <asp:Label ID="EmailLabel" runat="server" Text='<%# Bind("Email") %>' />
                        <br />
                        <span class="label">Tipo de Usuário:</span> <asp:Label ID="TipoDeUsuarioLabel" runat="server" Text='<%# Bind("TipoDeUsuario.Nome") %>' />
                    </div>
                </fieldset>
            </ItemTemplate>
        </asp:FormView>
    </div>
</asp:Content>
