<%-- 
    Document   : listar
    Created on : 28/03/2016, 20:23:17
    Author     : Administrador
--%>

<%@page import="br.edu.ifsul.modelo.Promocao"%>
<%@page import="br.edu.ifsul.dao.PromocaoDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="promocaoDao"
             scope="session" type="PromocaoDAO"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Listagem de Promocao</title>
    </head>
    <body>
        <a href="../index.html">Início</a>
        <h1>Listagem de Promocao</h1>
        <h2><%=promocaoDao.getMensagem()%></h2>
        <a href="ServletPromocao?acao=incluir">Incluir</a>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Descrição</th>
                    <th>Valor</th>                    
                    <th>Alterar</th>
                    <th>Excluir</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Promocao l : promocaoDao.getLista()) {
                %>
                <tr>
                    <td><%=l.getId()%></td>
                    <td><%=l.getDescricao()%></td>
                    
                    <td><%=l.getLivros().getTitulo()%></td>
                    <td><a href="ServletPromocao?acao=alterar&id=<%=l.getId()%>">Alterar</a></td>
                    <td><a href="ServletPromocao?acao=excluir&id=<%=l.getId()%>">Excluir</a></td>
                </tr>
                <%
                    }
                %>
            </tbody>            
        </table>
    </body>
</html>