package vn.iotstar.test;

import java.io.File;
import java.sql.Connection;
import java.util.List;
import vn.iotstar.connection.DBConnection;
import vn.iotstar.model.Category;
import vn.iotstar.model.User;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constant;

public class SystemTest {

    public static void main(String[] args) {
        System.out.println("=================================================");
        System.out.println("   BẮT ĐẦU KIỂM THỬ TOÀN DIỆN HỆ THỐNG SHOPPING MVC");
        System.out.println("=================================================");

        boolean allPassed = true;

        // 1. Kiểm tra kết nối CSDL
        System.out.println("\n[1] Kiểm tra kết nối Database (DBConnection)...");
        try {
            DBConnection db = new DBConnection();
            Connection conn = db.getConnection();
            if (conn != null && !conn.isClosed()) {
                System.out.println("  ==> ĐẠT: Kết nối Database 'ShoppingServiceMVC' thành công!");
                conn.close();
            } else {
                System.out.println("  ==> LỖI: Kết nối trả về null hoặc đã đóng.");
                allPassed = false;
            }
        } catch (Exception e) {
            System.out.println("  ==> LỖI Ngoại lệ DBConnection: " + e.getMessage());
            allPassed = false;
        }

        // 2. Kiểm tra thư mục upload ảnh
        System.out.println("\n[2] Kiểm tra thư mục upload ảnh (" + Constant.DIR + ")...");
        File uploadDir = new File(Constant.DIR);
        if (uploadDir.exists() && uploadDir.isDirectory()) {
            File[] files = uploadDir.listFiles();
            System.out.println("  ==> ĐẠT: Thư mục tồn tại, hiện có " + (files != null ? files.length : 0) + " file ảnh mẫu.");
        } else {
            System.out.println("  ==> LỖI: Thư mục " + Constant.DIR + " không tồn tại!");
            allPassed = false;
        }

        // 3. Kiểm tra Phân hệ User (Bài tập 1: Login, Session, Register)
        System.out.println("\n[3] Kiểm tra Phân hệ Người dùng (UserService & UserDao)...");
        UserService userService = new UserServiceImpl();
        try {
            // Test Login đúng
            User admin = userService.login("admin", "123456");
            if (admin != null && admin.getRoleid() == 1) {
                System.out.println("  ==> ĐẠT: Đăng nhập Admin thành công (Role ID = " + admin.getRoleid() + ", Tên: " + admin.getFullName() + ")");
            } else {
                System.out.println("  ==> LỖI: Đăng nhập admin thất bại hoặc sai Role ID!");
                allPassed = false;
            }

            // Test Login sai mật khẩu
            User wrongUser = userService.login("admin", "wrong_password");
            if (wrongUser == null) {
                System.out.println("  ==> ĐẠT: Chặn mật khẩu sai chính xác (Trả về null).");
            } else {
                System.out.println("  ==> LỖI: Cho phép đăng nhập khi sai mật khẩu!");
                allPassed = false;
            }

            // Test kiểm tra tồn tại username
            boolean existAdmin = userService.checkExistUsername("admin");
            boolean existNon = userService.checkExistUsername("user_chua_tung_ton_tai_xyz");
            if (existAdmin && !existNon) {
                System.out.println("  ==> ĐẠT: Hàm checkExistUsername hoạt động chuẩn xác.");
            } else {
                System.out.println("  ==> LỖI: Hàm checkExistUsername kiểm tra sai kết quả!");
                allPassed = false;
            }

            // Test Đăng ký người dùng mới
            String testUsername = "test_user_" + System.currentTimeMillis() % 10000;
            String testEmail = testUsername + "@gmail.com";
            boolean regSuccess = userService.register(testUsername, "pass123", testEmail, "Sinh Viên Test", "0987111222");
            if (regSuccess) {
                System.out.println("  ==> ĐẠT: Đăng ký User mới (" + testUsername + ") thành công!");
                User newUser = userService.login(testUsername, "pass123");
                if (newUser != null && newUser.getRoleid() == 5) {
                    System.out.println("  ==> ĐẠT: Đăng nhập tài khoản mới vừa tạo thành công (Role ID = " + newUser.getRoleid() + ")");
                } else {
                    System.out.println("  ==> LỖI: Không đăng nhập được vào User vừa đăng ký!");
                    allPassed = false;
                }
            } else {
                System.out.println("  ==LỖI: Đăng ký User thất bại!");
                allPassed = false;
            }
        } catch (Exception e) {
            System.out.println("  ==> LỖI Ngoại lệ UserService: " + e.getMessage());
            e.printStackTrace();
            allPassed = false;
        }

        // 4. Kiểm tra Phân hệ Category (Bài tập 2: CRUD Category)
        System.out.println("\n[4] Kiểm tra Phân hệ Danh mục (CategoryService & CategoryDao)...");
        CategoryService cateService = new CategoryServiceImpl();
        try {
            // Test Lấy danh sách (Read)
            List<Category> list = cateService.getAll();
            if (list != null && !list.isEmpty()) {
                System.out.println("  ==> ĐẠT: Lấy danh sách thành công, hiện có " + list.size() + " danh mục.");
            } else {
                System.out.println("  ==> LỖI: Danh sách danh mục rỗng!");
                allPassed = false;
            }

            // Test Thêm mới (Create)
            String testCateName = "Danh Mục Test " + (System.currentTimeMillis() % 1000);
            Category newCate = new Category(testCateName, "avata.png");
            cateService.insert(newCate);
            Category insertedCate = cateService.get(testCateName);
            if (insertedCate != null && insertedCate.getId() > 0) {
                System.out.println("  ==> ĐẠT: Thêm mới Category thành công (ID = " + insertedCate.getId() + ", Tên = " + insertedCate.getName() + ")");

                // Test Sửa (Update)
                insertedCate.setName(testCateName + " [Đã Sửa]");
                cateService.edit(insertedCate);
                Category updatedCate = cateService.get(insertedCate.getId());
                if (updatedCate != null && updatedCate.getName().endsWith("[Đã Sửa]")) {
                    System.out.println("  ==> ĐẠT: Sửa Category thành công!");
                } else {
                    System.out.println("  ==> LỖI: Sửa Category không lưu thay đổi!");
                    allPassed = false;
                }

                // Test Xóa (Delete)
                cateService.delete(insertedCate.getId());
                Category deletedCate = cateService.get(insertedCate.getId());
                if (deletedCate == null) {
                    System.out.println("  ==> ĐẠT: Xóa Category thành công (Tìm lại trả về null).");
                } else {
                    System.out.println("  ==> LỖI: Xóa Category thất bại, bản ghi vẫn còn!");
                    allPassed = false;
                }
            } else {
                System.out.println("  ==> LỖI: Thêm mới Category thất bại!");
                allPassed = false;
            }
        } catch (Exception e) {
            System.out.println("  ==> LỖI Ngoại lệ CategoryService: " + e.getMessage());
            e.printStackTrace();
            allPassed = false;
        }

        System.out.println("\n=================================================");
        if (allPassed) {
            System.out.println("   KẾT QUẢ: TẤT CẢ 4 PHÂN HỆ ĐỀU ĐẠT CHUẨN 100%!");
        } else {
            System.out.println("   KẾT QUẢ: CÓ MỘT SỐ BƯỚC CHƯA ĐẠT!");
        }
        System.out.println("=================================================");
    }
}
