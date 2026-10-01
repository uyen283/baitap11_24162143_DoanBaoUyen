package vn.iotstar.service.impl;

import vn.iotstar.dao.IUserDao_24162143;
import vn.iotstar.dao.impl.UserDaoImpl_24162143;
import vn.iotstar.entity.User_24162143;
import vn.iotstar.service.IUserService_24162143;

public class UserServiceImpl_24162143 implements IUserService_24162143 {
    private IUserDao_24162143 userDao = new UserDaoImpl_24162143();

    @Override
    public User_24162143 login(String username, String password) {
        User_24162143 user = userDao.findByUsername(username);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }

    @Override
    public void register(User_24162143 user) {
        userDao.insert(user);
    }
}