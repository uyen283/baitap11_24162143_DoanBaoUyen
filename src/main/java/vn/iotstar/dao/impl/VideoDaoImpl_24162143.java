package vn.iotstar.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import vn.iotstar.dao.IVideoDao_24162143;
import vn.iotstar.entity.Video_24162143;
import vn.iotstar.utils.JpaConfig_24162143;

import java.util.List;

public class VideoDaoImpl_24162143 implements IVideoDao_24162143 {
    @Override
    public List<Video_24162143> findAll(int page, int pageSize) {
        EntityManager em = JpaConfig_24162143.getEntityManager();
        TypedQuery<Video_24162143> query = em.createQuery("SELECT v FROM Video_24162143 v", Video_24162143.class);
        query.setFirstResult((page - 1) * pageSize);
        query.setMaxResults(pageSize);
        return query.getResultList();
    }

    @Override
    public int count() {
        EntityManager em = JpaConfig_24162143.getEntityManager();
        Long count = em.createQuery("SELECT COUNT(v) FROM Video_24162143 v", Long.class).getSingleResult();
        return count.intValue();
    }

    @Override
    public Video_24162143 findById(String id) {
        EntityManager em = JpaConfig_24162143.getEntityManager();
        return em.find(Video_24162143.class, id);
    }

    @Override
    public void insert(Video_24162143 video) {
        EntityManager em = JpaConfig_24162143.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(video);
            em.getTransaction().commit();
        } catch (Exception e) { em.getTransaction().rollback(); } finally { em.close(); }
    }

    @Override
    public void update(Video_24162143 video) {
        EntityManager em = JpaConfig_24162143.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(video);
            em.getTransaction().commit();
        } catch (Exception e) { em.getTransaction().rollback(); } finally { em.close(); }
    }

    @Override
    public void delete(String id) {
        EntityManager em = JpaConfig_24162143.getEntityManager();
        try {
            em.getTransaction().begin();
            Video_24162143 v = em.find(Video_24162143.class, id);
            if (v != null) em.remove(v);
            em.getTransaction().commit();
        } catch (Exception e) { em.getTransaction().rollback(); } finally { em.close(); }
    }

    @Override
    public List<Video_24162143> findByCategoryId(int catId, int page, int pageSize) {
        EntityManager em = JpaConfig_24162143.getEntityManager();
        TypedQuery<Video_24162143> query = em.createQuery("SELECT v FROM Video_24162143 v WHERE v.category.categoryId = :catId", Video_24162143.class);
        query.setParameter("catId", catId);
        query.setFirstResult((page - 1) * pageSize);
        query.setMaxResults(pageSize);
        return query.getResultList();
    }

    @Override
    public int countByCategoryId(int catId) {
        EntityManager em = JpaConfig_24162143.getEntityManager();
        Long count = em.createQuery("SELECT COUNT(v) FROM Video_24162143 v WHERE v.category.categoryId = :catId", Long.class)
                .setParameter("catId", catId)
                .getSingleResult();
        return count.intValue();
    }
}