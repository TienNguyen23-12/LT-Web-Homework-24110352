package vn.iotstar.dao;

import jakarta.persistence.*;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.entity.User;

public class UserDaoImpl implements IUserDao {
    @Override
    public void insert(User user) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(user);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void update(User user) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(user);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public User findByEmail(String email) {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT u FROM User u WHERE u.email = :email";
        try {
            TypedQuery<User> query = enma.createQuery(jpql, User.class);
            query.setParameter("email", email);
            java.util.List<User> list = query.getResultList();
            if (list != null && !list.isEmpty()) {
                return list.get(0);
            }
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            enma.close();
        }
    }
}
