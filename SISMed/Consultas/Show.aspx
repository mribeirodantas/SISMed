<%@ Page Title="Consulta" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Show.aspx.cs" Inherits="SISMed.Consultas.Show" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="grid">
    <div class="row">
        <div class="col-4">
            <div class="card">
                <asp:EntityDataSource ID="edsConsulta" runat="server" 
                    ConnectionString="name=SISMedEntities" DefaultContainerName="SISMedEntities" 
                    EnableFlattening="False" EntitySetName="Consultas" Where="it.Id = @Id" 
                    Include="Paciente">
                     <WhereParameters>
                        <asp:QueryStringParameter Name="Id" Type="Int32" QueryStringField="id" />
                    </WhereParameters>
                </asp:EntityDataSource>
                <asp:FormView ID="fvConsulta" runat="server" RenderOuterTable="false" DataKeyNames="Id" DataSourceID="edsConsulta" DefaultMode="ReadOnly">
                    <ItemTemplate>
                        <h3>
                            Consulta de <%# Eval("Paciente.Nome") %> <%# Eval("Paciente.Sobrenome") %>
                            <asp:HyperLink ID="EditButton" CssClass="action" NavigateUrl='<%# Eval("Id", "./Edit.aspx?id={0}") %>' runat="server">
                                <i class="fa fa-pencil-square"></i>
                            </asp:HyperLink>
                        </h3>
                        <% if(!string.IsNullOrEmpty(Request.QueryString["success"])) { %>
                            <asp:Panel runat="server" CssClass="notification success no-margin">
                                <%= Encoding.UTF8.GetString(Convert.FromBase64String(Request.QueryString["success"])) %>
                            </asp:Panel>
                        <% } %>
                        <fieldset>
                            <div class="content">
                                <span class="label">Data:</span> <%# Eval("DataHora", "{0:d}") %> <span class="label">Hora:</span> <%# Eval("DataHora", "{0:t}") %>
                                <br />
                                <span class="label">Peso:</span> <%# Eval("Peso") + " kg" %> <span class="label">Altura:</span> <%# Eval("Altura") + " m"%>
                                <br />
                                <span class="label">Queixas:</span> <br /> <%# Eval("Queixas") %>
                                <br />
                                <span class="label">Diagnóstico:</span> <br /> <%# Eval("Diagnostico") %>
                            </div>
                        </fieldset>
                    </ItemTemplate>
                </asp:FormView>
            </div>
        </div>
        <div class="col-8">
            <div class="card">
                <h3>Medicações</h3>
                <asp:EntityDataSource ID="edsMedicacoes" runat="server" ConnectionString="name=SISMedEntities"
                    DefaultContainerName="SISMedEntities" EnableDelete="True" EnableFlattening="False"
                    EnableInsert="True" EnableUpdate="True" EntitySetName="Medicacoes" Where="it.ConsultaId = @ConsultaId"
                    OnInserted="edsMedicacoes_Inserted">
                    <WhereParameters>
                        <asp:QueryStringParameter Name="ConsultaId" Type="Int32" QueryStringField="id" />
                    </WhereParameters>
                    <InsertParameters>
                        <asp:QueryStringParameter Name="ConsultaId" Type="Int32" QueryStringField="id" />
                    </InsertParameters>
                </asp:EntityDataSource>
                <asp:GridView ID="gvMedicacoes" runat="server" AutoGenerateColumns="False" 
                    ShowHeaderWhenEmpty="True" DataKeyNames="Id" CssClass="table" 
                    DataSourceID="edsMedicacoes">
                    <Columns>
                        <asp:TemplateField HeaderText="Nome" SortExpression="Nome">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Nome") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator Text="*" CssClass="required" ControlToValidate="TextBox1" ValidationGroup="EditMedicacao" runat="server" />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Nome") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Quantidade" SortExpression="Quantidade">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Quantidade") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator Text="*" CssClass="required" ControlToValidate="TextBox2" ValidationGroup="EditMedicacao" runat="server" />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Quantidade") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ItemStyle-CssClass="center" 
                            DeleteText="&lt;i class=&quot;action fa fa-times&quot;&gt;&lt;/i&gt;" EditText="&lt;action i class=&quot;action fa fa-edit&quot;&gt;&lt;/i&gt;"
                            ShowDeleteButton="True" ShowEditButton="True" 
                            CancelText="&lt;i class=&quot;action fa fa-times&quot;&gt;&lt;/i&gt;" 
                            UpdateText="&lt;i class=&quot;action fa fa-edit&quot;&gt;&lt;/i&gt;" ValidationGroup="EditMedicacao" >
                            <ItemStyle CssClass="center"></ItemStyle>
                        </asp:CommandField>
                    </Columns>
                    <EmptyDataTemplate>
                        Não há nenhuma medicação registrada nesta consulta.
                    </EmptyDataTemplate>
                    <EmptyDataRowStyle CssClass="center" />
                </asp:GridView>
                <asp:FormView ID="fvMedicacao" runat="server" DataKeyNames="Id" DataSourceID="edsMedicacoes" DefaultMode="Insert">
                    <InsertItemTemplate>
                        <td>Nome:
                            <asp:TextBox ID="NomeTextBox" runat="server" Text='<%# Bind("Nome") %>' />
                            <asp:RequiredFieldValidator Text="*" CssClass="required" ValidationGroup="InsertMedicacao" ControlToValidate="NomeTextBox" runat="server" />
                        </td>
                        <td>Quantidade:
                            <asp:TextBox ID="QuantidadeTextBox" runat="server" Text='<%# Bind("Quantidade") %>' />
                            <asp:RequiredFieldValidator Text="*" CssClass="required" ValidationGroup="InsertMedicacao" ControlToValidate="QuantidadeTextBox" runat="server" />
                        </td>
                        <td>
                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" ValidationGroup="InsertMedicacao" CommandName="Insert" Text="<i class='action fa fa-plus'></i>" />
                        </td>
                    </InsertItemTemplate>
                </asp:FormView>
            </div>
        </div>
    </div>
</div>
</asp:Content>
