package vn.iotstar.dao;

import vn.iotstar.entity.Video_24162143;
import java.util.List;

public interface IVideoDao_24162143 {
    List<Video_24162143> findAll(int page, int pageSize);
    int count();
    Video_24162143 findById(String id);
    void insert(Video_24162143 video);
    void update(Video_24162143 video);
    void delete(String id);
    List<Video_24162143> findByCategoryId(int catId, int page, int pageSize);
    int countByCategoryId(int catId);
}