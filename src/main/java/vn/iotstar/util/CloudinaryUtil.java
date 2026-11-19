package vn.iotstar.util;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import java.io.File;
import java.util.Map;

public class CloudinaryUtil {
    private static Cloudinary cloudinary;

    public static synchronized boolean isConfigured() {
        return getInstance() != null;
    }

    public static synchronized Cloudinary getInstance() {
        if (cloudinary != null) {
            return cloudinary;
        }

        // Hỗ trợ cấu hình nhanh bằng 1 chuỗi CLOUDINARY_URL=cloudinary://api_key:api_secret@cloud_name
        String cloudinaryUrl = AppConfig.get("CLOUDINARY_URL", "cloudinary.url");
        if (cloudinaryUrl != null && cloudinaryUrl.startsWith("cloudinary://")) {
            cloudinary = new Cloudinary(cloudinaryUrl);
            cloudinary.config.secure = true;
            return cloudinary;
        }

        String cloudName = AppConfig.get("CLOUDINARY_CLOUD_NAME", "cloudinary.cloud_name");
        String apiKey = AppConfig.get("CLOUDINARY_API_KEY", "cloudinary.api_key");
        String apiSecret = AppConfig.get("CLOUDINARY_API_SECRET", "cloudinary.api_secret");

        if (cloudName == null || apiKey == null || apiSecret == null) {
            return null;
        }

        cloudinary = new Cloudinary(ObjectUtils.asMap(
            "cloud_name", cloudName,
            "api_key", apiKey,
            "api_secret", apiSecret,
            "secure", true
        ));
        return cloudinary;
    }

    /**
     * Upload byte array lên Cloudinary và trả về URL ảnh an toàn (secure_url)
     */
    @SuppressWarnings("rawtypes")
    public static String uploadBytes(byte[] bytes, String publicId) {
        Cloudinary instance = getInstance();
        if (instance == null) {
            System.out.println(">>> [CloudinaryUtil] Chưa cấu hình thông tin Cloudinary (config-local.properties / env), sử dụng lưu trữ local fallback.");
            return null;
        }
        try {
            Map params = ObjectUtils.asMap(
                "public_id", "avatar_" + publicId + "_" + System.currentTimeMillis(),
                "overwrite", true,
                "resource_type", "image",
                "folder", "shopping_mvc_avatars"
            );
            Map uploadResult = instance.uploader().upload(bytes, params);
            if (uploadResult != null && uploadResult.containsKey("secure_url")) {
                String url = (String) uploadResult.get("secure_url");
                System.out.println(">>> [CloudinaryUtil] Upload thành công: " + url);
                return url;
            }
        } catch (Exception e) {
            System.err.println(">>> [CloudinaryUtil] Upload thất bại: " + e.getMessage());
        }
        return null;
    }

    /**
     * Upload File lên Cloudinary
     */
    @SuppressWarnings("rawtypes")
    public static String uploadFile(File file) {
        Cloudinary instance = getInstance();
        if (instance == null) {
            return null;
        }
        try {
            Map params = ObjectUtils.asMap(
                "folder", "shopping_mvc_avatars",
                "resource_type", "image"
            );
            Map uploadResult = instance.uploader().upload(file, params);
            if (uploadResult != null && uploadResult.containsKey("secure_url")) {
                return (String) uploadResult.get("secure_url");
            }
        } catch (Exception e) {
            System.err.println(">>> [CloudinaryUtil] File upload thất bại: " + e.getMessage());
        }
        return null;
    }
}
