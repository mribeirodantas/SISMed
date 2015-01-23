<%@ Page Title="Usuários" Language="C#" MasterPageFile="~/Site.Admin.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SISMed.Administracao.Usuarios.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card">
        <h3>Usuários</h3>
        <asp:EntityDataSource ID="edsUsuarios" runat="server"
            ConnectionString="name=SISMedEntities" DefaultContainerName="SISMedEntities"
            EnableFlattening="False" EntitySetName="Pessoas" EnableDelete="true" EntityTypeFilter="Usuario"
            Where="(it.Nome + ' ' + it.Sobrenome LIKE '%' + @Nome + '%') OR (@Nome IS NULL)" OrderBy="it.Nome ASC, it.Sobrenome ASC">
            <WhereParameters>
                <asp:ControlParameter Type="String" ControlID="txbNome" ConvertEmptyStringToNull="true" PropertyName="Text" Name="Nome" />
            </WhereParameters>
        </asp:EntityDataSource>
        
        <% if (!string.IsNullOrWhiteSpace(Session["TipoDeUsuarioId"].ToString()) && int.Parse(Session["TipoDeUsuarioId"].ToString()) == 4)
           { %>
        <asp:HyperLink NavigateUrl="~/Administracao/Usuarios/New.aspx" Text="Novo Usuário" CssClass="button green" runat="server" />
        <% } %>
        
        <asp:Table ID="tblFiltros" CssClass="filter table" runat="server">
            <asp:TableRow>
                <asp:TableCell>
                    <asp:Label Text="Nome: " AssociatedControlID="txbNome" runat="server" />
                    <asp:TextBox ID="txbNome" runat="server" />
                    <asp:Button Text="Filtrar" runat="server" />
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        
        <asp:GridView ID="gvUsuarios" runat="server" ShowHeaderWhenEmpty="true" AutoGenerateColumns="False"
            DataKeyNames="Id" DataSourceID="edsUsuarios" CssClass="table" PageSize="15" AllowPaging="true">
            <Columns>
                <asp:TemplateField HeaderText="Nome">
                    <ItemTemplate>
                        <%# Eval("Nome") + " " + Eval("Sobrenome") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="CPF">
                    <ItemTemplate>
                        <%# Eval("CPF") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Email" HeaderText="Email" ReadOnly="True" SortExpression="Email" />
                <asp:TemplateField HeaderText="Ações">
                    <ItemTemplate>
                        <a href='<%# Eval("Id", "./Show.aspx?id={0}") %>' title="Exibir usuário">
                            <i class="action fa fa-search"></i>
                        </a>
                        <% if (!string.IsNullOrWhiteSpace(Session["TipoDeUsuarioId"].ToString()) && int.Parse(Session["TipoDeUsuarioId"].ToString()) == 4)
                           { %>
                        <a href='<%# Eval("Id", "./Edit.aspx?id={0}") %>' title="Editar usuário">
                            <i class="action fa fa-edit"></i>
                        </a>
                        <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="True"
                            CommandName="Delete" ToolTip="Remover usuário" Text="<i class='action fa fa-times'></i>" />
                        <% } %>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
                Vazio.
            </EmptyDataTemplate>
            <EmptyDataRowStyle CssClass="empty data" />
            <PagerStyle CssClass="pagination" />
        </asp:GridView>
    </div>
</asp:Content>
