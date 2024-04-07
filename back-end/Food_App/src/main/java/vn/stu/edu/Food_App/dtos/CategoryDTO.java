package vn.stu.edu.Food_App.dtos;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class CategoryDTO {
    private String id;
    private String name;
    private String description;
    private String imageUrl;
    private List<String> productIds= new ArrayList<>();
}
