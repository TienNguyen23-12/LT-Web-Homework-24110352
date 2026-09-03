package vn.iotstar.service;

import vn.iotstar.entity.User;

public interface IUserService {
    boolean register(String email, String password, String fullname);
    boolean verifyOtp(String email, String otp);
    User login(String email, String password);
    boolean sendForgotPasswordOtp(String email);
    void resetPassword(String email, String newPassword);
    void updateProfile(User user);
    User findByEmail(String email);
}
