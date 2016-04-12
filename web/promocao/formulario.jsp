<%-- 
    Document   : formulario
    Created on : 28/03/2016, 20:42:23
    Author     : Administrador
--%>
<%@page import="br.edu.ifsul.modelo.Livros"%>
<%@page import="br.edu.ifsul.dao.PromocaoDAO"%>
<%@page import="br.edu.ifsul.dao.LivrosDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="livrosDao"
             scope="session" type="LivrosDAO"/>
<jsp:useBean id="promocaoDao"
             scope="session" type="PromocaoDAO"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Edição de Promocao</title>
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
        <h1>Edição de Promocao</h1>
        <h2><%=promocaoDao.getMensagem()%></h2>
        <form name="form" id="form" action="ServletPromocao" method="POST">
            ID: <input type="text" name="id" 
                       value="<%= promocaoDao.getObjetoSelecionado().getId() == null
                               ?"" : promocaoDao.getObjetoSelecionado().getId()%>"
                                size="6" readonly/><br/>
            Descricao <input type="text" name="descricao"
                         value="<%= promocaoDao.getObjetoSelecionado().getDescricao()== null
                         ? "" : promocaoDao.getObjetoSelecionado().getDescricao()%>"
                         size="40"/><br/>
         
            Valor: <input type="text" name="valor"
                         value="<%= promocaoDao.getObjetoSelecionado().getValor()== null
                         ? "" : promocaoDao.getObjetoSelecionado().getValor()%>"
                         size="5"/><br/>
        
            Estado: 
            <select name="idLivros" id="idLivros">
                <%
                for (Livros g : livrosDao.getLista()){
                    String selected = "";
                    if(promocaoDao.getObjetoSelecionado().getLivros() != null){
                        selected = promocaoDao.getObjetoSelecionado().getLivros().getId().equals(g.getId()) ?  "selected" : "";
                    }
                
                %>
                <option value="<%=g.getId()%>" <%=selected%> > <%=g.getTitulo()%></option>
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