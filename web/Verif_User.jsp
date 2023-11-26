<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Livros"%>
<%@page import="java.text.*" import="java.lang.*"%>
<%@page import="java.sql.*"%>
<%@page import="model.Cliente"%>

<%
    //Variaveis
    String idCliente;          
    String nome;   
    String email;   
    String cpf;   
    float credito;
    
    //id
    if(!request.getParameter("id").equals(null)){
    idCliente = request.getParameter("id");
    }
    else{
    idCliente = "";
    }
    //nome
    if(!request.getParameter("nome").equals(null)){
    nome = request.getParameter("nome");
    }
    else{
    nome = "";
    }
    //email
    if(!request.getParameter("email").equals(null)){
    email = request.getParameter("email");
    }
    else{
    email = "";
    }   
    //cpf
    if(!request.getParameter("cpf").equals(null)){
    cpf = request.getParameter("cpf");
    }
    else{
    cpf = "";
    } 
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consulta-cliente</title>
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
        <h2 id="logo">CONSULTA CLIENTE</h2> 
        <div id="cadastro">
            <button class="btn-home" onclick="document.location='cadas_cli.html'">Cadastrar Cliente</button>
            <button class="btn-home" onclick="document.location='carrinho.jsp?id=&idCliente=&idLivro='">Carrinho</button>
            <button class="btn-home" onclick="document.location='index.html'">Home</button>
        </div>
    </header>

    <div class="forms">
        <form id="filtro_cli" name="frmCliCad"> 
            Id: <input id="id_verif" type="number" name="id">
            Nome: <input type="text" name="nome">
            email: <input type="email" name="email">
            CPF: <input type="number" name="cpf">    
            <button type="reset"> Limpar </button>
            <button type="submit"> Enviar </button>  
        </form>
        <%
        try{
            Class.forName("com.mysql.jdbc.Driver"); //registra            
            Connection conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/bc_bibliotecavida", "root", ""); // abre Conn
            Statement stmt = conexao.createStatement(); //cria uma instrução
            
            //Consulta da lista de clientes (busca por colunas de identificação)
            String sql = "SELECT * FROM clientes where id like '%"+idCliente+"%'and nome like '%"+nome+"%'and email like '%"+email+"%'and CPF like '%"+cpf+"%' "; //defin instr. SQL
            PreparedStatement pstmt = conexao.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ResultSet rs = stmt.executeQuery(sql); // exec. Query.
      
                //Header do banco
                out.println("<table style=\"width:100%; border-collapse: collapse\">");
                out.println("<tr>");
                out.println("<th>ID</th>");
                out.println("<th>Nome</th>");
                out.println("<th>Email</th>");
                out.println("<th>CPF</th>");
                out.println("<th>Numero</th>");
                out.println("<th>Credito</th>");
                out.println("<th>Editar</th>");
                out.println("<th>Deletar</th>");
                out.println("<tr>");
                
                //CColunas da tabela
                while (rs.next()){
                out.println("<tr>");
                out.println("<td>"+rs.getString("id")+ "</td>");
                out.println("<td>"+rs.getString("nome")+ "</td>");
                out.println("<td>"+rs.getString("email")+ "</td>");
                out.println("<td>"+rs.getString("CPF")+ "</td>");
                out.println("<td>"+rs.getString("numero")+ "</td>");
                out.println("<td>"+rs.getString("credito")+ "</td>");
                //Buttons (UPDATE/DELETE)
                out.println("<td><p class=\"btn btn-editar\" onclick=\"iniciarModalEdit("+rs.getString("id")+",'"+rs.getString("nome")+"','"+rs.getString("email")+"','"+rs.getString("CPF")+"','"+rs.getString("numero")+"',"+rs.getString("credito")+")\">Editar</p></td>");
                out.println("<td><p class=\"btn btn-deletar\" onclick=\"deletarCli("+rs.getString("id")+")\">Deletar</p></td>");
                out.println("<tr>");
                }       
                out.println("</table>");
                    conexao.close(); //fecha                      
        }
        catch(Exception ex){ //tratativa
            ex.printStackTrace();
            out.println("Erro: " + ex.toString());
        } 
        %>
    </div>

    <!-- EDIÇÃO DO CLIENTE -->
    <div id="editModal">
        <div class="modal-edit">
            <input type="hidden" id="idEdit">
            <label>Nome:</label>
            <input type="text" id="nomeEdit">
            <label>E-mail:</label>
            <input type="text" id="emailEdit">
            <label>CPF:</label>
            <input type="text" id="cpfEdit">
            <label>Numero:</label>
            <input type="cel" id="numeroEdit">
            <label>Credito:</label>
            <input type="number" id="creditoEdit">
            <p onclick="mostrarModalEditar()" class="btn btn-deletar" >Cancelar</p>
            <p onclick="editarCli()" class="btn btn-editar" >Salvar</p>
        </div> 
    </div>

    <script src="./Script/buscaUsuarioscript.js" type="text/javascript"></script>
</body>
</html>

