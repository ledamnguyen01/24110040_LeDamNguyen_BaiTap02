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
@WebServlet(urlPatterns = {"/video/add", "/admin/video/add"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 50,       // 50MB (tối đa cho 1 file)
    maxRequestSize = 1024 * 1024 * 100    // 100MB (tổng kích thước request)
)
public class VideoAddController extends HttpServlet {
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
        req.getRequestDispatcher("/views/video-add.jsp").include(req, resp);
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
        User user = (User) session.getAttribute("account");

        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String activeStr = req.getParameter("active");
        boolean active = "1".equals(activeStr) || "on".equals(activeStr) || "true".equalsIgnoreCase(activeStr);

        // Server-side Validation
        if (title == null || title.trim().length() < 3) {
            req.setAttribute("error", "Tiêu đề video không được để trống và phải có ít nhất 3 ký tự!");
            req.setAttribute("title", title);
            req.setAttribute("description", description);
            req.getRequestDispatcher("/views/video-add.jsp").include(req, resp);
            return;
        }

        // Dam bao thu muc upload ton tai
        File uploadDir = new File(Constant.DIR);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Xử lý upload ảnh poster bằng MultipartConfig
        String posterFileName = "default_poster.png";
        try {
            Part posterPart = req.getPart("poster");
            String origPosterName = getSubmittedFileName(posterPart);
            if (origPosterName != null && !origPosterName.trim().isEmpty()) {
                posterFileName = System.currentTimeMillis() + "_" + origPosterName;
                posterPart.write(Constant.DIR + File.separator + posterFileName);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Xử lý upload file video bằng MultipartConfig
        String videoFileName = "sample_video.mp4";
        try {
            Part videoPart = req.getPart("videoFile");
            String origVideoName = getSubmittedFileName(videoPart);
            if (origVideoName != null && !origVideoName.trim().isEmpty()) {
                videoFileName = System.currentTimeMillis() + "_" + origVideoName;
                videoPart.write(Constant.DIR + File.separator + videoFileName);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        Video newVideo = new Video(title.trim(), posterFileName, videoFileName, description, active, user.getId());
        videoService.insert(newVideo);

        resp.sendRedirect(req.getContextPath() + "/video?type=my");
    }
}
