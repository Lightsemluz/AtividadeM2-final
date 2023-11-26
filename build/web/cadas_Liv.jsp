<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Livros"%>
<%@page import="java.text.*" import="java.lang.*"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro-Livro</title>
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

        #logo {
            margin: 0;
        }

        #home-btn {
            background-color: #3498db;
            color: #fff;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 5px;
            transition: background 0.3s;
        }

        #home-btn:hover {
            background-color: #2980b9;
        }

        b {
            color: #e67e22;
        }

        p {
            margin: 0;
        }
    </style>
</head>
<body>
    <header>
        <h2 id="logo">CADASTRO DO LIVRO</h2>
        <button id="home-btn" onclick="document.location='index.html'">Home</button>
    </header>
<%
    // Recebendo dados do formulário
    Livros livro = new Livros();
    livro.setTitulo(request.getParameter("titulo"));
    livro.setAno(Integer.parseInt(request.getParameter("ano")));
    livro.setAutor(request.getParameter("autor"));
    livro.setEditora(request.getParameter("edit"));
    livro.setValor(Float.parseFloat(request.getParameter("valor")));

    // Inserindo no banco de dados e recuperando o ID gerado
    int novoIDLivro = -1; // Inicializa como -1 para indicar que nenhum ID foi gerado

    try {
        Class.forName("com.mysql.jdbc.Driver"); // Registra o driver
        Connection conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/bc_bibliotecavida", "root", "");

        // Define a consulta SQL para inserção na tabela livros
        String sql = "INSERT INTO livros (titulo, ano, autor, editora, valor) VALUES (?, ?, ?, ?, ?)";
        
        // Cria o PreparedStatement e informa que deseja obter o ID gerado
        PreparedStatement pstmt = conexao.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

        // Define os parâmetros da consulta com base nos dados do formulário
        pstmt.setString(1, livro.getTitulo());
        pstmt.setInt(2, livro.getAno());
        pstmt.setString(3, livro.getAutor());
        pstmt.setString(4, livro.getEditora());
        pstmt.setFloat(5, livro.getValor());

        // Executa a consulta
        pstmt.executeUpdate();

        // Obtém o ID gerado
        ResultSet generatedKeys = pstmt.getGeneratedKeys();
        if (generatedKeys.next()) {
            novoIDLivro = generatedKeys.getInt(1); // Obtém o ID gerado
        }

        // Fecha a conexão
        conexao.close();
    } catch (Exception ex) {
        ex.printStackTrace();
        out.println("Erro: " + ex.toString());
    }
%>
    <p><b>Registro - Livro</b></p>
    <p>Identificação: <%= novoIDLivro %></p> <!-- Exibe o novo ID gerado -->
    <p><b>Livro cadastrado</b></p>
</body>
</html>
