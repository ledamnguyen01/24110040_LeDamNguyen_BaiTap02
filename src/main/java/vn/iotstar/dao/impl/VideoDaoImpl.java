package vn.iotstar.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import vn.iotstar.connection.DBConnection;
import vn.iotstar.dao.VideoDao;
import vn.iotstar.model.User;
import vn.iotstar.model.Video;

public class VideoDaoImpl implements VideoDao {
    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    private Video extractVideo(ResultSet rs) throws Exception {
        Video video = new Video();
        video.setVideoId(rs.getInt("videoId"));
        video.setTitle(rs.getString("title"));
        video.setPoster(rs.getString("poster"));
        video.setVideoFile(rs.getString("videoFile"));
        video.setViews(rs.getInt("views"));
        video.setDescription(rs.getString("description"));
        video.setActive(rs.getBoolean("active"));
        video.setCreateDate(rs.getTimestamp("createDate"));
        video.setUserId(rs.getInt("userId"));

        // Nếu câu query có join với bảng [User]
        try {
            if (rs.getString("username") != null) {
                User user = new User();
                user.setId(rs.getInt("userId"));
                user.setUserName(rs.getString("username"));
                user.setFullName(rs.getString("fullname"));
                user.setEmail(rs.getString("email"));
                video.setUser(user);
            }
        } catch (Exception e) {}

        return video;
    }

    @Override
    public void insert(Video video) {
        String sql = "INSERT INTO Videos(title, poster, videoFile, views, description, active, createDate, userId) VALUES (?, ?, ?, ?, ?, ?, GETDATE(), ?)";
        try {
            conn = new DBConnection().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, video.getTitle());
            ps.setString(2, video.getPoster());
            ps.setString(3, video.getVideoFile());
            ps.setInt(4, video.getViews());
            ps.setString(5, video.getDescription());
            ps.setBoolean(6, video.isActive());
            ps.setInt(7, video.getUserId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
    }

    @Override
    public void update(Video video) {
        String sql = "UPDATE Videos SET title = ?, poster = ?, videoFile = ?, description = ?, active = ? WHERE videoId = ?";
        try {
            conn = new DBConnection().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, video.getTitle());
            ps.setString(2, video.getPoster());
            ps.setString(3, video.getVideoFile());
            ps.setString(4, video.getDescription());
            ps.setBoolean(5, video.isActive());
            ps.setInt(6, video.getVideoId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
    }

    @Override
    public void delete(int videoId) {
        String sql = "DELETE FROM Videos WHERE videoId = ?";
        try {
            conn = new DBConnection().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, videoId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
    }

    @Override
    public Video findById(int videoId) {
        String sql = "SELECT v.*, u.username, u.fullname, u.email FROM Videos v LEFT JOIN [User] u ON v.userId = u.id WHERE v.videoId = ?";
        try {
            conn = new DBConnection().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, videoId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return extractVideo(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return null;
    }

    @Override
    public List<Video> findAll() {
        List<Video> list = new ArrayList<>();
        String sql = "SELECT v.*, u.username, u.fullname, u.email FROM Videos v LEFT JOIN [User] u ON v.userId = u.id ORDER BY v.videoId DESC";
        try {
            conn = new DBConnection().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractVideo(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return list;
    }

    @Override
    public List<Video> findTop10Recent() {
        List<Video> list = new ArrayList<>();
        String sql = "SELECT TOP 10 v.*, u.username, u.fullname, u.email FROM Videos v LEFT JOIN [User] u ON v.userId = u.id WHERE v.active = 1 ORDER BY v.createDate DESC";
        try {
            conn = new DBConnection().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractVideo(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return list;
    }

    @Override
    public List<Video> findByUserId(int userId, int page, int pageSize) {
        List<Video> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        String sql = "SELECT v.*, u.username, u.fullname, u.email FROM Videos v LEFT JOIN [User] u ON v.userId = u.id WHERE v.userId = ? ORDER BY v.videoId DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            conn = new DBConnection().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, offset);
            ps.setInt(3, pageSize);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractVideo(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return list;
    }

    @Override
    public int countByUserId(int userId) {
        String sql = "SELECT COUNT(*) FROM Videos WHERE userId = ?";
        try {
            conn = new DBConnection().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return 0;
    }

    @Override
    public List<Video> findAllPaging(int page, int pageSize) {
        List<Video> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        String sql = "SELECT v.*, u.username, u.fullname, u.email FROM Videos v LEFT JOIN [User] u ON v.userId = u.id WHERE v.active = 1 ORDER BY v.createDate DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            conn = new DBConnection().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, offset);
            ps.setInt(2, pageSize);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractVideo(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return list;
    }

    @Override
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM Videos WHERE active = 1";
        try {
            conn = new DBConnection().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return 0;
    }

    @Override
    public void increaseViews(int videoId) {
        String sql = "UPDATE Videos SET views = views + 1 WHERE videoId = ?";
        try {
            conn = new DBConnection().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, videoId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
    }

    private void closeResources() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (Exception ex) {}
    }
}
