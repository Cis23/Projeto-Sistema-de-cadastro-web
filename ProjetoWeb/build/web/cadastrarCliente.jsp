<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String cpf, nome, endereco, cidade, telefone;
            Connection con;
            PreparedStatement st;
            
            //Recebe os dados vidos do formulário cadcli.html
            cpf = request.getParameter("cpf");
            nome = request.getParameter("nome");
            endereco = request.getParameter("endereco");
            cidade = request.getParameter("cidade");
            telefone = request.getParameter("telefone");
            
            try{
               //Conecta com o banco de dados
               Class.forName("com.mysql.jdbc.Driver");
               con = DriverManager.getConnection("jdbc:mysql://localhost:3306/controleclientes","root","232428.Fc");
               //Excutando o comando INSERT que insere os dados o Banco de dados
               st = con.prepareStatement("INSERT INTO CLIENTES VALUES (?,?,?,?,?)");
               st.setString(1, cpf);
               st.setString(2, nome);
               st.setString(3, endereco);
               st.setString(4, cidade);
               st.setString(5, telefone);
               st.executeUpdate();
               out.print("Dados cadastrados com sucesso");
            }catch (ClassNotFoundException ex){
                out.print("Driver de conexão não encontrado " + ex.getMessage());
            }catch (SQLException ex){
                if(ex.getErrorCode()==1062){
                  out.print("Este código de cliente já está cadastrado");        
                } else {
                  out.print ("Erro no cadastro. Entre em contato com o administrador do site");
                }
            }
        %> 
    </body>
</html>
