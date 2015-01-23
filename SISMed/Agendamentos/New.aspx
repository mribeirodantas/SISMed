<%@ Page Title="Agendar Consulta" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="New.aspx.cs" Inherits="SISMed.Agendamentos.New" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card">
        <asp:EntityDataSource ID="edsAgendamento" runat="server" ConnectionString="name=SISMedEntities"
            DefaultContainerName="SISMedEntities" EnableFlattening="False" EnableInsert="True"
            EntitySetName="Agendamentos">
            <InsertParameters>
                <asp:QueryStringParameter Name="MedicoId" Type="Int32" QueryStringField="medicoId" />
                <asp:QueryStringParameter Name="Horario" Type="DateTime" QueryStringField="horario" />  
            </InsertParameters>
        </asp:EntityDataSource>

        <asp:FormView ID="fvAgendamento" runat="server" DataKeyNames="Id"
            DataSourceID="edsAgendamento" DefaultMode="Insert" RenderOuterTable="false" OnItemInserted="fvAgendamento_ItemInserted">
            <InsertItemTemplate>
                    <h3>Selecionar Paciente</h3>
                    <asp:EntityDataSource ID="edsPacientes" runat="server"
                        ConnectionString="name=SISMedEntities" DefaultContainerName="SISMedEntities"
                        EnableFlattening="False" EntitySetName="Pessoas" EntityTypeFilter="Paciente"
                        EnableDelete="true" Where="(it.Nome + ' ' + it.Sobrenome LIKE '%' + @Nome + '%') OR (@Nome IS NULL)">
                        <WhereParameters>
                            <asp:ControlParameter Type="String" ControlID="txbNome" ConvertEmptyStringToNull="true" PropertyName="Text" Name="Nome" />
                        </WhereParameters>
                    </asp:EntityDataSource>

                    <asp:Table ID="tblFiltros" CssClass="filter table" runat="server">
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:Label Text="Nome: " AssociatedControlID="txbNome" runat="server" />
                                <asp:TextBox ID="txbNome" runat="server" />
                                <asp:Button Text="Filtrar" runat="server" />
                            </asp:TableCell></asp:TableRow></asp:Table><asp:GridView ID="gvPacientes" runat="server"
                        ShowHeaderWhenEmpty="true" AutoGenerateColumns="False" DataKeyNames="Id"
                        DataSourceID="edsPacientes" SelectedValue='<%# Bind("PacienteId") %>' CssClass="table">
                        <Columns>
                            <asp:CommandField ShowSelectButton="true" SelectText="<i class='action fa fa-hand-o-right'></i>" />
                            <asp:TemplateField HeaderText="Nome">
                                <ItemTemplate>
                                    <%# Eval("Nome") + " " + Eval("Sobrenome") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="CPF">
                                <ItemTemplate>
                                    <%#Eval("CPF") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            Vazio.</EmptyDataTemplate><EmptyDataRowStyle CssClass="center" />
                        <SelectedRowStyle CssClass="selected-row" />
                    </asp:GridView>

                    <asp:LinkButton ID="InsertButton" runat="server" CssClass="green button block center"
                        CausesValidation="True" CommandName="Insert" Text="<i class='fa fa-plus'></i> Agendar" />
                </div>
            </InsertItemTemplate>
        </asp:FormView>
    </div>
</asp:Content>
