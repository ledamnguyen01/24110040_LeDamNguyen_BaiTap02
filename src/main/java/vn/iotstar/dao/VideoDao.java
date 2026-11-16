package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.model.Video;

public interface VideoDao {
    void insert(Video video);
    void update(Video video);
    void delete(int videoId);
    Video findById(int videoId);
    List<Video> findAll();
    List<Video> findTop10Recent();
    List<Video> findByUserId(int userId, int page, int pageSize);
    int countByUserId(int userId);
    List<Video> findAllPaging(int page, int pageSize);
    int countAll();
    void increaseViews(int videoId);
}
