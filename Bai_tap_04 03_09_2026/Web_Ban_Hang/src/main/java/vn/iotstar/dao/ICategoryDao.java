package vn.iotstar.dao;

import vn.iotstar.entity.Category;
import java.util.List;

public interface ICategoryDao {
    void insert(Category c);
    void update(Category c);
    void delete(int id) throws Exception;
    Category findById(int id);
    List<Category> findAll();
    int count(String keyword);
    List<Category> findAllWithPagination(int page, int pageSize, String keyword);
}
