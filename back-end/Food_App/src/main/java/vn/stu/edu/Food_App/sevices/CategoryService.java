package vn.stu.edu.Food_App.sevices;

import vn.stu.edu.Food_App.dtos.CategoryDTO;

import java.util.List;

public interface CategoryService {
    CategoryDTO insert(CategoryDTO categoryDTO);
    CategoryDTO getById(String id);
    CategoryDTO editById(String id, CategoryDTO categoryDTO);
    String deleteById(String id);
    List<CategoryDTO> getAll();
}
