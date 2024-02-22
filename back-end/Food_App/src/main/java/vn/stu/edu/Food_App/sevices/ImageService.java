package vn.stu.edu.Food_App.sevices;

import org.springframework.web.multipart.MultipartFile;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

public interface ImageService {
    String uploadImage(MultipartFile file) throws IOException;
    InputStream getResource(String filePath) throws FileNotFoundException;

}
