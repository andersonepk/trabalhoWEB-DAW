
<%@page import="br.edu.ifsul.modelo.Genero"%>
<%@page import="br.edu.ifsul.dao.GeneroDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="generoDao"
             scope="session" type="GeneroDAO"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Listagem de Genero</title>
    </head>
    <body>
        <a href="../index.html">Início</a>
        <h1>Listagem de Generos</h1>
        <h2><%=generoDao.getMensagem()%></h2>
        <a href="ServletGenero?acao=incluir">Incluir</a>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Descricão</th>                    
                    <th>Alterar</th>
                    <th>Excluir</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Genero e : generoDao.getLista()) {
                %>
                <tr>
                    <td><%=e.getId()%></td>
                    <td><%=e.getDescricao()%></td>                    
                    <td><a href="ServletGenero?acao=alterar&id=<%=e.getId()%>">Alterar</a></td>
                    <td><a href="ServletGenero?acao=excluir&id=<%=e.getId()%>">Excluir</a></td>
                </tr>
                <%
                    }
                %>
            </tbody>            
        </table>
    </body>
</html>