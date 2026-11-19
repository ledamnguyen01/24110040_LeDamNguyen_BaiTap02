package vn.iotstar.service;

import vn.iotstar.model.User;

public interface UserService {
    User login(String username, String password);
    User get(String username);
    User findByEmail(String email);
    User findById(int id);
    void insert(User user);
    boolean register(String username, String password, String email, String fullname, String phone);
    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);
    boolean verifyOtp(String email, String otp);
    boolean forgotPassword(String email);
    boolean resetPassword(String email, String otp, String newPassword);
    boolean updateProfile(User user);
    boolean requestUpdateEmail(int userId, String newEmail, String fullname);
    boolean confirmUpdateEmail(int userId, String newEmail, String otp);
}
