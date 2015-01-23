<%@ Page Title="Editar Consulta" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="SISMed.Consultas.Edit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script src="/scripts/jquery.maskedinput.min.js"></script>
        <script>
            $(function () {
                $(".altura").mask("9,99");
            });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card inline-block">
        <asp:EntityDataSource ID="edsConsulta" runat="server" 
            ConnectionString="name=SISMedEntities" DefaultContainerName="SISMedEntities" 
            EnableFlattening="False" EnableInsert="True" EntitySetName="Consultas"
            EnableUpdate="true" OnUpdated="edsConsulta_Updated" Where="it.Id = @Id">
            <WhereParameters>
                <asp:QueryStringParameter Name="Id" Type="Int32" QueryStringField="id" />
            </WhereParameters>
        </asp:EntityDataSource>

        <asp:FormView ID="fvConsulta" runat="server" DataKeyNames="Id" 
            DataSourceID="edsConsulta" RenderOuterTable="false" DefaultMode="Edit">
            <EditItemTemplate>
                <asp:ValidationSummary DisplayMode="SingleParagraph" CssClass="notification error no-margin"
                    runat="server" HeaderText="Preencha os campos corretamente." />
                <fieldset>
                    <div class="legend">
                        Editar Consulta
                    </div>
                    <div class="content">
                        <asp:Label Text="Peso: " AssociatedControlID="PesoTextBox" CssClass="label" runat="server" />
                        <asp:TextBox ID="PesoTextBox" TextMode="Singleline" runat="server"
                             Text='<%# Bind("Peso") %>'  Width="50"/> kg
                        <br />
                        <asp:Label runat="server" AssociatedControlID="AlturaTextBox" CssClass="label" Text="Altura: " />
                        <asp:TextBox ID="AlturaTextBox" runat="server" CssClass="altura"
                             Text='<%# Bind("Altura") %>' TextMode="SingleLine" Width="70"/> m
                        <br />
                        <asp:Label Text="Queixas:" AssociatedControlID="QueixasTextBox" CssClass="label" runat="server" /><br />
                        <asp:TextBox ID="QueixasTextBox" TextMode="MultiLine" Rows="5" Columns="40"
                            runat="server" Text='<%# Bind("Queixas") %>' />
                        <asp:RequiredFieldValidator Text="*" CssClass="required" ControlToValidate="QueixasTextBox" runat="server" />
                        <br />
                        <asp:Label Text="Diagnóstico:" AssociatedControlID="DiagnosticoTextBox" CssClass="label" runat="server" /><br />
                        <asp:TextBox ID="DiagnosticoTextBox" TextMode="MultiLine" Rows="5" Columns="40"
                            runat="server" Text='<%# Bind("Diagnostico") %>' />
                        <asp:RequiredFieldValidator Text="*" CssClass="required" ControlToValidate="DiagnosticoTextBox" runat="server" />
                    </div>
                </fieldset>
                <asp:LinkButton ID="EditButton" CssClass="green button block center" runat="server"
                    CausesValidation="True" CommandName="Update" Text="<i class='fa fa-edit'></i> Editar" />
            </EditItemTemplate>
        </asp:FormView>
    </div>
</asp:Content>
