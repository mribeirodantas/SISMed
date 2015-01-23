<%@ Page Title="Solicitações" Language="C#" MasterPageFile="~/Site.Admin.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SISMed.Administracao.Solicitacoes.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card">
        <asp:EntityDataSource ID="edsSolicitacoes" runat="server" 
            ConnectionString="name=SISMedEntities" DefaultContainerName="SISMedEntities"
            EnableFlattening="False" EnableUpdate="True"
            EntitySetName="Solicitacoes" EntityTypeFilter="Solicitacao"
            Where="(it.Resolvido = @Resolvido) OR NOT @Ativado"
            Include="Usuario">
            <WhereParameters>
                <asp:ControlParameter Type="Boolean"  ControlID="ddlFiltro" DefaultValue="false" ConvertEmptyStringToNull="true" Name="Resolvido" PropertyName="SelectedValue" />
                <asp:ControlParameter Type="Boolean" ControlID="cxbFiltrar" DefaultValue="true" Name="Ativado" PropertyName="Checked" />
            </WhereParameters>
        </asp:EntityDataSource>

        <h3>Solicitações</h3>

        <asp:Table ID="tblFiltros" CssClass="filter table" runat="server">
            <asp:TableRow>
                <asp:TableCell>
                    <asp:CheckBox ID="cxbFiltrar" runat="server" Checked="true" AutoPostBack="True" Text="Filtrar: " />
                    <asp:DropDownList ID="ddlFiltro" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlFiltro_SelectedIndexChanged">
                        <asp:ListItem Value="false">Não resolvidos</asp:ListItem>
                        <asp:ListItem Value="true">Resolvidos</asp:ListItem>
                    </asp:DropDownList>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>

        <asp:GridView ID="gvSolicitacoes" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
            DataSourceID="edsSolicitacoes" ShowHeaderWhenEmpty="True" OnRowCommand="gvSolicitacoes_RowCommand"
            CssClass="table" AllowPaging="true" PageSize="15">
            <Columns>
                <asp:TemplateField HeaderText="Solicitante">
                    <ItemTemplate>
                        <%# Eval("Usuario.Nome") %> <%# Eval("Usuario.Sobrenome") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="DataHora" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Data" SortExpression="DataHora" />
                <asp:BoundField DataField="DataHora" DataFormatString="{0:HH:mm}" HeaderText="Hora" SortExpression="DataHora" />
                <asp:BoundField DataField="Descricao" HeaderText="Descrição" SortExpression="Descricao" />
                <asp:TemplateField HeaderText="Ação">
                    <ItemTemplate>
                        <asp:LinkButton Text='<%# (Boolean.Parse(Eval("Resolvido").ToString())) ? "<i class=\"action fa fa-times\"></i>" : "<i class=\"action fa fa-check\"></i>" %>'
                            ToolTip='<%# (Boolean.Parse(Eval("Resolvido").ToString())) ? "Marcar como não resolvido" : "Marcar como resolvido" %>'
                            runat="server" CommandName="ToggleResolvido" CommandArgument='<%# Container.DataItemIndex %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
                Vazio.
            </EmptyDataTemplate>
            <EmptyDataRowStyle CssClass="center" />
            <PagerStyle CssClass="pagination" />
        </asp:GridView>
    </div>
</asp:Content>
