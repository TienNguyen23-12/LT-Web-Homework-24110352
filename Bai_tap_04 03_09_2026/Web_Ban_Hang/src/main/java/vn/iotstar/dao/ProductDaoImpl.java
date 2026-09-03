package vn.iotstar.dao;

import jakarta.persistence.*;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.entity.Product;
import java.util.List;

public class ProductDaoImpl implements IProductDao {
    @Override
    public void insert(Product p) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(p);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void update(Product p) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(p);
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
            Product p = enma.find(Product.class, id);
            if (p != null) {
                enma.remove(p);
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
    public Product findById(int id) {
        EntityManager enma = JpaConfig.getEntityManager();
        Product product = enma.find(Product.class, id);
        enma.close();
        return product;
    }

    @Override
    public List<Product> findAll() {
        EntityManager enma = JpaConfig.getEntityManager();
        List<Product> list = enma.createNamedQuery("Product.findAll", Product.class).getResultList();
        enma.close();
        return list;
    }

    @Override
    public List<Product> findTop10Newest() {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT p FROM Product p ORDER BY p.createDate DESC"; 
        TypedQuery<Product> query = enma.createQuery(jpql, Product.class);
        query.setMaxResults(10);
        List<Product> list = query.getResultList();
        enma.close();
        return list;
    }

    @Override
    public List<Product> findAllWithPagination(int page, int pageSize, String keyword) {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT p FROM Product p";
        if (keyword != null && !keyword.trim().isEmpty()) {
            jpql += " WHERE p.productName LIKE :kw";
        }
        jpql += " ORDER BY p.productId DESC";
        TypedQuery<Product> query = enma.createQuery(jpql, Product.class);
        if (keyword != null && !keyword.trim().isEmpty()) {
            query.setParameter("kw", "%" + keyword + "%");
        }
        query.setFirstResult(page * pageSize);
        query.setMaxResults(pageSize);
        List<Product> list = query.getResultList();
        enma.close();
        return list;
    }

    @Override
    public int count(String keyword) {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT COUNT(p) FROM Product p";
        if (keyword != null && !keyword.trim().isEmpty()) {
            jpql += " WHERE p.productName LIKE :kw";
        }
        TypedQuery<Long> query = enma.createQuery(jpql, Long.class);
        if (keyword != null && !keyword.trim().isEmpty()) {
            query.setParameter("kw", "%" + keyword + "%");
        }
        Long count = query.getSingleResult();
        enma.close();
        return count.intValue();
    }
}
