/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


package br.edu.ifsul.dao;

import br.edu.ifsul.jpa.EntityManagerUtil;

import br.edu.ifsul.modelo.Genero;
import br.edu.ifsul.util.Util;
import java.util.List;
import java.util.Set;
import javax.persistence.EntityManager;
import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;

/**
 *
 * @author Jorge Luis Boeira Bavaresco
 * @email jorge.bavaresco@passofundo.ifsul.edu.br
 */
public class GeneroDAO {
    private Genero objetoSelecionado;
    private String mensagem = "";
    private EntityManager em;
    
    public GeneroDAO(){
        em = EntityManagerUtil.getEntityManager();
    }
        
    public boolean validaObjeto(Genero obj){
        Validator validador = Validation.buildDefaultValidatorFactory().getValidator();
        Set<ConstraintViolation<Genero>> erros =
                validador.validate(obj);
        if (erros.size() > 0){
            mensagem = "";
            mensagem += "Objeto com erros!<br/>";
            for (ConstraintViolation<Genero> erro : erros){
                mensagem += "Erro: "+erro.getMessage()+"<br/>";
            }
            return false;
        } else {
            return true;
        }
    }
    
    public List<Genero> getLista(){
        return em.createQuery("from Genero order by descricao").getResultList();
    }
    
    public boolean salvar(Genero obj){
        try {
            em.getTransaction().begin();
            if (obj.getId() == null){
                em.persist(obj);
            } else {
                em.merge(obj);
            }
            em.getTransaction().commit();
            mensagem = "Objeto persistido com sucesso!";
            return true;
        } catch (Exception e){
            if (em.getTransaction().isActive() == false){
                em.getTransaction().begin();
            }
            em.getTransaction().rollback();
            mensagem = "Erro ao persistir: "+Util.getMensagemErro(e);
            return false;
        }
    }
    
    public boolean remover(Genero obj){
        try {
            em.getTransaction().begin();
            em.remove(obj);
            em.getTransaction().commit();
            mensagem = "Objeto removido com sucesso!";
            return true;
        } catch (Exception e){
            if (em.getTransaction().isActive() == false){
                em.getTransaction().begin();
            }
            em.getTransaction().rollback();
            mensagem = "Erro ao remover objeto: "+Util.getMensagemErro(e);
            return false;
        }
    }    
    
    public Genero localizar(Integer id){
        return em.find(Genero.class, id);
    }

    public Genero getObjetoSelecionado() {
        return objetoSelecionado;
    }

    public void setObjetoSelecionado(Genero objetoSelecionado) {
        this.objetoSelecionado = objetoSelecionado;
    }

    public String getMensagem() {
        return mensagem;
    }

    public void setMensagem(String mensagem) {
        this.mensagem = mensagem;
    }

    public EntityManager getEm() {
        return em;
    }

    public void setEm(EntityManager em) {
        this.em = em;
    }
    

}
