<%-- 
    Document   : comd
    Created on : 20 de nov. de 2023, 15:13:57
    Author     : matheus
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Livros"%>
<%@page import="java.text.*" import="java.lang.*"%>
<%@page import="java.sql.*"%>
<%@page import="model.Cliente"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container">
        <main>
            <div class="card">
                <div class="card-head">
                    <h1>Venda</h1>
                </div>
        <%
            // Recebendo dados
            Livros livro = new Livros();
            String cliente = request.getParameter("cpf");                      
            String livros = request.getParameter("titulo");
            
            //Consultar
            try{
                Class.forName("com.mysql.jdbc.Driver"); //registra            
                Connection conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/bc_bibliotecavida", "root", ""); // abre Conn
                Statement stmt = conexao.createStatement(); //cria uma instrução
                ///          SELECT * FROM clientes WHERE id = 3;
                String sql = "SELECT * FROM clientes WHERE CPF = " + cliente; //defin instr. SQL
                String sql_2 ="SELECT * FROM livros WHERE id = " +livros+ " ";
                
               // String sql = "SELECT * FROM clientes " ; //defin instr. SQL
                ResultSet rs = stmt.executeQuery(sql_2); // exec. Query.
                
                //Saída
                while (rs.next()){
                
                 livro.setTitulo(rs.getString("titulo"));
            }                                        
                conexao.close(); //fecha                
            }
            catch(Exception ex){
                ex.printStackTrace();
                out.println("Erro: " + ex.toString());
            }   
                 %>
                <div class="card-content">
                    <div class="input-pack">
                        <p>Titulo: <%=livro.getTitulo()%></p>
                   <input type=hidden value="<%=livro.getTitulo()%>"/>                    
                    </div>
                    <div class="input-pack">
                        <label for="">Valor</label>
                        <input type="number" name="" id="">
                    </div>
                    <div class="input-pack">
                        <label for="">Troca:</label>
                        <input type="checkbox" name="" id="checkShow">
                    </div>
                    <div id="inputPackTrade" class="input-pack-trade">
                        <div class="input-pack">
                            <label for="">ID Usuario</label>
                            <input type="number" name="" id="">
                            <label for="">Valor de Crédito</label>
                            <input type="number" name="" id="">
                        </div>
                        <div class="input-pack">
                            <h3>Usuario</h3>
                        </div>
                    </div>
                    <div class="input-pack">
                        <button type="submit">Finalizar</button>
                    </div>
                </div>
          </div>
        </main>
        <footer>
            <p>@ Footer Generico</p>
        </footer>
    </div>
          <script src="./Script/cheackboxscript.js" type="text/javascript"></script>
    </body>
</html>