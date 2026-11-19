package vn.iotstar.util;

import java.io.InputStream;
import java.util.Properties;

/**
 * Đọc cấu hình theo thứ tự ưu tiên:
 * 1. Biến môi trường hệ thống (Environment Variables)
 * 2. config-local.properties (file local không commit lên GitHub)
 * 3. application.properties (template cấu hình mặc định)
 */
public class AppConfig {
    private static volatile Properties cachedProps;

    private static Properties loadProperties() {
        if (cachedProps != null) {
            return cachedProps;
        }
        synchronized (AppConfig.class) {
            if (cachedProps != null) {
                return cachedProps;
            }
            Properties props = new Properties();
            ClassLoader cl = AppConfig.class.getClassLoader();
            try (InputStream is = cl.getResourceAsStream("application.properties")) {
                if (is != null) {
                    props.load(is);
                }
            } catch (Exception ignored) {}

            try (InputStream is = cl.getResourceAsStream("config-local.properties")) {
                if (is != null) {
                    Properties localProps = new Properties();
                    localProps.load(is);
                    for (String name : localProps.stringPropertyNames()) {
                        String val = localProps.getProperty(name);
                        if (val != null && !val.trim().isEmpty()) {
                            props.setProperty(name, val.trim());
                        }
                    }
                }
            } catch (Exception ignored) {}

            cachedProps = props;
            return cachedProps;
        }
    }

    public static String get(String envKey, String propKey, String defaultVal) {
        if (envKey != null) {
            String envVal = System.getenv(envKey);
            if (envVal != null && !envVal.trim().isEmpty()) {
                return envVal.trim();
            }
        }
        if (propKey != null) {
            String propVal = loadProperties().getProperty(propKey);
            if (propVal != null && !propVal.trim().isEmpty()) {
                return propVal.trim();
            }
        }
        return defaultVal;
    }

    public static String get(String envKey, String propKey) {
        return get(envKey, propKey, null);
    }
}
