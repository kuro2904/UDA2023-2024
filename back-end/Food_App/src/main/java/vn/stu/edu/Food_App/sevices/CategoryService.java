package vn.stu.edu.Food_App.sevices;

import org.springframework.web.multipart.MultipartFile;
import vn.stu.edu.Food_App.dtos.CategoryDTO;

import java.io.IOException;
import java.util.List;

public interface CategoryService {
    CategoryDTO insert(CategoryDTO categoryDTO, MultipartFile image) throws IOException;
    CategoryDTO getById(String id);
    CategoryDTO editById(String id, CategoryDTO categoryDTO, MultipartFile image) throws IOException;
    String deleteById(String id);
    List<CategoryDTO> getAll();
}
