package br.edu.ifsul.servlets;

import br.edu.ifsul.dao.PromocaoDAO;
import br.edu.ifsul.dao.LivrosDAO;
import br.edu.ifsul.modelo.Promocao;
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
@WebServlet(name = "ServletPromocao", urlPatterns = {"/promocao/ServletPromocao"})
public class ServletPromoca extends HttpServlet {

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
        PromocaoDAO dao = (PromocaoDAO) request.getSession().getAttribute("promocaoDao");
        if (dao == null){
            dao = new PromocaoDAO();
        }
        LivrosDAO daoLivros = (LivrosDAO) request.getSession().getAttribute("livrosDAO");
        if(daoLivros == null){
            daoLivros = new LivrosDAO();
        }
        
        String tela = "";
        String acao = request.getParameter("acao");
        if (acao == null){
            tela = "listar.jsp";
        } else if (acao.equals("incluir")){
            dao.setObjetoSelecionado(new Promocao());
            dao.setMensagem("");
            tela = "formulario.jsp";
        } else if (acao.equals("alterar")){
            Integer id = Integer.parseInt(request.getParameter("id"));
            dao.setObjetoSelecionado(dao.localizar(id));
            dao.setMensagem("");
            tela = "formulario.jsp";            
        } else  if (acao.equals("excluir")){
            Integer id = Integer.parseInt(request.getParameter("id"));
            Promocao obj = dao.localizar(id);
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
            Integer idLivros = null;
            try {
                idLivros = Integer.parseInt(request.getParameter("idLivros"));
            } catch (Exception e) {
                dao.setMensagem("Erro ao converter o ID do livro");
            }
            dao.getObjetoSelecionado().setId(id);
            dao.getObjetoSelecionado().setDescricao(request.getParameter("descricao"));            
            dao.getObjetoSelecionado().setValor(Double.parseDouble(request.getParameter("valor")));            
            dao.getObjetoSelecionado().setLivros(daoLivros.localizar(idLivros));
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
        request.getSession().setAttribute("promocaoDao", dao);
        request.getSession().setAttribute("livrosDao", daoLivros);
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