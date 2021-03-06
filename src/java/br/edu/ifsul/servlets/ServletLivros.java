package br.edu.ifsul.servlets;

import br.edu.ifsul.dao.LivrosDAO;
import br.edu.ifsul.dao.GeneroDAO;
import br.edu.ifsul.modelo.Livros;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author jorge
 */
@WebServlet(name = "ServletLivros", urlPatterns = {"/livros/ServletLivros"})
public class ServletLivros extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LivrosDAO dao = (LivrosDAO) request.getSession().getAttribute("livrosDao");
        if (dao == null){
            dao = new LivrosDAO();
        }
        GeneroDAO daoGenero = (GeneroDAO) request.getSession().getAttribute("generoDAO");
        if(daoGenero == null){
            daoGenero = new GeneroDAO();
        }
        
        String tela = "";
        String acao = request.getParameter("acao");
        if (acao == null){
            tela = "listar.jsp";
        } else if (acao.equals("incluir")){
            dao.setObjetoSelecionado(new Livros());
            dao.setMensagem("");
            tela = "formulario.jsp";
        } else if (acao.equals("alterar")){
            Integer id = Integer.parseInt(request.getParameter("id"));
            dao.setObjetoSelecionado(dao.localizar(id));
            dao.setMensagem("");
            tela = "formulario.jsp";            
        } else  if (acao.equals("excluir")){
            Integer id = Integer.parseInt(request.getParameter("id"));
            Livros obj = dao.localizar(id);
            if (obj != null){
                dao.remover(obj);                
            }
            tela = "listar.jsp";
        } else  if (acao.equals("salvar")){
            Integer id = null;
            try {
                id = Integer.parseInt(request.getParameter("id"));
            } catch (Exception e){
                dao.setMensagem("Erro ao converter o ID");
            }
            Integer idGenero = null;
            try {
                idGenero = Integer.parseInt(request.getParameter("idGenero"));
            } catch (Exception e) {
                dao.setMensagem("Erro ao converter o ID do genero");
            }
            dao.getObjetoSelecionado().setId(id);
            dao.getObjetoSelecionado().setTitulo(request.getParameter("titulo"));
            dao.getObjetoSelecionado().setAutor(request.getParameter("autor"));
            dao.getObjetoSelecionado().setQuantidade(Double.parseDouble(request.getParameter("quantidade")));
            dao.getObjetoSelecionado().setValorUnitario(Double.parseDouble(request.getParameter("valorUnitario")));            
            dao.getObjetoSelecionado().setGenero(daoGenero.localizar(idGenero));
            if (dao.validaObjeto(dao.getObjetoSelecionado())){
                dao.salvar(dao.getObjetoSelecionado());
                tela = "listar.jsp";
            } else {
                tela = "formulario.jsp";
            }
        } else if (acao.equals("cancelar")){
            dao.setMensagem("");
            tela = "listar.jsp";
        }
        // atualizar o dao na sessão
        request.getSession().setAttribute("livrosDao", dao);
        request.getSession().setAttribute("generoDao", daoGenero);
        // redireciono para a tela desejada
        response.sendRedirect(tela);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}