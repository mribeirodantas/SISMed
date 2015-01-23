<%@ Page Title="Agendamentos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SISMed.Agendamentos.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card">
        <h3>Agendamentos</h3>
        <% if(!string.IsNullOrEmpty(Request.QueryString["success"])) { %>
        <asp:Panel runat="server" CssClass="notification success no-margin">
            <%= Encoding.UTF8.GetString(Convert.FromBase64String(Request.QueryString["success"])) %>
        </asp:Panel>
        <% } %>
        
        <% if (!string.IsNullOrWhiteSpace(Session["TipoDeUsuarioId"].ToString()) && int.Parse(Session["TipoDeUsuarioId"].ToString()) != 2)
           { %>
        <asp:HyperLink ID="HyperLink1" NavigateUrl="~/Agendamentos/Select.aspx" Text="Agendar Consulta" CssClass="button green" runat="server" />
        <% } %>
        <asp:EntityDataSource ID="edsAgendamentos" runat="server" EnableDelete="true"
            ConnectionString="name=SISMedEntities" DefaultContainerName="SISMedEntities"
            EnableFlattening="False" EntitySetName="Agendamentos" Include="Medico, Paciente"
            Where="it.[Ativo] = False AND ((it.Medico.UsuarioId = @UsuarioId AND @TipoDeUsuarioId = 2) OR (@TipoDeUsuarioId != 2))">
            <WhereParameters>
                <asp:SessionParameter Type="Int32" SessionField="TipoDeUsuarioId" ConvertEmptyStringToNull="true" Name="TipoDeUsuarioId" />
                <asp:SessionParameter Type="Int32" SessionField="UsuarioId" ConvertEmptyStringToNull="true" Name="UsuarioId" />
            </WhereParameters>
        </asp:EntityDataSource>

        <asp:GridView ID="gvAgendamentos" runat="server" AutoGenerateColumns="False" AllowPaging="true" PageSize="15"
            DataKeyNames="Id" DataSourceID="edsAgendamentos" CssClass="table" ShowHeaderWhenEmpty="true">
            <Columns>
                <asp:TemplateField HeaderText="Paciente">
                    <ItemTemplate>
                        <%# Eval("Paciente.Nome") %> <%# Eval("Paciente.Sobrenome") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Médico">
                    <ItemTemplate>
                        <asp:EntityDataSource ID="edsMedico" runat="server" ConnectionString="name=SISMedEntities"
                                DefaultContainerName="SISMedEntities" EntitySetName="Medicos" EntityTypeFilter="Medico"
                                Include="Usuario" Where='<%# Eval("Medico.Id", "it.Id = {0}") %>'>
                        </asp:EntityDataSource>
                        <asp:FormView ID="fvMedico" RenderOuterTable="false" DataSourceID="edsMedico" runat="server">
                                <ItemTemplate>
                                    <%# Eval("Usuario.Nome") %> <%# Eval("Usuario.Sobrenome") %>
                                </ItemTemplate>
                         </asp:FormView>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Data">
                    <ItemTemplate>
                        <%# Eval("Horario", "{0:d}") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Hora">
                    <ItemTemplate>
                        <%# Eval("Horario", "{0:t}") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <% if (!string.IsNullOrWhiteSpace(Session["TipoDeUsuarioId"].ToString()) && int.Parse(Session["TipoDeUsuarioId"].ToString()) >= 2)
                           { %>
                        <a href='<%# string.Format("../Consultas/New.aspx?paciente={0}&agendamento={1}", Eval("Paciente.Id"), Eval("Id")) %>' title="Cadastrar consulta">
                            <i class="action fa fa-medkit"></i>
                        </a>
                        <% } %>
                        <% if (!string.IsNullOrWhiteSpace(Session["TipoDeUsuarioId"].ToString()) && int.Parse(Session["TipoDeUsuarioId"].ToString()) != 2)
                           { %>
                        <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="True"
                            CommandName="Delete" ToolTip="Desmarcar agendamento" Text="<i class='action fa fa-times'></i>" />
                        <% } %>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EmptyDataRowStyle CssClass="center" />
            <EmptyDataTemplate>
                Não há nenhum agendamento cadastrado.
            </EmptyDataTemplate>
            <PagerStyle CssClass="pagination" />
        </asp:GridView>
    </div>
</asp:Content>
