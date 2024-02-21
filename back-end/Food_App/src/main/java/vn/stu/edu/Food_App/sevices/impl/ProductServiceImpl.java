package vn.stu.edu.Food_App.sevices.impl;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import vn.stu.edu.Food_App.dtos.ProductDTO;
import vn.stu.edu.Food_App.entities.Category;
import vn.stu.edu.Food_App.entities.Product;
import vn.stu.edu.Food_App.repositories.CategoryRepository;
import vn.stu.edu.Food_App.repositories.ProductRepository;
import vn.stu.edu.Food_App.sevices.ProductService;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ProductServiceImpl implements ProductService  {

    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;
    private final ModelMapper mapper;

    public ProductServiceImpl(ProductRepository productRepository, CategoryRepository categoryRepository, ModelMapper mapper) {
        this.productRepository = productRepository;
        this.categoryRepository = categoryRepository;
        this.mapper = mapper;
    }

    @Override
    public ProductDTO getById(String id) {
        Product product = productRepository.findById(id).orElseThrow(
                ()-> new RuntimeException("Cannot found Product By Id: "+ id)
        );
        return mapper.map(product,ProductDTO.class);
    }

    @Override
    public List<ProductDTO> getAll() {
        return productRepository.findAll().stream().map(
                product -> mapper.map(product,ProductDTO.class)
        ).collect(Collectors.toList());
    }

    @Override
    public ProductDTO insertProduct(ProductDTO productDTO) {
        Category category = categoryRepository.findById(productDTO.getCategory().getId()).orElseThrow(
                () -> new RuntimeException("Cannot Found Category By Id: " +productDTO.getCategory().getId())
        );
        Product product = new Product();
        product.setId(productDTO.getId());
        product.setName(productDTO.getName());
        product.setPrice(productDTO.getPrice());
        product.setDescription(productDTO.getDescription());
        product.setImageUrl(productDTO.getImageUrl());
        product.setCategory(category);
        return mapper.map(productRepository.save(product), ProductDTO.class);
    }

    @Override
    public ProductDTO editProduct(String id,ProductDTO productDTO) {
        Product product = productRepository.findById(id).orElseThrow(
                () -> new RuntimeException("Cannot Found Product By Id: "+ id)
        );
        if(productDTO.getName() != null) product.setName(productDTO.getName());
        if(productDTO.getPrice() != null) product.setPrice(productDTO.getPrice());
        if(productDTO.getDescription() != null) product.setDescription(productDTO.getDescription());
        if(productDTO.getImageUrl() != null) product.setImageUrl(productDTO.getImageUrl());
        if(productDTO.getCategory() != null){
            Category category = categoryRepository.findById(productDTO.getCategory().getId()).orElseThrow(
                    () -> new RuntimeException("Cannot Found Category By Id: " + productDTO.getCategory().getId())
            );
            product.setCategory(category);
        }
        return mapper.map(productRepository.save(product), ProductDTO.class);
    }

    @Override
    public List<ProductDTO> getByCategory(String categoryId) {
        Category category = categoryRepository.findById(categoryId).orElseThrow(
                () -> new RuntimeException("Cannot Found Category By Id: " + categoryId)
        );
        return productRepository.timTheoCategory(category).stream().map(
                product -> mapper.map(product, ProductDTO.class)
        ).collect(Collectors.toList());
    }

    @Override
    public String deleteProduct(String id) {
        Product product = productRepository.findById(id).orElseThrow(
                () -> new RuntimeException("Cannot Found Product By Id: " + id)
        );
        productRepository.delete(product);
        return "Delete Complete";
    }
}
