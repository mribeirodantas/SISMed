<%@ Page Title="Paciente" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Show.aspx.cs" Inherits="SISMed.Pacientes.Show" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card inline-block">
        <asp:EntityDataSource ID="edsPaciente" runat="server" ConnectionString="name=SISMedEntities" DefaultContainerName="SISMedEntities" EnableFlattening="False" EntitySetName="Pessoas" EntityTypeFilter="Paciente" Where="it.Id = @Id" Include="EstadoCivil">
             <WhereParameters>
                <asp:QueryStringParameter Name="Id" Type="Int32" QueryStringField="id" />
            </WhereParameters>
        </asp:EntityDataSource>
        <asp:FormView ID="fvPaciente" runat="server" RenderOuterTable="false" DataKeyNames="Id" DataSourceID="edsPaciente" DefaultMode="ReadOnly">
            <ItemTemplate>
                <h3 class="margin-bottom">
                    <%# Eval("Nome") %> <%# Eval("Sobrenome") %>
                    <% if (!string.IsNullOrWhiteSpace(Session["TipoDeUsuarioId"].ToString()) && int.Parse(Session["TipoDeUsuarioId"].ToString()) != 2)
                       { %>
                    <asp:HyperLink CssClass="action" NavigateUrl='<%# Eval("Id", "./Edit.aspx?id={0}") %>' runat="server">
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
                        Informações Hospitalares
                    </div>
                    <div class="content">
                        <span class="label">Tipo Sanguíneo:</span> <%# Eval("TipoSanguineo") %> 
                        <span class="label">Fator Rh:</span> <%# bool.Parse(Eval("FatorRh").ToString()) ? "+" : "-" %>
                        <br />
                        <span class="label">Alergias:</span> <br />
                        <%# Eval("Alergias") %>
                    </div>
                </fieldset>
            </ItemTemplate>
        </asp:FormView>
    </div>
</asp:Content>
