<%@ Page Title="Usuário" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SISMed.Usuario.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script src="/scripts/jquery.maskedinput.min.js"></script>
    <script>
        $(function () {
            $(".horario").mask("99:99");
            $(".cpf").mask("999.999.999-99");
            $(".rg").mask("999.999.999");
            $(".telefone").mask("(99) 9999-9999");
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


<% if (!string.IsNullOrWhiteSpace(Session["TipoDeUsuarioId"].ToString()) && int.Parse(Session["TipoDeUsuarioId"].ToString()) >= 2)
           { %>
<div class="grid">
    <div class="row">
    <div class="col-12">    
        <div class="card">
            <h3>Horários de Atendimento</h3>
            <asp:EntityDataSource ID="edsHorariosDeAtendimento" runat="server" 
                ConnectionString="name=SISMedEntities" DefaultContainerName="SISMedEntities" 
                EnableDelete="True" EnableFlattening="False" EnableInsert="True" 
                EnableUpdate="True" EntitySetName="HorariosDeAtendimento" 
                EntityTypeFilter="HorarioDeAtendimento" Where="it.[MedicoId] = @MedicoId" 
                Include="DiaDaSemana" OrderBy="it.[DiaDaSemanaId], it.[HoraInicio]" Select="" 
                oninserted="edsHorariosDeAtendimento_Inserted">
                <InsertParameters>
                    <asp:SessionParameter Name="MedicoId" SessionField="UsuarioId" Type="Int32" />
                </InsertParameters>
                <WhereParameters>
                    <asp:SessionParameter Name="MedicoId" SessionField="UsuarioId" Type="Int32" />
                </WhereParameters>
            </asp:EntityDataSource>
            <asp:EntityDataSource ID="edsDiasDaSemana" runat="server" ConnectionString="name=SISMedEntities" DefaultContainerName="SISMedEntities" EnableFlattening="False" EntitySetName="DiasDaSemana">
            </asp:EntityDataSource>

            <asp:GridView ID="gvHorariosDeAtendimento" ShowHeaderWhenEmpty="true" runat="server"
                AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="edsHorariosDeAtendimento"
                CssClass="table">
                <Columns>
                    <asp:TemplateField HeaderText="Dia da Semana">
                        <EditItemTemplate>
                            <asp:DropDownList ID="DiaDaSemanaDropDownList" DataSourceID="edsDiasDaSemana" DataTextField="Nome" DataValueField="Id" SelectedValue='<%# Bind("DiaDaSemanaId") %>' runat="server" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="DiaDaSemana" Text='<%# Eval("DiaDaSemana.Nome") %>' runat="server" CssClass="center" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Hora de Início" SortExpression="HoraInicio">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("HoraInicio") %>' CssClass="horario" type="time"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="TextBox1" ValidationGroup="EditHorarioDeAtendimento" CssClass="required" Text="*"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox1" ValidationGroup="EditHorarioDeAtendimento" CssClass="required" ValidationExpression="([01]?[0-9]|2[0-3]):[0-5][0-9]" Text="*"></asp:RegularExpressionValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Convert.ToDateTime(Eval("HoraInicio").ToString()).ToShortTimeString() %>'  CssClass="center"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Hora de Fim" SortExpression="HoraFim">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("HoraFim") %>' CssClass="horario" type="time"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="TextBox2" ValidationGroup="EditHorarioDeAtendimento" CssClass="required" Text="*"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TextBox2" ValidationGroup="EditHorarioDeAtendimento" CssClass="required" ValidationExpression="([01]?[0-9]|2[0-3]):[0-5][0-9]" Text="*"></asp:RegularExpressionValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Convert.ToDateTime(Eval("HoraFim").ToString()).ToShortTimeString() %>'  CssClass="center"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ItemStyle-CssClass="center" DeleteText="&lt;i class=&quot;action fa fa-times&quot;&gt;&lt;/i&gt;" EditText="&lt;i class=&quot;action fa fa-edit&quot;&gt;&lt;/i&gt;" ShowDeleteButton="True" ShowEditButton="True" CancelText="&lt;i class=&quot;action fa fa-times&quot;&gt;&lt;/i&gt;" UpdateText="&lt;i class=&quot;action fa fa-edit&quot;&gt;&lt;/i&gt;" ValidationGroup="EditHorarioDeAtendimento" />
                </Columns>
                <EmptyDataTemplate>
                    Vazio.
                </EmptyDataTemplate>
                <EmptyDataRowStyle CssClass="center" />
            </asp:GridView>
            <asp:FormView ID="fvHorarioDeAtendimento" runat="server" DataKeyNames="Id" DataSourceID="edsHorariosDeAtendimento" DefaultMode="Insert">
                <InsertItemTemplate>
                        <td>
                             Dia da Semana:
                             <asp:DropDownList ID="DiaDaSemanaDropDownList" DataSourceID="edsDiasDaSemana" DataTextField="Nome" DataValueField="Id" SelectedValue='<%# Bind("DiaDaSemanaId") %>' runat="server">
                             </asp:DropDownList>
                        </td>
                        <td>
                            Hora de Início:
                            <asp:TextBox ID="HoraInicioTextBox" CssClass="horario" runat="server" Text='<%# Bind("HoraInicio") %>' />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="HoraInicioTextBox" ValidationGroup="InsertHorarioDeAtendimento" CssClass="required" Text="*"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="HoraInicioTextBox" ValidationGroup="InsertHorarioDeAtendimento" CssClass="required" ValidationExpression="([01]?[0-9]|2[0-3]):[0-5][0-9]" Text="*"></asp:RegularExpressionValidator>
                        </td>
                        <td>
                            Hora de Fim:
                            <asp:TextBox ID="HoraFimTextBox" CssClass="horario" runat="server" Text='<%# Bind("HoraFim") %>' />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="HoraFimTextBox" ValidationGroup="InsertHorarioDeAtendimento" CssClass="required" Text="*"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="HoraFimTextBox" ValidationGroup="InsertHorarioDeAtendimento" CssClass="required" ValidationExpression="([01]?[0-9]|2[0-3]):[0-5][0-9]" Text="*"></asp:RegularExpressionValidator>
                        </td>
                        <td>
                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" ValidationGroup="InsertHorarioDeAtendimento" Text="<i class='action fa fa-plus'></i>" />
                        </td>
                    <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="HorarioDeAtendimento" runat="server" />
                </InsertItemTemplate>
            </asp:FormView>
        </div>
    </div>
</div>
</div>
<% } %>

<div class="grid">
    <div class="row">
        <div class="col-6">
            <div class="card">
                <asp:EntityDataSource ID="edsUsuario" runat="server" ConnectionString="name=SISMedEntities" DefaultContainerName="SISMedEntities" EnableFlattening="False" EnableUpdate="True" EntitySetName="Pessoas" EntityTypeFilter="Usuario" Where="it.Id = @Id" OnUpdated="edsUsuario_Updated">
                    <WhereParameters>
                        <asp:SessionParameter Name="Id" SessionField="UsuarioId" Type="Int32" />
                    </WhereParameters>
                </asp:EntityDataSource>
                <asp:EntityDataSource ID="edsEstadosCivis" runat="server" ConnectionString="name=SISMedEntities" DefaultContainerName="SISMedEntities" EnableFlattening="False" EntitySetName="EstadosCivis">
                </asp:EntityDataSource>

                <asp:FormView ID="fvUsuario" runat="server" RenderOuterTable="false" DataKeyNames="Id" DataSourceID="edsUsuario" DefaultMode="Edit">
                    <EditItemTemplate>
                        <h3><%# Eval("Nome") %> <%# Eval("Sobrenome") %></h3>
                        <% if(!string.IsNullOrEmpty(Request.QueryString["success"])) { %>
                            <asp:Panel ID="Panel3" runat="server" CssClass="notification success no-margin">
                                <%= Encoding.UTF8.GetString(Convert.FromBase64String(Request.QueryString["success"])) %>
                            </asp:Panel>
                        <% } %>
                        <fieldset>
                            <div class="legend">
                                Dados Pessoais
                            </div>
                            <div class="content">
                                <asp:Label ID="Label3" Text="Nome:" AssociatedControlID="NomeTextBox" CssClass="label" runat="server" />
                                <asp:TextBox ID="NomeTextBox" runat="server" Text='<%# Bind("Nome") %>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Text="*" CssClass="required" ControlToValidate="NomeTextBox" runat="server" />
                                <br />
                                <asp:Label ID="Label4" Text="Sobrenome:" AssociatedControlID="SobrenomeTextBox" CssClass="label" runat="server" />
                                <asp:TextBox ID="SobrenomeTextBox" runat="server" Text='<%# Bind("Sobrenome") %>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" Text="*" CssClass="required" ControlToValidate="SobrenomeTextBox" runat="server" />
                                <br />
                                <asp:Label ID="Label5" Text="CPF:" AssociatedControlID="CPFTextBox" CssClass="label" runat="server" />
                                <asp:TextBox ID="CPFTextBox" CssClass="cpf" runat="server" Text='<%# Bind("CPF") %>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" Text="*" CssClass="required" ControlToValidate="CPFTextBox" runat="server" />
                                <br />
                                <asp:Label ID="Label6" Text="RG:" AssociatedControlID="RGTextBox" CssClass="label" runat="server" />
                                <asp:TextBox ID="RGTextBox" CssClass="rg" runat="server" Text='<%# Bind("RG") %>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" Text="*" CssClass="required" ControlToValidate="RGTextBox" runat="server" />
                                <br />
                                <asp:Label ID="Label7" Text="Sexo:" AssociatedControlID="Sexo" CssClass="label" runat="server" />
                                <asp:DropDownList ID="Sexo" SelectedValue='<%# Bind("Sexo") %>' runat="server">
                                    <asp:ListItem Text="Masculino" Value="M" />
                                    <asp:ListItem Text="Feminino" Value="F" />
                                </asp:DropDownList>
                                <br />
                                <asp:Label ID="Label8" Text="Estado Civil:" AssociatedControlID="EstadosCivisDropDownList" CssClass="label" runat="server" />
                                <asp:DropDownList ID="EstadosCivisDropDownList" SelectedValue='<%# Bind("EstadoCivilId") %>' DataSourceID="edsEstadosCivis" DataTextField="Nome" DataValueField="Id" runat="server">
                                </asp:DropDownList>
                                <br />
                                <asp:Label ID="Label9" Text="Telefone Celular:" AssociatedControlID="TextBox1" CssClass="label" runat="server" />
                                <asp:TextBox ID="TextBox1" CssClass="telefone" runat="server" Text='<%# Bind("TelefoneCelular") %>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" Text="*" CssClass="required" ControlToValidate="TextBox1" runat="server" />
                                <br />
                                <asp:Label ID="Label10" Text="Telefone Residencial:" AssociatedControlID="TextBox2" CssClass="label" runat="server" />
                                <asp:TextBox ID="TextBox2" CssClass="telefone" runat="server" Text='<%# Bind("TelefoneResidencial") %>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" Text="*" CssClass="required" ControlToValidate="TextBox2" runat="server" />
                            </div>
                        </fieldset>
                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CssClass="green button block center"
                            CommandName="Update" Text="<i class='fa fa-edit'></i> Editar" />
                    </EditItemTemplate>
                </asp:FormView>
            </div>
        </div>
        <div class="col-6">
            <div class="card">
                <asp:EntityDataSource ID="edsMudarSenha" runat="server" ConnectionString="name=SISMedEntities" DefaultContainerName="SISMedEntities" EnableFlattening="False" EnableUpdate="True" EntitySetName="Pessoas" EntityTypeFilter="Usuario" Where="it.Id = @Id" OnUpdating="edsMudarSenha_Updating">
                    <WhereParameters>
                        <asp:SessionParameter Name="Id" SessionField="UsuarioId" Type="Int32" />
                    </WhereParameters>
                </asp:EntityDataSource>
                <asp:FormView ID="fvMudarSenha" RenderOuterTable="false" DataKeyNames="Id" DataSourceID="edsMudarSenha" runat="server" DefaultMode="Edit">
                    <EditItemTemplate>
                        <h3>Alterar Senha</h3>
                        <% if(!string.IsNullOrEmpty(Request.QueryString["successPassword"])) { %>
                            <asp:Panel ID="Panel1" runat="server" CssClass="notification success no-margin">
                                <%= Encoding.UTF8.GetString(Convert.FromBase64String(Request.QueryString["successPassword"]))%>
                            </asp:Panel>
                        <% } %>
                        <% if (!string.IsNullOrEmpty(Request.QueryString["errorPassword"])) { %>
                            <asp:Panel ID="Panel2" runat="server" CssClass="notification error no-margin">
                                <%= Encoding.UTF8.GetString(Convert.FromBase64String(Request.QueryString["errorPassword"]))%>
                            </asp:Panel>
                        <% } %>
                        <fieldset>
                            <div class="content">
                                <asp:Label ID="Label11" Text="Senha Atual:" AssociatedControlID="txbSenhaAtual" CssClass="label" runat="server" />
                                <asp:TextBox ID="txbSenhaAtual" runat="server" TextMode="Password" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" Text="*" CssClass="required" ControlToValidate="txbSenhaAtual"
                                    runat="server" ValidationGroup="AlterarSenha" />
                                <br />
                                <asp:Label ID="Label12" Text="Nova Senha:" AssociatedControlID="txbSenha" CssClass="label" runat="server" />
                                <asp:TextBox ID="txbSenha" runat="server" Text='<%# Bind("Senha") %>' TextMode="Password" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" Text="*" CssClass="required" ControlToValidate="txbSenha"
                                    runat="server" ValidationGroup="AlterarSenha" />
                                <br />
                                <asp:Label ID="Label13" Text="Confirmar Nova Senha:" AssociatedControlID="txbConfirmacao" CssClass="label" runat="server" />
                                <asp:TextBox ID="txbConfirmacao" runat="server" TextMode="Password" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" Text="*" CssClass="required" ControlToValidate="txbConfirmacao"
                                    runat="server" ValidationGroup="AlterarSenha" />
                                <asp:CompareValidator ID="CompareValidator1" Text="*" CssClass="required" ControlToValidate="txbConfirmacao"
                                    ControlToCompare="txbSenha" ValidationGroup="AlterarSenha" runat="server" />
                            </div>
                        </fieldset>
                        <asp:LinkButton ID="btnAlterarSenha" runat="server" CausesValidation="True" CssClass="green button block center"
                            CommandName="Update" Text="<i class='fa fa-edit'></i> Alterar" ValidationGroup="AlterarSenha" />
                    </EditItemTemplate>
                </asp:FormView>
            </div>
        </div>
    </div>
</div>
</asp:Content>
