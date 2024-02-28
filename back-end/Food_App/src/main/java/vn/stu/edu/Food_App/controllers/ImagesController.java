package vn.stu.edu.Food_App.controllers;

import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import vn.stu.edu.Food_App.sevices.ImageService;

@RestController
@RequestMapping("/api/images")
public class ImagesController {
    private final ImageService service;

    public ImagesController(ImageService service){
        this.service = service;
    }

    @GetMapping("name/{fileName}")
    public  void getResource(@PathVariable String fileName, HttpServletResponse response) throws IOException {
         response.setContentType(MediaType.IMAGE_JPEG_VALUE);
          IOUtils.copy(service.getResource(fileName), response.getOutputStream());
    }

}
