<%-- 
    Document   : cadas_cli
    Created on : 14 de nov. de 2023, 11:35:27
    Author     : matheus
--%>

<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Cliente"%>
<%@page import="java.text.*" import="java.lang.*"%>

<!DOCTYPE html>
<html>
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro-Cliente</title>
    <meta name="description" content="">
    <link rel="stylesheet" type="text/css" href="css/cadas_cli.css"/>
</head>
<body>
    <header>
        <h2 id="logo">CADASTRO DO CLIENTE</h2>
    </header>
<%
    // Recebendo dados do formulário
    Cliente form = new Cliente();
    form.setNome(request.getParameter("nome"));
    form.setEmail(request.getParameter("email"));
    form.setNumero(request.getParameter("cell"));
    form.setCpf(request.getParameter("CPF"));

    // Inserindo no banco de dados e recuperando o ID gerado
    int novoID = -1; // Inicializa como -1 para indicar que nenhum ID foi gerado
    try {
        Class.forName("com.mysql.jdbc.Driver"); // Registra o driver
        Connection conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/bc_bibliotecavida", "root", "");

        // Define a consulta SQL para inserção na tabela clientes
        String sql = "INSERT INTO clientes (nome, email, CPF, numero) VALUES (?, ?, ?, ?)";
        
        // Cria o PreparedStatement e informa que deseja obter o ID gerado
        PreparedStatement pstmt = conexao.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

        // Define os parâmetros da consulta com base nos dados do formulário
        pstmt.setString(1, form.getNome());
        pstmt.setString(2, form.getEmail());
        pstmt.setString(3, form.getCpf());
        pstmt.setString(4, form.getNumero());

        // Executa a consulta
        pstmt.executeUpdate();

        // Obtém o ID gerado
        ResultSet generatedKeys = pstmt.getGeneratedKeys();
        if (generatedKeys.next()) {
            novoID = generatedKeys.getInt(1); // Obtém o ID gerado
        }
        // Fecha a conexão
        conexao.close();
    } catch (Exception ex) {
        ex.printStackTrace();
        out.println("Erro: " + ex.toString());
    }
    out.println("<b> Registro - Clientes </b>");
    out.println("<br> Identificação: " + novoID); // Exibe o novo ID gerado
    out.println("<b> Cliente cadastrado </b>");
%>
    </body>
</html>