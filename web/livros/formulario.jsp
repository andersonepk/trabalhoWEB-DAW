<%-- 
    Document   : formulario
    Created on : 28/03/2016, 20:42:23
    Author     : Administrador
--%>
<%@page import="br.edu.ifsul.modelo.Genero"%>
<%@page import="br.edu.ifsul.dao.LivrosDAO"%>
<%@page import="br.edu.ifsul.dao.GeneroDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="generoDao"
             scope="session" type="GeneroDAO"/>
<jsp:useBean id="livrosDao"
             scope="session" type="LivrosDAO"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Edição de Livros</title>
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
        <h1>Edição de Livros</h1>
        <h2><%=livrosDao.getMensagem()%></h2>
        <form name="form" id="form" action="ServletLivros" method="POST">
            ID: <input type="text" name="id" 
                       value="<%= livrosDao.getObjetoSelecionado().getId() == null
                               ?"" : livrosDao.getObjetoSelecionado().getId()%>"
                                size="6" readonly/><br/>
            Titulo <input type="text" name="titulo"
                         value="<%= livrosDao.getObjetoSelecionado().getTitulo()== null
                         ? "" : livrosDao.getObjetoSelecionado().getTitulo()%>"
                         size="40"/><br/>
            Autor <input type="text" name="autor"
                         value="<%= livrosDao.getObjetoSelecionado().getAutor()== null
                         ? "" : livrosDao.getObjetoSelecionado().getAutor()%>"
                         size="40"/><br/>
            Valor Unitario: <input type="text" name="valorUnitario"
                         value="<%= livrosDao.getObjetoSelecionado().getValorUnitario()== null
                         ? "" : livrosDao.getObjetoSelecionado().getValorUnitario()%>"
                         size="5"/><br/>
            
            Quantidade: <input type="text" name="quantidade"
                         value="<%= livrosDao.getObjetoSelecionado().getQuantidade()== null
                         ? "" : livrosDao.getObjetoSelecionado().getQuantidade()%>"
                         size="5"/><br/>
            Estado: 
            <select name="idGenero" id="idGenero">
                <%
                for (Genero g : generoDao.getLista()){
                    String selected = "";
                    if(livrosDao.getObjetoSelecionado().getGenero() != null){
                        selected = livrosDao.getObjetoSelecionado().getGenero().getId().equals(g.getId()) ?  "selected" : "";
                    }
                
                %>
                <option value="<%=g.getId()%>" <%=selected%> > <%=g.getDescricao()%></option>
                <%
                } 
                %>
            </select>
            
            
            <input type="button" value="Salvar" name="btnSalvar" onclick="doSalvar()"/>
            <input type="button" value="Cancelar" name="btnCancelar" onclick="doCancelar()"/>
            <input type="hidden" name="acao" id="acao" value=""/>
        </form>
    </body>
</html>