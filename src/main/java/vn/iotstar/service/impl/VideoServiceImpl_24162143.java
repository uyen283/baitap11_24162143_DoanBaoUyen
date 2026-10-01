package vn.iotstar.service.impl;

import vn.iotstar.dao.IVideoDao_24162143;
import vn.iotstar.dao.impl.VideoDaoImpl_24162143;
import vn.iotstar.entity.Video_24162143;
import vn.iotstar.service.IVideoService_24162143;

import java.util.List;

public class VideoServiceImpl_24162143 implements IVideoService_24162143 {
    private IVideoDao_24162143 videoDao = new VideoDaoImpl_24162143();

    @Override public List<Video_24162143> findAll(int page, int pageSize) { return videoDao.findAll(page, pageSize); }
    @Override public int count() { return videoDao.count(); }
    @Override public Video_24162143 findById(String id) { return videoDao.findById(id); }
    @Override public void insert(Video_24162143 video) { videoDao.insert(video); }
    @Override public void update(Video_24162143 video) { videoDao.update(video); }
    @Override public void delete(String id) { videoDao.delete(id); }
    @Override public List<Video_24162143> findByCategoryId(int catId, int page, int pageSize) { return videoDao.findByCategoryId(catId, page, pageSize); }
    @Override public int countByCategoryId(int catId) { return videoDao.countByCategoryId(catId); }
}