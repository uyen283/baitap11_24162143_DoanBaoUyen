package vn.iotstar.service;
import vn.iotstar.entity.User_24162143;

public interface IUserService_24162143 {
    User_24162143 login(String username, String password);
    void register(User_24162143 user);
}