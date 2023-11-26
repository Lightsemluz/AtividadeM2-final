<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Livros"%>
<%@page import="java.text.*" import="java.lang.*"%>
<%@page import="java.sql.*"%>
<%@page import="model.Cliente"%>
<%
int cont = 0;
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Adcionar-Carrinho</title>
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
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        #logo {
            margin: 0;
        }

        #home-button {
            background-color: #3498db;
            color: #fff;
            padding: 8px 16px;
            text-decoration: none;
            border-radius: 5px;
        }

        .forms {
            margin: 20px;
        }

        form {
            display: flex;
            flex-direction: column;
            align-items: center;
            max-width: 600px;
            margin: 0 auto;
        }

        form input {
            margin-bottom: 10px;
            padding: 5px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #000;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        .p-button {
            width: fit-content;
            height: fit-content;
            padding: 0.5em 1em;
            background: blue;
            color: #FFF;
            border-radius: 5px;
            transition: 300ms;
            cursor: pointer;
        }

        .p-button:hover {
            transform: scale(1.03);
            transition: 300ms;
        }

        #sucesso, #falha {
            visibility: hidden;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: #0000005b;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .card {
            border-radius: 7px;
            min-width: 500px;
            height: fit-content;
            display: flex;
            flex-direction: column;
            background: #FFF;
        }

        .card-head {
            border-radius: 5px 5px 0px 0px;
            height: fit-content;
            text-align: center;
            font-weight: bold;
        }

        .card-body {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            flex: 1;
            padding: 1%;
        }

        #sucesso .card-head {
            background: green;
            color: #FFF;
        }

        #falha .card-head {
            background: red;
            color: #FFF;
        }

        .modal-visibility {
            visibility: visible !important;
        }
    </style>
</head>
<body>
    <header>
        <h2 id="logo">CARRINHO</h2>
        <a href="index.html" id="home-button">Home</a>
    </header>
<div class="forms">
    <form  name="frmCliCad" method="post" action="comd.jsp">
             ID do Cliente:<input id="cpfValue" type="number" name="cpf" required></p>
             <p>Produto Selecionado <span id="produtoDisplay">produto</span></p>
             <input id="produtoValue" type="hidden" name="produto" value="">
    <%
            try{
                Class.forName("com.mysql.jdbc.Driver"); //registra            
                Connection conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/bc_bibliotecavida", "root", ""); // abre Conn
                Statement stmt = conexao.createStatement(); //cria uma instrução
                //SELECT * FROM clientes WHERE id = 3;
                String sql = "SELECT * FROM livros where QNTD <> 0 order by Titulo ASC"; //defin instr. SQL

                //String sql = "SELECT * FROM clientes " ; //defin instr. SQL
                ResultSet rs = stmt.executeQuery(sql); // exec. Query.
  
            //Saída
            out.println("<table>");
            out.println("<tr>");
            out.println("<th>Titulo</th>");
            out.println("<th>Editora</th>");
            out.println("<th>Autor</th>");
            out.println("<th>Ano</th>");
            out.println("<th>Valor</th>");
            out.println("<th>QNTD</th>");
            out.println("<th>Ação</th>");
            out.println("<tr>");
            
            while (rs.next()){
            out.println("<tr>");
            out.println("<td>"+rs.getString("Titulo")+ "</td>");
            out.println("<td>"+rs.getString("Editora")+ "</td>");
            out.println("<td>"+rs.getString("Autor")+ "</td>");
            out.println("<td>"+rs.getString("Ano")+ "</td>");
            out.println("<td>"+rs.getString("Valor")+ "</td>");
            out.println("<td>"+rs.getString("QNTD")+ "</td>");
            out.println("<td> <p  class='p-button' onclick='funcaoEnviar("+rs.getString("id")+")'>Adicionar</p></td>");
            out.println("<tr>");
            }       
            out.println("</table>");
                conexao.close(); //fecha                
            }
            catch(Exception ex){
                ex.printStackTrace();
                out.println("Erro: " + ex.toString());
            }   
                 %>
       
    </form>
</div>
    <div id="sucesso">
        <div class="card">
            <div class="card-head">
                <span>
                    Sucesso.
                </span>
            </div>
            <div class="card-body">
                <p id="sucesso-texto"></p>
                <p class="p-button-sucesso" onclick="mostraPopupSucesso()"> ok </p>
            </div>
        </div>
    </div>
    <script src="./Script/cheackboxscript.js" type="text/javascript"></script>
</body>
</html>