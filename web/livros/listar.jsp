<%-- 
    Document   : listar
    Created on : 28/03/2016, 20:23:17
    Author     : Administrador
--%>

<%@page import="br.edu.ifsul.modelo.Livros"%>
<%@page import="br.edu.ifsul.dao.LivrosDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="livrosDao"
             scope="session" type="LivrosDAO"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Listagem de Livros</title>
    </head>
    <body>
        <a href="../index.html">Início</a>
        <h1>Listagem de Livros</h1>
        <h2><%=livrosDao.getMensagem()%></h2>
        <a href="ServletLivros?acao=incluir">Incluir</a>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Titulo</th>
                    <th>Autor</th>
                    <th>Valor Unitario</th>
                    <th>Quantidade</th>
                    <th>Alterar</th>
                    <th>Excluir</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Livros l : livrosDao.getLista()) {
                %>
                <tr>
                    <td><%=l.getId()%></td>
                    <td><%=l.getTitulo()%></td>
                    <td><%=l.getAutor()%></td>
                    <td><%=l.getValorUnitario()%></td>
                    <td><%=l.getQuantidade()%></td>
                    <td><%=l.getGenero().getDescricao()%></td>
                    <td><a href="ServletLivros?acao=alterar&id=<%=l.getId()%>">Alterar</a></td>
                    <td><a href="ServletLivros?acao=excluir&id=<%=l.getId()%>">Excluir</a></td>
                </tr>
                <%
                    }
                %>
            </tbody>            
        </table>
    </body>
</html>