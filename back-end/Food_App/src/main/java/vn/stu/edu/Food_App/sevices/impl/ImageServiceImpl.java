package vn.stu.edu.Food_App.sevices.impl;

import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import vn.stu.edu.Food_App.sevices.ImageService;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;

@Service
@Transactional
public class ImageServiceImpl implements ImageService {
    @Value("${project.images}")
    String path;

    @Override
    public String uploadImage(MultipartFile file) throws IOException {
        String name = file.getOriginalFilename();
        String randomID = UUID.randomUUID().toString();
        String fileName = randomID.concat(name.substring(name.lastIndexOf(".")));

        String fullPath = path + File.separator + Paths.get(fileName);

        File f = new File(path);
        if(!f.exists()){
            f.mkdir();
        }
        Files.copy(file.getInputStream(), Paths.get(fullPath));
        return fileName;
    }

    @Override
    public InputStream getResource(String fileName) throws FileNotFoundException {
        InputStream is = new FileInputStream(path+fileName);
        return is;
    }
}
