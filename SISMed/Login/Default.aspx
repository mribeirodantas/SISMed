<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SISMed.Login.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width" />
    <title>Login · SISMed</title>
    <link href="http://fonts.googleapis.com/css?family=Varela+Round" rel="stylesheet" />
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="<%: ResolveUrl("~/content/css/normalize.css") %>" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/content/css/boilerplate.css") %>" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/content/css/main.css") %>" rel="stylesheet" />
    <script src="<%: ResolveUrl("~/scripts/jquery-1.10.2.min.js") %>"></script>
    <script src="<%: ResolveUrl("~/scripts/modernizr-2.6.2.min.js") %>"></script>
    <script src="<%: ResolveUrl("~/scripts/main.js") %>"></script>
    <script src="<%: ResolveUrl("~/scripts/plugins.js") %>"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="login">
        <h2>
            <span class="fa fa-lock"></span> Autenticação
        </h2>
        <% if(!string.IsNullOrEmpty(Request.QueryString["error"])) { %>
        <asp:Panel runat="server" CssClass="alert">
            Usuário ou senha incorretos.
        </asp:Panel>
        <% } %>
        <fieldset>
            <asp:SqlDataSource ID="sdsLogin" runat="server" ConnectionString="<%$ ConnectionStrings:SISMedConnectionString %>"
                SelectCommand="SELECT [Usuarios].[Id], [Email], [Senha], [Nome], [Sobrenome], [TipoDeUsuarioId] FROM [Pessoas_Usuario] AS [Usuarios] INNER JOIN [Pessoas] ON [Usuarios].[Id] = [Pessoas].[Id] WHERE ([Email] = @Email)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txbEmail" Name="Email" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Panel CssClass="field control" runat="server">
                <asp:Label Text="Email" AssociatedControlID="txbEmail" runat="server" /><br />
                <asp:TextBox ID="txbEmail" CssClass="fill width" runat="server" />
            </asp:Panel>
            <asp:Panel CssClass="field control" runat="server">
                <asp:Label Text="Senha" AssociatedControlID="txbSenha" runat="server" /><br />
                <asp:TextBox ID="txbSenha" CssClass="fill width" TextMode="Password" runat="server" />
            </asp:Panel>
            <asp:Button Text="Entrar" CssClass="button green" runat="server" ID="btnLogin" OnClick="btnLogin_Click" />
        </fieldset>
    </div>
    </form>
</body>
</html>
