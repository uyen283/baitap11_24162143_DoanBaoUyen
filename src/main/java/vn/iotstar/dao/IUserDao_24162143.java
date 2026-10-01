package vn.iotstar.dao;
import vn.iotstar.entity.User_24162143;

public interface IUserDao_24162143 {
    User_24162143 findByUsername(String username);
    void insert(User_24162143 user);
}