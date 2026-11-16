package vn.iotstar.dao;

import vn.iotstar.model.User;

public interface UserDao {
    User get(String username);
    User findByEmail(String email);
    void insert(User user);
    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);
    void updateCode(String email, String code);
    void activateUser(String email);
    void updatePassword(String email, String newPassword);
}
