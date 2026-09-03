package vn.iotstar.dao;

import jakarta.persistence.*;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.entity.Category;
import java.util.List;

public class CategoryDaoImpl implements ICategoryDao {

    @Override
    public void insert(Category c) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(c);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void update(Category c) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(c);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void delete(int id) throws Exception {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            Category c = enma.find(Category.class, id);
            if (c != null) {
                enma.remove(c);
            }
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public Category findById(int id) {
        EntityManager enma = JpaConfig.getEntityManager();
        Category c = enma.find(Category.class, id);
        enma.close();
        return c;
    }

    @Override
    public List<Category> findAll() {
        EntityManager enma = JpaConfig.getEntityManager();
        List<Category> list = enma.createQuery("SELECT c FROM Category c", Category.class).getResultList();
        enma.close();
        return list;
    }

    @Override
    public int count(String keyword) {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT COUNT(c) FROM Category c";
        if (keyword != null && !keyword.trim().isEmpty()) {
            jpql += " WHERE c.categoryname LIKE :kw";
        }
        TypedQuery<Long> query = enma.createQuery(jpql, Long.class);
        if (keyword != null && !keyword.trim().isEmpty()) {
            query.setParameter("kw", "%" + keyword + "%");
        }
        Long count = query.getSingleResult();
        enma.close();
        return count.intValue();
    }

    @Override
    public List<Category> findAllWithPagination(int page, int pageSize, String keyword) {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT c FROM Category c";
        if (keyword != null && !keyword.trim().isEmpty()) {
            jpql += " WHERE c.categoryname LIKE :kw";
        }
        jpql += " ORDER BY c.categoryId DESC";
        TypedQuery<Category> query = enma.createQuery(jpql, Category.class);
        if (keyword != null && !keyword.trim().isEmpty()) {
            query.setParameter("kw", "%" + keyword + "%");
        }
        query.setFirstResult(page * pageSize);
        query.setMaxResults(pageSize);
        List<Category> list = query.getResultList();
        enma.close();
        return list;
    }
}
