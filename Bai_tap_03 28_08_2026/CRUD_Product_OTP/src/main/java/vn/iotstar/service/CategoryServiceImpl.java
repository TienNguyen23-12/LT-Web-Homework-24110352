package vn.iotstar.service;

import vn.iotstar.dao.ICategoryDao;
import vn.iotstar.dao.CategoryDaoImpl;
import vn.iotstar.entity.Category;
import java.util.List;

public class CategoryServiceImpl implements ICategoryService {
    private ICategoryDao categoryDao = new CategoryDaoImpl();
    
    @Override
    public void insert(Category c) {
        categoryDao.insert(c);
    }
    
    @Override
    public void update(Category c) {
        categoryDao.update(c);
    }
    
    @Override
    public void delete(int id) throws Exception {
        categoryDao.delete(id);
    }
    
    @Override
    public Category findById(int id) {
        return categoryDao.findById(id);
    }
    
    @Override
    public List<Category> findAll() {
        return categoryDao.findAll();
    }
    
    @Override
    public int count(String keyword) {
        return categoryDao.count(keyword);
    }
    
    @Override
    public List<Category> findAllWithPagination(int page, int pageSize, String keyword) {
        return categoryDao.findAllWithPagination(page, pageSize, keyword);
    }
}
