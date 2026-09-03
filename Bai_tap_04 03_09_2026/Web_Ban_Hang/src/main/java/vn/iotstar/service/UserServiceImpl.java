package vn.iotstar.service;

import vn.iotstar.dao.IUserDao;
import vn.iotstar.dao.UserDaoImpl;
import vn.iotstar.entity.User;
import vn.iotstar.utils.EmailUtils;

public class UserServiceImpl implements IUserService {
    private IUserDao userDao = new UserDaoImpl();

    @Override
    public boolean register(String email, String password, String fullname) {
        if (userDao.findByEmail(email) != null) {
            return false;
        }

        User user = new User();
        user.setEmail(email);
        user.setPassword(password);
        user.setFullname(fullname);

        String otp = String.valueOf((int)(Math.random() * 900000) + 100000);
        user.setOtpCode(otp);
        user.setActive(false);

        userDao.insert(user);

        EmailUtils.sendEmail(email, "Mã xác thực OTP của bạn", "Mã OTP của bạn là: " + otp);
        return true;
    }

    @Override
    public boolean verifyOtp(String email, String otp) {
        User user = userDao.findByEmail(email);
        if (user != null && user.getOtpCode().equals(otp)) {
            user.setActive(true);
            userDao.update(user);
            return true;
        }
        return false;
    }

    @Override
    public User login(String email, String password) {
        User user = userDao.findByEmail(email);
        if (user != null && user.getPassword().equals(password) && user.isActive()) {
            return user;
        }
        return null;
    }

    @Override
    public boolean sendForgotPasswordOtp(String email) {
        User user = userDao.findByEmail(email);
        if (user == null) {
            return false;
        }

        String otp = String.valueOf((int)(Math.random() * 900000) + 100000);
        user.setOtpCode(otp);
        userDao.update(user);

        EmailUtils.sendEmail(email, "Reset Password OTP", "Mã OTP mới của bạn là: " + otp);
        return true;
    }

    @Override
    public void resetPassword(String email, String newPassword) {
        User user = userDao.findByEmail(email);
        if (user != null) {
            user.setPassword(newPassword);
            userDao.update(user);
        }
    }

    @Override
    public void updateProfile(User user) {
        userDao.update(user);
    }
}
