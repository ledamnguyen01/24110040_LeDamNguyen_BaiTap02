package vn.iotstar.service.impl;

import java.util.List;
import vn.iotstar.dao.VideoDao;
import vn.iotstar.dao.impl.VideoDaoImpl;
import vn.iotstar.model.Video;
import vn.iotstar.service.VideoService;

public class VideoServiceImpl implements VideoService {
    private VideoDao videoDao = new VideoDaoImpl();

    @Override
    public void insert(Video video) {
        videoDao.insert(video);
    }

    @Override
    public void update(Video video) {
        videoDao.update(video);
    }

    @Override
    public void delete(int videoId) {
        videoDao.delete(videoId);
    }

    @Override
    public Video findById(int videoId) {
        return videoDao.findById(videoId);
    }

    @Override
    public List<Video> findAll() {
        return videoDao.findAll();
    }

    @Override
    public List<Video> findTop10Recent() {
        return videoDao.findTop10Recent();
    }

    @Override
    public List<Video> findByUserId(int userId, int page, int pageSize) {
        return videoDao.findByUserId(userId, page, pageSize);
    }

    @Override
    public int countByUserId(int userId) {
        return videoDao.countByUserId(userId);
    }

    @Override
    public List<Video> findAllPaging(int page, int pageSize) {
        return videoDao.findAllPaging(page, pageSize);
    }

    @Override
    public int countAll() {
        return videoDao.countAll();
    }

    @Override
    public void increaseViews(int videoId) {
        videoDao.increaseViews(videoId);
    }
}
