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

        String idStr = req.getParameter("id");
        if (idStr != null) {
            int id = Integer.parseInt(idStr);
            Video video = videoService.findById(id);
            req.setAttribute("video", video);
            req.getRequestDispatcher("/views/video-edit.jsp").forward(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/video");
        }
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

        int videoId = Integer.parseInt(req.getParameter("videoId"));
        Video existingVideo = videoService.findById(videoId);
        if (existingVideo == null) {
            resp.sendRedirect(req.getContextPath() + "/video");
            return;
        }

        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String activeStr = req.getParameter("active");
        boolean active = "1".equals(activeStr) || "on".equals(activeStr) || "true".equalsIgnoreCase(activeStr);

        existingVideo.setTitle(title);
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
