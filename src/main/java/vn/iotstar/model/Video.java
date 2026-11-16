package vn.iotstar.model;

import java.io.Serializable;
import java.sql.Timestamp;

@SuppressWarnings("serial")
public class Video implements Serializable {
    private int videoId;
    private String title;
    private String poster;
    private String videoFile;
    private int views;
    private String description;
    private boolean active;
    private Timestamp createDate;
    private int userId;
    private User user; // Đối tượng tác giả đăng video

    public Video() {
        this.active = true;
        this.views = 0;
    }

    public Video(String title, String poster, String videoFile, String description, boolean active, int userId) {
        this.title = title;
        this.poster = poster;
        this.videoFile = videoFile;
        this.description = description;
        this.active = active;
        this.userId = userId;
        this.views = 0;
    }

    public int getVideoId() {
        return videoId;
    }

    public void setVideoId(int videoId) {
        this.videoId = videoId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    public String getVideoFile() {
        return videoFile;
    }

    public void setVideoFile(String videoFile) {
        this.videoFile = videoFile;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "Video [videoId=" + videoId + ", title=" + title + ", views=" + views + ", userId=" + userId + "]";
    }
}
