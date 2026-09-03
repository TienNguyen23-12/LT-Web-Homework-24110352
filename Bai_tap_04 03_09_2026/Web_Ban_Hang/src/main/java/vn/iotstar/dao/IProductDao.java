package vn.iotstar.dao;

import vn.iotstar.entity.Product;
import java.util.List;

public interface IProductDao {
    void insert(Product p);
    void update(Product p);
    void delete(int id) throws Exception;
    Product findById(int id);
    List<Product> findAll();
    List<Product> findTop10Newest();
    List<Product> findAllWithPagination(int page, int pageSize, String keyword);
    int count(String keyword);
}
