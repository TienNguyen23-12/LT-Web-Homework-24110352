package vn.iotstar.config;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;
import vn.iotstar.entity.User;

import java.util.Date;

@WebListener
public class DataSeederListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        
        try {
            trans.begin();
            
            // 1. Fake User Admin
            Long userCount = enma.createQuery("SELECT COUNT(u) FROM User u", Long.class).getSingleResult();
            if (userCount == 0) {
                User admin = new User();
                admin.setEmail("admin@gmail.com");
                admin.setPassword("123456");
                admin.setFullname("Quản Trị Viên");
                admin.setActive(true);
                admin.setOtpCode("999999");
                enma.persist(admin);
            }

            // 2. Fake Categories & Products
            Long categoryCount = enma.createQuery("SELECT COUNT(c) FROM Category c", Long.class).getSingleResult();
            if (categoryCount == 0) {
                Category cat1 = new Category(); cat1.setCategoryname("Điện thoại"); cat1.setStatus(1);
                Category cat2 = new Category(); cat2.setCategoryname("Laptop"); cat2.setStatus(1);
                Category cat3 = new Category(); cat3.setCategoryname("Phụ kiện"); cat3.setStatus(1);
                
                enma.persist(cat1);
                enma.persist(cat2);
                enma.persist(cat3);

                Category[] categories = {cat1, cat2, cat3};
                for (int i = 1; i <= 100; i++) {
                    Product p = new Product();
                    p.setProductName("Sản phẩm mẫu số " + i);
                    p.setPrice(100000 * i);
                    p.setQuantity(50 + i);
                    p.setImages("default.jpg");
                    p.setCreateDate(new Date());
                    p.setCategory(categories[i % 3]);
                    
                    enma.persist(p);
                }
            }

            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            e.printStackTrace();
        } finally {
            enma.close();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
