<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Livros"%>
<%@page import="java.text.*" import="java.lang.*"%>
<%@page import="java.sql.*"%>
<%@page import="model.Livros"%>

<%
    // Variáveis para livros
    String idLivro;
    String titulo;
    String editora;
    String autor;
    String ano;
    String valor;
    String quantidade;

    // idLivro
    if (request.getParameter("id") != null && !request.getParameter("id").isEmpty()) {
        idLivro = request.getParameter("id");
    } else {
        idLivro = "";
    }

    // título
    if (request.getParameter("titulo") != null && !request.getParameter("titulo").isEmpty()) {
        titulo = request.getParameter("titulo");
    } else {
        titulo = "";
    }

    // editora
    if (request.getParameter("editora") != null && !request.getParameter("editora").isEmpty()) {
        editora = request.getParameter("editora");
    } else {
        editora = "";
    }

    // autor
    if (request.getParameter("autor") != null && !request.getParameter("autor").isEmpty()) {
        autor = request.getParameter("autor");
    } else {
        autor = "";
    }

    // ano
    if (request.getParameter("ano") != null && !request.getParameter("ano").isEmpty()) {
        ano = request.getParameter("ano");
    } else {
        ano = "";
    }

    // valor
    if (request.getParameter("valor") != null && !request.getParameter("valor").isEmpty()) {
        valor = request.getParameter("valor");
    } else {
        valor = "";
    }

    // quantidade
    if (request.getParameter("quantidade") != null && !request.getParameter("quantidade").isEmpty()) {
        quantidade = request.getParameter("quantidade");
    } else {
        quantidade = "";
    }
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consulta-livro</title>
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
        
        form{
            margin: 25px;
        }
    </style>
</head>
<body>
    <header>
        <!-- LOGO -->
        <h2 id="logo">CONSULTA LIVRO</h2>
        <div id="cadastro">
            <button class="btn-home" onclick="document.location='cadas_cli.html'">Cadastrar Cliente</button>
            <button class="btn-home" onclick="document.location='carrinho.jsp?id=&idCliente=&idLivro='">Carrinho</button>
            <button class="btn-home" onclick="document.location='index.html'">Home</button>
        </div>
    </header>

    <div class="forms">
        <form id="filtro_livros" name="frmLivroCad"> 
            Id: <input id="id_verif" type="number" name="id">
            Título: <input type="text" name="titulo">
            Editora: <input type="text" name="editora">
            Autor: <input type="text" name="autor">    
            Ano: <input type="number" name="ano">  
            Valor: <input type="number" name="valor">  
            <button type="reset">Limpar</button>
            <button type="submit">Enviar</button>  
        </form>

        <% 
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/bc_bibliotecavida", "root", "");
                Statement stmt = conexao.createStatement();
                String sql = "SELECT * FROM livros where id like '%" + idLivro + "%' and Titulo like '%" + titulo + "%' and Editora like '%" + editora + "%' and Autor like '%" + autor + "%' and Ano like '%" + ano + "%' and Valor like '%" + valor + "%' and QNTD like '%" + quantidade + "%' ";
                PreparedStatement pstmt = conexao.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ResultSet rs = stmt.executeQuery(sql);

                out.println("<table style=\"width:100%; border-collapse: collapse\">");
                out.println("<tr>");
                out.println("<th>ID</th>");
                out.println("<th>Título</th>");
                out.println("<th>Editora</th>");
                out.println("<th>Autor</th>");
                out.println("<th>Ano</th>");
                out.println("<th>Valor</th>");
                out.println("<th>Quantidade</th>");
                out.println("<th>Editar</th>");
                out.println("<th>Deletar</th>");
                out.println("<tr>");

                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getString("id") + "</td>");
                    out.println("<td>" + rs.getString("Titulo") + "</td>");
                    out.println("<td>" + rs.getString("Editora") + "</td>");
                    out.println("<td>" + rs.getString("Autor") + "</td>");
                    out.println("<td>" + rs.getString("Ano") + "</td>");
                    out.println("<td>" + rs.getString("Valor") + "</td>");
                    out.println("<td>" + rs.getString("QNTD") + "</td>");
                    out.println("<td><p class=\"btn btn-editar\" onclick=\"iniciarModalEdit(" + rs.getString("id") + ",'" + rs.getString("Titulo") + "','" + rs.getString("Editora") + "','" + rs.getString("Autor") + "'," + rs.getString("Ano") + "," + rs.getString("Valor") + "," + rs.getString("QNTD") + ")\">Editar</p></td>");
                    out.println("<td><p class=\"btn btn-deletar\" onclick=\"deletarLivro(" + rs.getString("id") + ")\">Deletar</p></td>");
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

    <!-- EDIÇÃO DO LIVRO -->
    <div id="editModal">
        <div class="modal-edit">
            <input type="hidden" id="idEdit">
            <label>Título:</label>
            <input type="text" id="tituloEdit">
            <label>Editora:</label>
            <input type="text" id="editoraEdit">
            <label>Autor:</label>
            <input type="text" id="autorEdit">
            <label>Ano:</label>
            <input type="number" id="anoEdit">
            <label>Valor:</label>
            <input type="number" id="valorEdit">
            <label>Quantidade:</label>
            <input type="number" id="quantidadeEdit">
            <p onclick="mostrarModalEditar()" class="btn btn-deletar">Cancelar</p>
            <p onclick="editarLivro()" class="btn btn-editar">Salvar</p>
        </div>
    </div>

    <script src="Script/buscarLivrosscript.js" type="text/javascript"></script>
</body>
</html>
