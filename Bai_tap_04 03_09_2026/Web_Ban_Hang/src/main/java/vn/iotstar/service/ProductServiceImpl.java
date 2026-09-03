package vn.iotstar.service;

import vn.iotstar.dao.IProductDao;
import vn.iotstar.dao.ProductDaoImpl;
import vn.iotstar.entity.Product;
import java.util.List;

public class ProductServiceImpl implements IProductService {
    private IProductDao productDao = new ProductDaoImpl();

    @Override
    public void insert(Product p) {
        productDao.insert(p);
    }

    @Override
    public void update(Product p) {
        productDao.update(p);
    }

    @Override
    public void delete(int id) throws Exception {
        productDao.delete(id);
    }

    @Override
    public Product findById(int id) {
        return productDao.findById(id);
    }

    @Override
    public List<Product> findAll() {
        return productDao.findAll();
    }

    @Override
    public List<Product> findTop10Newest() {
        return productDao.findTop10Newest();
    }

    @Override
    public List<Product> findAllWithPagination(int page, int pageSize, String keyword) {
        return productDao.findAllWithPagination(page, pageSize, keyword);
    }

    @Override
    public int count(String keyword) {
        return productDao.count(keyword);
    }
}