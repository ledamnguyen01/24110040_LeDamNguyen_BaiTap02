package vn.iotstar.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.model.Video;
import vn.iotstar.service.VideoService;
import vn.iotstar.service.impl.VideoServiceImpl;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/video/detail")
public class VideoDetailController extends HttpServlet {
    private VideoService videoService = new VideoServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/video");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            // Tăng số lượt xem (views) khi người dùng bấm vào xem chi tiết
            videoService.increaseViews(id);

            Video video = videoService.findById(id);
            if (video == null) {
                resp.sendRedirect(req.getContextPath() + "/video");
                return;
            }

            // Lấy danh sách video đề xuất (top 10 video mới nhất)
            List<Video> relatedVideos = videoService.findTop10Recent();

            req.setAttribute("video", video);
            req.setAttribute("relatedVideos", relatedVideos);
            req.getRequestDispatcher("/views/video-detail.jsp").include(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/video");
        }
    }
}
