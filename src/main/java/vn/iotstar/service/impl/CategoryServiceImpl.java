package vn.iotstar.service.impl;

import java.io.File;
import java.util.List;
import vn.iotstar.dao.CategoryDao;
import vn.iotstar.dao.impl.CategoryDaoImpl;
import vn.iotstar.model.Category;
import vn.iotstar.service.CategoryService;
import vn.iotstar.util.Constant;

public class CategoryServiceImpl implements CategoryService {
    private CategoryDao categoryDao = new CategoryDaoImpl();

    @Override
    public void insert(Category category) {
        categoryDao.insert(category);
    }

    @Override
    public void edit(Category newCategory) {
        Category oldCategory = categoryDao.get(newCategory.getId());
        if (oldCategory != null) {
            oldCategory.setName(newCategory.getName());
            if (newCategory.getIcon() != null && !newCategory.getIcon().isEmpty()) {
                String oldFileName = oldCategory.getIcon();
                // Chỉ xóa file ảnh cũ khi:
                // 1. Ảnh mới KHÁC ảnh cũ (tức là người dùng thực sự upload ảnh mới thay thế)
                // 2. Không phải các ảnh mẫu mặc định hệ thống
                if (oldFileName != null && !oldFileName.isEmpty()
                        && !oldFileName.equalsIgnoreCase(newCategory.getIcon())
                        && !"ao_nam.png".equalsIgnoreCase(oldFileName)
                        && !"ao_nu.png".equalsIgnoreCase(oldFileName)
                        && !"giay_dep.png".equalsIgnoreCase(oldFileName)
                        && !"avata.png".equalsIgnoreCase(oldFileName)) {
                    File file = new File(Constant.DIR + File.separator + oldFileName);
                    if (file.exists()) {
                        file.delete();
                    }
                }
                oldCategory.setIcon(newCategory.getIcon());
            }
            categoryDao.edit(oldCategory);
        }
    }

    @Override
    public void update(Category category) {
        this.edit(category);
    }

    @Override
    public void delete(int id) {
        Category oldCategory = categoryDao.get(id);
        if (oldCategory != null) {
            String oldFileName = oldCategory.getIcon();
            if (oldFileName != null && !oldFileName.isEmpty()
                    && !"ao_nam.png".equalsIgnoreCase(oldFileName)
                    && !"ao_nu.png".equalsIgnoreCase(oldFileName)
                    && !"giay_dep.png".equalsIgnoreCase(oldFileName)
                    && !"avata.png".equalsIgnoreCase(oldFileName)) {
                File file = new File(Constant.DIR + File.separator + oldFileName);
                if (file.exists()) {
                    file.delete();
                }
            }
        }
        categoryDao.delete(id);
    }

    @Override
    public Category get(int id) {
        return categoryDao.get(id);
    }

    @Override
    public Category findById(int id) {
        return categoryDao.get(id);
    }

    @Override
    public Category get(String name) {
        return categoryDao.get(name);
    }

    @Override
    public List<Category> getAll() {
        return categoryDao.getAll();
    }

    @Override
    public List<Category> search(String keyword) {
        return categoryDao.search(keyword);
    }
}
