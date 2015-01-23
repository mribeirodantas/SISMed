<%@ Page Title="Agendar Consulta" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Select.aspx.cs" Inherits="SISMed.Agendamentos.Select" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card">
        <asp:Calendar ID="Calendar" CssClass="calendar" runat="server"
            NextMonthText="<i class='fa fa-arrow-right'></i>" PrevMonthText="<i class='fa fa-arrow-left'></i>"
            OnSelectionChanged="Calendar_SelectionChanged" OnDayRender="Calendar_DayRender">
            <TitleStyle CssClass="title" BackColor="#1DB961" />
            <SelectedDayStyle CssClass="selected" />
        </asp:Calendar>

        <asp:EntityDataSource ID="edsHorariosDeAtendimento" runat="server"
            ConnectionString="name=SISMedEntities" DefaultContainerName="SISMedEntities"
            EnableFlattening="False" EntitySetName="HorariosDeAtendimento"
            Include="DiaDaSemana, Medico" Where="it.DiaDaSemanaId = @DiaDaSemanaId + 1">
            <WhereParameters>
                <asp:ControlParameter Name="DiaDaSemanaId" ControlID="Calendar" Type="Int32" PropertyName="SelectedDate.DayOfWeek" />
            </WhereParameters>
        </asp:EntityDataSource>

        <asp:GridView ID="gvHorariosDeAtendimento" runat="server" AutoGenerateColumns="False"
            DataKeyNames="Id" DataSourceID="edsHorariosDeAtendimento" CssClass="table" OnSelectedIndexChanged="gvHorariosDeAtendimento_SelectedIndexChanged">
            <SelectedRowStyle CssClass="selected-row" />
            <Columns>
                <asp:CommandField ShowSelectButton="true" SelectText="<i class='action fa fa-hand-o-right'></i>" />
                <asp:TemplateField HeaderText="Médico">
                    <ItemTemplate>
                        <asp:EntityDataSource ID="edsMedico" runat="server" ConnectionString="name=SISMedEntities"
                            DefaultContainerName="SISMedEntities" EntitySetName="Medicos" EntityTypeFilter="Medico"
                            Include="Usuario" Where='<%# Eval("Medico.Id", "it.Id = {0}") %>'>
                        </asp:EntityDataSource>
                        <asp:FormView ID="fvMedico" RenderOuterTable="false" DataSourceID="edsMedico" DataKeyNames="Id" runat="server">
                            <ItemTemplate>
                                <%# Eval("Usuario.Nome") %> <%# Eval("Usuario.Sobrenome") %>
                            </ItemTemplate>
                        </asp:FormView>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Hora de Início" SortExpression="HoraInicio">
                    <ItemTemplate>
                        <asp:Label ID="lblHoraInicio" runat="server" Text='<%# Convert.ToDateTime(Eval("HoraInicio").ToString()).ToShortTimeString() %>' CssClass="center"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Hora de Fim" SortExpression="HoraFim">
                    <ItemTemplate>
                        <asp:Label ID="lblHoraFim" runat="server" Text='<%# Convert.ToDateTime(Eval("HoraFim").ToString()).ToShortTimeString() %>' CssClass="center"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EmptyDataRowStyle CssClass="center" />
            <EmptyDataTemplate>
                Não foi encontrado nenhum horário disponível no dia informado.
            </EmptyDataTemplate>
        </asp:GridView>

        <asp:Panel ID="pnlProximo" Visible="false" runat="server">
            <asp:HyperLink ID="lnkProximo" CssClass="green button block center" Text="Próximo <i class='fa fa-chevron-right'></i>" runat="server" />
        </asp:Panel>
    </div>
</asp:Content>