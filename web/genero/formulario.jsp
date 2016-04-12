<%-- 
    Document   : formulario
    Created on : 28/03/2016, 20:42:23
    Author     : Administrador
--%>

<%@page import="br.edu.ifsul.dao.GeneroDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="generoDao"
             scope="session" type="GeneroDAO"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Edição de Generos</title>
        <script>
            function doSalvar(){
                document.getElementById("acao").value = 'salvar';
                document.getElementById("form").submit();
            }
            function doCancelar(){
                document.getElementById("acao").value = 'cancelar';
                document.getElementById("form").submit();
            }            
        </script>
    </head>
    <body>
        <h1>Edição de Estados</h1>
        <h2><%=generoDao.getMensagem()%></h2>
        <form name="form" id="form" action="ServletGenero" method="POST">
            ID: <input type="text" name="id" 
                       value="<%= generoDao.getObjetoSelecionado().getId() == null
                               ?"" : generoDao.getObjetoSelecionado().getId()%>"
                                size="6" readonly/><br/>
            Nome: <input type="text" name="descricao"
                         value="<%= generoDao.getObjetoSelecionado().getDescricao()== null
                         ? "" : generoDao.getObjetoSelecionado().getDescricao()%>"
                         size="40"/><br/>
           
            <input type="button" value="Salvar" name="btnSalvar" onclick="doSalvar()"/>
            <input type="button" value="Cancelar" name="btnCancelar" onclick="doCancelar()"/>
            <input type="hidden" name="acao" id="acao" value=""/>
        </form>
    </body>
</html>