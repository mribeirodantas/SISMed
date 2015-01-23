<%@ Page Title="Consultas" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SISMed.Consultas.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script src="/scripts/jquery.maskedinput.min.js"></script>
    <script>
        $(function () {
            $(".data-consulta").mask("99/99/9999");
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card">
        <h3>Consultas</h3>
        <asp:EntityDataSource ID="edsConsultas" runat="server"
            ConnectionString="name=SISMedEntities" DefaultContainerName="SISMedEntities"
            EnableFlattening="False" EntitySetName="Consultas" EnableDelete="true"
            Where="((it.Paciente.Nome + ' ' + it.Paciente.Sobrenome LIKE '%' + @Nome + '%')
                        OR (@Nome IS NULL))
                    AND ((it.Medico.UsuarioId = @UsuarioId AND @TipoDeUsuarioId = 2)
                        OR (@TipoDeUsuarioId != 2))
                    AND ((Day(it.DataHora) = Day(@Data))
                        OR (@Data IS NULL))"
            Include="Paciente, Medico">
            <WhereParameters>
                <asp:ControlParameter Type="String" ControlID="txbNome" ConvertEmptyStringToNull="true" PropertyName="Text" Name="Nome" />
                <asp:ControlParameter Type="DateTime" ControlID="txbData" ConvertEmptyStringToNull="true" PropertyName="Text" Name="Data" />
                <asp:SessionParameter Type="Int32" SessionField="TipoDeUsuarioId" ConvertEmptyStringToNull="true" Name="TipoDeUsuarioId" />
                <asp:SessionParameter Type="Int32" SessionField="UsuarioId" ConvertEmptyStringToNull="true" Name="UsuarioId" />
            </WhereParameters>
        </asp:EntityDataSource>

        <asp:Table ID="tblFiltros" CssClass="filter table" runat="server">
            <asp:TableRow>
                <asp:TableCell>
                    <asp:Label ID="lblNome" Text="Nome do Paciente: " AssociatedControlID="txbNome" runat="server" />
                    <asp:TextBox ID="txbNome" runat="server" />
                    <asp:Label ID="lblData" Text="Data: " AssociatedControlID="txbData" runat="server" />
                    <asp:TextBox ID="txbData" CssClass="data-consulta" runat="server" />
                    <asp:Button ID="btnFiltrar" Text="Filtrar" runat="server" />
                </asp:TableCell>
             </asp:TableRow>
         </asp:Table>
         <asp:GridView ID="gvConsultas" runat="server" ShowHeaderWhenEmpty="True" 
            AutoGenerateColumns="False" CssClass="table" DataSourceID="edsConsultas" PageSize="15" AllowPaging="true">
            <Columns>
                <asp:TemplateField HeaderText="Paciente">
                    <ItemTemplate>
                        <%# Eval("Paciente.Nome") + " " + Eval("Paciente.Sobrenome") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Data">
                    <ItemTemplate>
                        <%# Eval("DataHora", "{0:d}") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Hora">
                    <ItemTemplate>
                        <%# Eval("DataHora", "{0:t}") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Ações">
                    <ItemTemplate>
                        <a href='<%# Eval("Id", "./Show.aspx?id={0}") %>' title="Exibir consulta">
                            <i class="action fa fa-search"></i>
                        </a>
                        <a href='<%# Eval("Id", "./Edit.aspx?id={0}") %>' title="Editar consulta">
                            <i class="action fa fa-edit"></i>
                        </a>
                        <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="True"
                            CommandName="Delete" ToolTip="Remover consulta" Text="<i class='action fa fa-times'></i>" />
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
