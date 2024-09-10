package helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

/**
 *
 * @author Durgesh
 */
public class Helper {

    public static boolean deleteFile(String path) {
        boolean f = false;
        try {
            File file = new File(path);
            f = file.delete();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public static boolean saveFile(InputStream is, String path) {
        boolean f = false;
        FileOutputStream fos = null;
        try {
            // Tạo thư mục nếu chưa tồn tại
            File file = new File(path);
            file.getParentFile().mkdirs();

            fos = new FileOutputStream(file);
            byte[] buffer = new byte[1024];
            int bytesRead;

            // Đọc và ghi dữ liệu từ InputStream
            while ((bytesRead = is.read(buffer)) != -1) {
                fos.write(buffer, 0, bytesRead);
            }
            fos.flush();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (fos != null) {
                    fos.close();
                }
                is.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return f;
    }
}
