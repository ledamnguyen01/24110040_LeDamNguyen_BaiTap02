package vn.iotstar.controller;

import java.io.IOException;
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
@WebServlet(urlPatterns = {"/video/delete", "/admin/video/delete"})
public class VideoDeleteController extends HttpServlet {
    private VideoService videoService = new VideoServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        User currentUser = (User) session.getAttribute("account");

        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idStr.trim());
                Video video = videoService.findById(id);
                if (video != null && (video.getUserId() == currentUser.getId() || currentUser.getRoleid() == 1)) {
                    videoService.delete(id);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        resp.sendRedirect(req.getContextPath() + "/video?type=my");
    }
}
