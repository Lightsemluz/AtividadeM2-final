<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Livros"%>
<%@page import="java.text.*" import="java.lang.*"%>
<%@page import="java.sql.*"%>
<%@page import="model.Cliente"%>

<%
    String idCliente;          
    String nome;   
    String email;   
    String cpf;   
    
    
    if(!request.getParameter("id").equals(null)){
    idCliente = request.getParameter("id");
    }
    else{
    idCliente = "";
    }
    
    if(!request.getParameter("nome").equals(null)){
    nome = request.getParameter("nome");
    }
    else{
    nome = "";
    }
    
    if(!request.getParameter("email").equals(null)){
    email = request.getParameter("email");
    }
    else{
    email = "";
    }   
 
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
    <link rel="stylesheet" type="text/css" href="./css/cadas_cli.css"/>
    <style>
        table, td, th {
        border: 1px solid #000;
}
table {
  width: 100%;
  border-collapse: collapse;
}
.btn{
padding: 0.5em 1em;
color: #FFF;
transition: 300ms;
cursor:pointer;
}
.btn:hover{
transition: 300ms;
transform: scale(1.03);
}

.btn-editar{background: yellow;color: #000;}
.btn-deletar{background:red;}
</style>
</head>
<body>
    <header>
        <h2 id="logo">CONSULTA CLIENTE</h2> 
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
        //SELECT * FROM clientes WHERE id = 3;
        String sql = "SELECT * FROM clientes where id like '%"+idCliente+"%'and nome like '%"+nome+"%'and email like '%"+email+"%'and CPF like '%"+cpf+"%' "; //defin instr. SQL
        PreparedStatement pstmt = conexao.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        ResultSet rs = stmt.executeQuery(sql); // exec. Query.
  
                //Saída
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
            
                while (rs.next()){
            out.println("<tr>");
            out.println("<td>"+rs.getString("id")+ "</td>");
            out.println("<td>"+rs.getString("nome")+ "</td>");
            out.println("<td>"+rs.getString("email")+ "</td>");
            out.println("<td>"+rs.getString("CPF")+ "</td>");
            out.println("<td>"+rs.getString("numero")+ "</td>");
            out.println("<td>"+rs.getString("credito")+ "</td>");
            out.println("<td><p class=\"btn btn-editar\" onclick=\"\">Editar</p></td>");
            out.println("<td><p class=\"btn btn-deletar\" onclick=\"deletarCli("+rs.getString("id")+")\">Deletar</p></td>");
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
</div>
<script src="./Script/buscaUsuarioscript.js" type="text/javascript"></script>
</body>
</html>