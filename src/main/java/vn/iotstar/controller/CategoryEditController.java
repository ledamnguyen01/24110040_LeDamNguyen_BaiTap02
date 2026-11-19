package vn.iotstar.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.iotstar.model.Category;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.util.Constant;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/admin/category/edit" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
                 maxFileSize = 1024 * 1024 * 5,
                 maxRequestSize = 1024 * 1024 * 5 * 5)
public class CategoryEditController extends HttpServlet {
    private CategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                Category category = cateService.get(id);
                req.setAttribute("category", category);
                RequestDispatcher dispatcher = req.getRequestDispatcher("/views/admin/edit-category.jsp");
                dispatcher.include(req, resp);
                return;
            } catch (Exception e) {}
        }
        resp.sendRedirect(req.getContextPath() + "/admin/category/list");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String idStr = req.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            idStr = req.getParameter("cateid");
        }
        int cateid = Integer.parseInt(idStr);
        String categoryname = req.getParameter("catename");

        // Server-side Validation
        if (categoryname == null || categoryname.trim().length() < 2) {
            req.setAttribute("error", "Tên danh mục không được để trống và phải từ 2 ký tự trở lên!");
            Category cat = cateService.get(cateid);
            if (cat != null) {
                cat.setName(categoryname);
            }
            req.setAttribute("category", cat);
            req.getRequestDispatcher("/views/admin/edit-category.jsp").include(req, resp);
            return;
        }

        Category category = new Category();
        category.setId(cateid);
        category.setName(categoryname.trim());

        Category cateold = cateService.get(cateid);
        String fileold = (cateold != null && cateold.getIcon() != null && !cateold.getIcon().isEmpty()) 
                ? cateold.getIcon() : req.getParameter("oldIcon");
        if (fileold == null || fileold.isEmpty()) {
            fileold = "avata.png";
        }

        String uploadPath = Constant.DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String fname = fileold;
        try {
            Part part = req.getPart("icon");
            if (part == null || part.getSize() == 0 || part.getSubmittedFileName() == null || part.getSubmittedFileName().trim().isEmpty()) {
                part = req.getPart("images");
            }
            if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().trim().isEmpty()) {
                String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                int index = filename.lastIndexOf(".");
                String ext = (index >= 0) ? filename.substring(index + 1) : "png";
                fname = System.currentTimeMillis() + "." + ext;
                part.write(uploadPath + File.separator + fname);
                category.setIcon(fname);
            } else {
                category.setIcon(fileold);
            }
        } catch (Exception e) {
            e.printStackTrace();
            category.setIcon(fileold);
        }

        cateService.edit(category);
        resp.sendRedirect(req.getContextPath() + "/admin/category/list");
    }
}
