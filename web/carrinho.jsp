<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Livros"%>
<%@page import="java.text.*" import="java.lang.*"%>
<%@page import="java.sql.*"%>
<%@page import="model.Livros"%>
<%
    // Variáveis para o carrinho
    String idCarrinho;
    String idCliente;
    String idLivro;

    // idCarrinho
    if (request.getParameter("id") != null && !request.getParameter("id").isEmpty()) {
        idCarrinho = request.getParameter("id");
    } else {
        idCarrinho = "";
    }

    // idCliente
    if (request.getParameter("idCliente") != null && !request.getParameter("idCliente").isEmpty()) {
        idCliente = request.getParameter("idCliente");
    } else {
        idCliente = "";
    }

    // idLivro
    if (request.getParameter("idLivro") != null && !request.getParameter("idLivro").isEmpty()) {
        idLivro = request.getParameter("idLivro");
    } else {
        idLivro = "";
    }
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consulta-carrinho</title>
    <meta name="description" content="">

    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #faf3e0;
        }

        header {
            background-color: #e67e22;
            color: #fff;
            text-align: center;
            padding: 10px 0;
        }

        .navbar {
            background-color: #e67e22;
            overflow: hidden;
        }

        .navbar a {
            float: left;
            display: block;
            color: #fff;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }

        .navbar a:hover {
            background-color: #d35400;
        }

        .conteudo {
            margin: 20px;
        }

        .btn-home {
            background: #3498db;
            color: #FFF;
            border: none;
            padding: 15px 25px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 5px;
            transition: background 0.3s;
        }

        .btn-home:hover {
            background: #2980b9;
        }

        #editModal {
            width: 100%;
            height: 100%;
            position: fixed;
            top: 0px;
            left: 0px;
            display: flex;
            justify-content: center;
            align-items: center;
            background: #000000ad;
            visibility: hidden;
        }

        .visible {
            visibility: visible !important;
        }

        .modal-edit {
            width: 60%;
            height: fit-content;
            padding: 1%;
            border-radius: 7px;
            box-shadow: 0px 10px 5px rgba(0, 0, 0, 0.4);
            background: #FFF;
        }

        table, td, th {
            border: 1px solid #000;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        .btn {
            padding: 0.5em 1em;
            color: #FFF;
            transition: 300ms;
            cursor: pointer;
            width: fit-content;
        }

        .btn:hover {
            transition: 300ms;
            transform: scale(1.03);
        }

        .btn-editar {
            background: yellow;
            color: #000;
        }

        .btn-deletar {
            background: red;
        }

        form {
            margin: 25px;
        }
    </style>
</head>
<body>
<header>
    <h2 id="logo">CONSULTA CARRINHO</h2>
    <div id="cadastro">
        <button class="btn-home" onclick="document.location='Verif_User.jsp?id=&nome=&email=&cpf='">Consultar Cliente</button>
        <button class="btn-home" onclick="document.location='cadas_cli.html'">Cadastrar Cliente</button>
        <button class="btn-home" onclick="document.location='index.html'">Home</button>
    </div>
</header>
<div class="forms">
    <form id="filtro_carrinho" name="frmCarrinhoCad"> 
        Id Carrinho: <input id="id_verif" type="number" name="id">
        Id Cliente: <input type="number" name="idCliente">
        Id Livro: <input type="number" name="idLivro">  
        <button type="reset">Limpar</button>
        <button type="submit">Enviar</button>  
    </form>

    <%
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/bc_bibliotecavida", "root", "");
            Statement stmt = conexao.createStatement();

            String sql = "SELECT * FROM carrinho where id like '%" + idCarrinho + "%' and id_cliente like '%" + idCliente + "%' and id_livro like '%" + idLivro + "%'";
            PreparedStatement pstmt = conexao.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ResultSet rs = stmt.executeQuery(sql);

            out.println("<table style=\"width:100%; border-collapse: collapse\">");
            out.println("<tr>");
            out.println("<th>ID Carrinho</th>");
            out.println("<th>ID Cliente</th>");
            out.println("<th>ID Livro</th>");
            out.println("<th>Editar</th>");
            out.println("<th>Deletar</th>");
            out.println("<tr>");

            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getString("id") + "</td>");
                out.println("<td>" + rs.getString("id_cliente") + "</td>");
                out.println("<td>" + rs.getString("id_livro") + "</td>");
                out.println("<td><p class=\"btn btn-editar\" onclick=\"iniciarModalEdit(" + rs.getString("id") + "," + rs.getString("id_cliente") + "," + rs.getString("id_livro") + ")\">Editar</p></td>");
                out.println("<td><p class=\"btn btn-deletar\" onclick=\"deletarCarrinho(" + rs.getString("id") + ")\">Deletar</p></td>");
                out.println("<tr>");
            }
            out.println("</table>");
            conexao.close();
        } catch (Exception ex) {
            ex.printStackTrace();
            out.println("Erro: " + ex.toString());
        }
    %>
</div>
<!-- EDIÇÃO DO CARRINHO -->
<div id="editModal">
    <div class="modal-edit">
        <input type="hidden" id="idEdit">
        <label>ID Cliente:</label>
        <input type="number" id="idClienteEdit">
        <label>ID Livro:</label>
        <input type="number" id="idLivroEdit">
        <p onclick="mostrarModalEditar()" class="btn btn-deletar">Cancelar</p>
        <p onclick="editarCarrinho()" class="btn btn-editar">Salvar</p>
    </div>
</div>
<script src="Script/buscacomprascript.js" type="text/javascript"></script>
</body>
</html>
