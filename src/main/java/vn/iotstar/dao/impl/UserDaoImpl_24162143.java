package vn.iotstar.dao.impl;

import jakarta.persistence.EntityManager;
import vn.iotstar.dao.IUserDao_24162143;
import vn.iotstar.entity.User_24162143;
import vn.iotstar.utils.JpaConfig_24162143;

public class UserDaoImpl_24162143 implements IUserDao_24162143 {
    @Override
    public User_24162143 findByUsername(String username) {
        EntityManager em = JpaConfig_24162143.getEntityManager();
        return em.find(User_24162143.class, username);
    }

    @Override
    public void insert(User_24162143 user) {
        EntityManager em = JpaConfig_24162143.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(user);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
        } finally { em.close(); }
    }
}