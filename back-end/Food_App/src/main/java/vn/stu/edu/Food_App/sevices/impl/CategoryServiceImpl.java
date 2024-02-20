package vn.stu.edu.Food_App.sevices.impl;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import vn.stu.edu.Food_App.dtos.CategoryDTO;
import vn.stu.edu.Food_App.entities.Category;
import vn.stu.edu.Food_App.entities.Product;
import vn.stu.edu.Food_App.repositories.CategoryRepository;
import vn.stu.edu.Food_App.repositories.ProductRepository;
import vn.stu.edu.Food_App.sevices.CategoryService;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class CategoryServiceImpl implements CategoryService {

    private final CategoryRepository categoryRepository;
    private final ProductRepository productRepository;
    private final ModelMapper mapper;

    public CategoryServiceImpl(CategoryRepository categoryRepository, ProductRepository productRepository, ModelMapper mapper) {
        this.categoryRepository = categoryRepository;
        this.productRepository = productRepository;
        this.mapper = mapper;
    }

    @Override
    public CategoryDTO insert(CategoryDTO categoryDTO) {
        Category category = mapper.map(categoryDTO, Category.class);
        return mapper.map(categoryRepository.save(category),CategoryDTO.class);
    }

    @Override
    public CategoryDTO getById(String id) {
        Category category = categoryRepository.findById(id).orElseThrow(
                ()-> new RuntimeException("Cannot found Category with Id:" + id)
        );
        return mapper.map(category,CategoryDTO.class);
    }

    @Override
    public CategoryDTO editById(String id, CategoryDTO categoryDTO) {
        Category category = categoryRepository.findById(id).orElseThrow(
                () -> new RuntimeException("Cannot found Category by Id: " + id)
        );
        if(categoryDTO.getName() != null) category.setName(categoryDTO.getName());
        if(categoryDTO.getDescription() != null) category.setDescription(categoryDTO.getDescription());
        if(categoryDTO.getImageUrl() != null) category.setImageUrl(categoryDTO.getImageUrl());
        if(categoryDTO.getProductIds() != null){
            List<Product> products = new ArrayList<>();
            for (int i = 0; i < categoryDTO.getProductIds().size(); i++) {
                Product product = productRepository.findById(categoryDTO.getProductIds().get(i)).orElseThrow(
                        ()-> new RuntimeException("Cannot found Product By id: "+ id)
                );
                products.add(product);
            }
            category.setProducts(products);
        }
        return mapper.map(category,CategoryDTO.class);
    }

    @Override
    public String deleteById(String id) {
        Category category = categoryRepository.findById(id).orElseThrow(
                () -> new RuntimeException("Cannot found Category with Id: " + id)
        );
        categoryRepository.delete(category);
        return "Delete Complete";
    }

    @Override
    public List<CategoryDTO> getAll() {
        return categoryRepository.findAll().stream().map(
                category -> mapper.map(category,CategoryDTO.class)
        ).collect(Collectors.toList());
    }


}
