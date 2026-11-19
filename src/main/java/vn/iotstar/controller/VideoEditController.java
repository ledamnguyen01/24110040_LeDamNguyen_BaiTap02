package vn.iotstar.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.iotstar.model.User;
import vn.iotstar.model.Video;
import vn.iotstar.service.VideoService;
import vn.iotstar.service.impl.VideoServiceImpl;
import vn.iotstar.util.Constant;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = {"/video/edit", "/admin/video/edit"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 50,       // 50MB
    maxRequestSize = 1024 * 1024 * 100    // 100MB
)
public class VideoEditController extends HttpServlet {
    private VideoService videoService = new VideoServiceImpl();

    private String getSubmittedFileName(Part part) {
        if (part == null) return "";
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                String fileName = content.substring(content.indexOf("=") + 2, content.length() - 1);
                return Paths.get(fileName).getFileName().toString();
            }
        }
        return "";
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        User currentUser = (User) session.getAttribute("account");

        String idStr = req.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr.trim());
                Video video = videoService.findById(id);
                if (video != null && (video.getUserId() == currentUser.getId() || currentUser.getRoleid() == 1)) {
                    req.setAttribute("video", video);
                    req.getRequestDispatcher("/views/video-edit.jsp").include(req, resp);
                    return;
                }
            } catch (Exception e) {}
        }
        resp.sendRedirect(req.getContextPath() + "/video");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        User currentUser = (User) session.getAttribute("account");

        int videoId;
        try {
            videoId = Integer.parseInt(req.getParameter("videoId").trim());
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/video");
            return;
        }

        Video existingVideo = videoService.findById(videoId);
        if (existingVideo == null || (existingVideo.getUserId() != currentUser.getId() && currentUser.getRoleid() != 1)) {
            resp.sendRedirect(req.getContextPath() + "/video");
            return;
        }

        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String activeStr = req.getParameter("active");
        boolean active = "1".equals(activeStr) || "on".equals(activeStr) || "true".equalsIgnoreCase(activeStr);

        // Server-side Validation
        if (title == null || title.trim().length() < 3 || title.trim().length() > 255) {
            req.setAttribute("error", "Tiêu đề video không được để trống và phải từ 3 đến 255 ký tự!");
            existingVideo.setTitle(title);
            existingVideo.setDescription(description);
            req.setAttribute("video", existingVideo);
            req.getRequestDispatcher("/views/video-edit.jsp").include(req, resp);
            return;
        }

        existingVideo.setTitle(title.trim());
        existingVideo.setDescription(description);
        existingVideo.setActive(active);

        // Upload poster mới nếu có
        try {
            Part posterPart = req.getPart("poster");
            String origPosterName = getSubmittedFileName(posterPart);
            if (origPosterName != null && !origPosterName.trim().isEmpty()) {
                String posterFileName = System.currentTimeMillis() + "_" + origPosterName;
                posterPart.write(Constant.DIR + File.separator + posterFileName);
                existingVideo.setPoster(posterFileName);
            }
        } catch (Exception e) {}

        // Upload file video mới nếu có
        try {
            Part videoPart = req.getPart("videoFile");
            String origVideoName = getSubmittedFileName(videoPart);
            if (origVideoName != null && !origVideoName.trim().isEmpty()) {
                String videoFileName = System.currentTimeMillis() + "_" + origVideoName;
                videoPart.write(Constant.DIR + File.separator + videoFileName);
                existingVideo.setVideoFile(videoFileName);
            }
        } catch (Exception e) {}

        videoService.update(existingVideo);
        resp.sendRedirect(req.getContextPath() + "/video?type=my");
    }
}
