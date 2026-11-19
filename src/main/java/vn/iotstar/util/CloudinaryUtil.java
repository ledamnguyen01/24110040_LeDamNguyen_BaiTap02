package vn.iotstar.util;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import java.io.File;
import java.io.InputStream;
import java.util.Map;

public class CloudinaryUtil {
    private static Cloudinary cloudinary;

    public static Cloudinary getInstance() {
        if (cloudinary == null) {
            // Cấu hình Cloudinary (Cloud Name, API Key, API Secret)
            cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", "dhup5jdrf",
                "api_key", "474932911475141",
                "api_secret", "aH9q6G8YgU3L5yQk5p_9lJmZ1xQ",
                "secure", true
            ));
        }
        return cloudinary;
    }

    /**
     * Upload byte array lên Cloudinary và trả về URL ảnh an toàn (secure_url)
     */
    @SuppressWarnings("rawtypes")
    public static String uploadBytes(byte[] bytes, String publicId) {
        try {
            Map params = ObjectUtils.asMap(
                "public_id", "avatar_" + publicId + "_" + System.currentTimeMillis(),
                "overwrite", true,
                "resource_type", "image",
                "folder", "shopping_mvc_avatars"
            );
            Map uploadResult = getInstance().uploader().upload(bytes, params);
            if (uploadResult != null && uploadResult.containsKey("secure_url")) {
                return (String) uploadResult.get("secure_url");
            }
        } catch (Exception e) {
            System.err.println("Cloudinary upload failed: " + e.getMessage());
        }
        return null;
    }

    /**
     * Upload File lên Cloudinary
     */
    @SuppressWarnings("rawtypes")
    public static String uploadFile(File file) {
        try {
            Map params = ObjectUtils.asMap(
                "folder", "shopping_mvc_avatars",
                "resource_type", "image"
            );
            Map uploadResult = getInstance().uploader().upload(file, params);
            if (uploadResult != null && uploadResult.containsKey("secure_url")) {
                return (String) uploadResult.get("secure_url");
            }
        } catch (Exception e) {
            System.err.println("Cloudinary file upload failed: " + e.getMessage());
        }
        return null;
    }
}
