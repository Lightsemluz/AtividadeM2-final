<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Livros"%>
<%@page import="java.text.*" import="java.lang.*"%>
<%@page import="java.sql.*"%>
<%@page import="model.Cliente"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
                <%
            // Recebendo dados
            String id = ( request.getParameter("id")); 
            String nome =( request.getParameter("nome"));                      
            String email = ( request.getParameter("email")); 
            String numero = ( request.getParameter("numero")); 
            String cpf = ( request.getParameter("cpf")); 
            float credito = Float.parseFloat(request.getParameter("credito"));; 
            
            //Consultar
            try{
                Class.forName("com.mysql.jdbc.Driver"); //registra            
                Connection conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/bc_bibliotecavida", "root", ""); // abre Conn
                Statement stmt = conexao.createStatement(); //cria uma instrução
                //EDIÇÃO
                String sql = "UPDATE `clientes` SET nome='"+nome+"',email='"+email+"',`CPF`='"+cpf+"',`numero`='"+numero+"',`credito`='"+credito+"' WHERE id = '"+id+"'";; //defin instr. SQL
                PreparedStatement pstmt = conexao.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                pstmt.executeUpdate();
                conexao.close();            
            }
            catch(Exception ex){
                ex.printStackTrace();
                out.println("Erro: " + ex.toString());
            }   
                 %>
                <script> windows.close(); </script>
    </body>
</html>