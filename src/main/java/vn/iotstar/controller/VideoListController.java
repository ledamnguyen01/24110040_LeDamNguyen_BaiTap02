package vn.iotstar.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.model.User;
import vn.iotstar.model.Video;
import vn.iotstar.service.VideoService;
import vn.iotstar.service.impl.VideoServiceImpl;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/video")
public class VideoListController extends HttpServlet {
    private VideoService videoService = new VideoServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        int pageSize = 6; // Yêu cầu đề bài: phân trang 6sp/trang
        try {
            String pageStr = req.getParameter("page");
            if (pageStr != null && !pageStr.trim().isEmpty()) {
                page = Integer.parseInt(pageStr);
                if (page < 1) page = 1;
            }
        } catch (Exception e) {
            page = 1;
        }

        HttpSession session = req.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("account") : null;

        String type = req.getParameter("type");
        if (type == null) {
            // Mặc định: nếu đã đăng nhập thì ưu tiên hiển thị video của user đó
            type = (currentUser != null) ? "my" : "all";
        }

        List<Video> videoList;
        int totalVideos;

        if ("my".equals(type) && currentUser != null) {
            // Hiển thị tất cả video của user (phân trang 6sp/trang)
            videoList = videoService.findByUserId(currentUser.getId(), page, pageSize);
            totalVideos = videoService.countByUserId(currentUser.getId());
        } else {
            // Hiển thị danh sách video hệ thống (phân trang 6sp/trang)
            type = "all";
            videoList = videoService.findAllPaging(page, pageSize);
            totalVideos = videoService.countAll();
        }

        int totalPages = (int) Math.ceil((double) totalVideos / pageSize);
        if (totalPages < 1) totalPages = 1;

        req.setAttribute("videoList", videoList);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalVideos", totalVideos);
        req.setAttribute("filterType", type);

        req.getRequestDispatcher("/views/video-list.jsp").include(req, resp);
    }
}
