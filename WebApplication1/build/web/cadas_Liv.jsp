<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Livros"%>
<%@page import="java.text.*" import="java.lang.*"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro-Livro</title>
    <meta name="description" content="">
    <link rel="stylesheet" type="text/css" href="css/cadas_cli.css"/>
</head>
<body>
    <header>
        <h2 id="logo">CADASTRO DO LIVRO/h2> 
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
    out.println("<b> Registro - Livro </b>");
    out.println("<br> Identificação: " + novoIDLivro); // Exibe o novo ID gerado
    out.println("<b> Livro cadastrado </b>");
%>
    </body>
</html>
