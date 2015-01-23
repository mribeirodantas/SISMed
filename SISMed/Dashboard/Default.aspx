<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SISMed.Dashboard.Default" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div class="grid">
    <div class="row">
        <div class="col-6">
            <div class="card">
                <h3>Agendamentos do Dia</h3>
                <asp:EntityDataSource ID="edsAgendamentos" runat="server" ConnectionString="name=SISMedEntities"
                    DefaultContainerName="SISMedEntities" EnableFlattening="False" EntitySetName="Agendamentos"
                    Include="Paciente, Medico" OrderBy="it.[Horario] ASC, it.[Paciente].[Nome]"
                    Where="(it.[Ativo] = False)
                        AND (Day(it.[Horario]) = Day(CurrentDateTime()))
                        AND ((it.Medico.UsuarioId = @UsuarioId AND @TipoDeUsuarioId = 2)
                            OR (@TipoDeUsuarioId != 2))">
                    <WhereParameters>
                        <asp:SessionParameter Type="Int32" SessionField="TipoDeUsuarioId" ConvertEmptyStringToNull="true" Name="TipoDeUsuarioId" />
                        <asp:SessionParameter Type="Int32" SessionField="UsuarioId" ConvertEmptyStringToNull="true" Name="UsuarioId" />
                    </WhereParameters>
                </asp:EntityDataSource>
                <asp:GridView ID="gvAgendamentos" runat="server" AutoGenerateColumns="False" DataSourceID="edsAgendamentos"
                    CssClass="table" AllowPaging="True" PageSize="5" ShowHeaderWhenEmpty="true">
                    <Columns>
                        <asp:TemplateField HeaderText="Paciente">
                            <ItemTemplate>
                                <%# Eval("Paciente.Nome") %> <%# Eval("Paciente.Sobrenome") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Hora">
                            <ItemTemplate>
                                <%# Eval("Horario", "{0:t}") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataRowStyle CssClass="center" />
                    <EmptyDataTemplate>
                        Não há consultas marcadas.
                    </EmptyDataTemplate>
                    <PagerStyle CssClass="pagination" />
                </asp:GridView>
            </div>
        </div>
        <div class="col-6">
            <div class="card">
                <h3>Últimas Consultas</h3>
                <asp:EntityDataSource ID="edsConsultas" runat="server" 
                    ConnectionString="name=SISMedEntities" DefaultContainerName="SISMedEntities" 
                    EnableFlattening="False" EntitySetName="Consultas"
                    Select="it.Id, it.Paciente, it.Medico, it.DataHora" OrderBy="it.[DataHora] DESC"
                    Where="(it.Medico.UsuarioId = @UsuarioId AND @TipoDeUsuarioId = 2) OR (@TipoDeUsuarioId != 2)">
                    <WhereParameters>
                        <asp:SessionParameter Type="Int32" SessionField="TipoDeUsuarioId" ConvertEmptyStringToNull="true" Name="TipoDeUsuarioId" />
                        <asp:SessionParameter Type="Int32" SessionField="UsuarioId" ConvertEmptyStringToNull="true" Name="UsuarioId" />
                    </WhereParameters>
                </asp:EntityDataSource>
                <asp:GridView ID="gvConsultas" runat="server" AutoGenerateColumns="False" 
                    DataKeyNames="Id" DataSourceID="edsConsultas" PageSize="5"
                    CssClass="table" AllowPaging="True" ShowHeaderWhenEmpty="true">
                    <Columns>
                        <asp:TemplateField HeaderText="Paciente">
                            <ItemTemplate>
                                <%# Eval("Paciente.Nome") %> <%# Eval("Paciente.Sobrenome") %>
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
                    </Columns>
                    <EmptyDataRowStyle CssClass="center" />
                    <EmptyDataTemplate>
                        Vazio.
                    </EmptyDataTemplate>
                    <PagerStyle CssClass="pagination" />
                </asp:GridView>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-6">
            <div class="card">
                <h3>Consultas e Agendamentos</h3>
                <div class="center">
                    <asp:Chart ID="chartConsultasAgendamentos" runat="server" DataSourceID="sdsConsultasAgendamentos"
                        Palette="None" Width="400px" PaletteCustomColors="120, 238, 171; 51, 204, 119; 25, 182, 93">
                        <Series>
                            <asp:Series Name="Consultas" ChartType="line" XValueMember="DATA" YValueMembers="Consultas"
                                BorderWidth="2" Legend="Consultas e Agendamentos" IsXValueIndexed="True">
                            </asp:Series>
                            <asp:Series Name="Agendamentos" ChartType="line" XValueMember="DATA"
                                YValueMembers="Agendamentos" BorderWidth="2" Legend="Consultas e Agendamentos"
                                IsXValueIndexed="True">
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1" AlignmentOrientation="All" BorderDashStyle="Solid"
                                IsSameFontSizeForAllAxes="True">
                                <AxisY Title="Pacientes">
                                    <MajorGrid LineColor="Gainsboro" />
                                </AxisY>
                                <AxisX Title="Data">
                                    <MajorGrid Enabled="False" LineColor="Gainsboro" />
                                </AxisX>
                            </asp:ChartArea>
                        </ChartAreas>
                        <Legends>
                            <asp:Legend DockedToChartArea="ChartArea1" Docking="Bottom" InterlacedRows="True"
                                InterlacedRowsColor="244, 244, 244" IsDockedInsideChartArea="False" LegendItemOrder="SameAsSeriesOrder"
                                LegendStyle="Row" Name="Consultas e Agendamentos" Alignment="Center">
                            </asp:Legend>
                        </Legends>
                        <BorderSkin BackImageWrapMode="Scaled" />
                    </asp:Chart>
                </div>
                <asp:SqlDataSource ID="sdsConsultasAgendamentos" runat="server" ConnectionString="<%$ ConnectionStrings:SISMedConnectionString %>"
                    SelectCommand="
                                    WITH UltimosDias (Data)
                                    AS
                                    (
                                            SELECT CAST(DATEADD(DAY,DATEDIFF(DAY, 0, GETDATE()), -NUMBER) AS DATE) AS d
                                            FROM (SELECT TOP 7 ROW_NUMBER() OVER (ORDER BY name) - 1 AS NUMBER FROM sysobjects) AS numbers
                                            WHERE DATEPART(dw, DATEADD(DAY,DATEDIFF(DAY, 0, GETDATE()), -NUMBER)) NOT IN (1, 7)
                                    )
                                    SELECT CONVERT(CHAR(5), Data, 103) AS Data,
                                            (SELECT COUNT(*) FROM Agendamentos WHERE CAST(Horario AS DATE) = DATA) AS Agendamentos,
                                            (SELECT COUNT(*) FROM Consultas WHERE CAST(DataHora AS DATE) = DATA) AS Consultas
                                    FROM UltimosDias ORDER BY Data
                                "></asp:SqlDataSource>
            </div>
        </div>
        <div class="col-6"></div>
    </div>
</div>
</asp:Content>
