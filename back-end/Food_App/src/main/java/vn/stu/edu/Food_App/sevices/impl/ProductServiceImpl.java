package vn.stu.edu.Food_App.sevices.impl;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import vn.stu.edu.Food_App.dtos.ProductDTO;
import vn.stu.edu.Food_App.entities.Category;
import vn.stu.edu.Food_App.entities.Product;
import vn.stu.edu.Food_App.exceptions.ResourceNotFoundException;
import vn.stu.edu.Food_App.repositories.CategoryRepository;
import vn.stu.edu.Food_App.repositories.ProductRepository;
import vn.stu.edu.Food_App.sevices.ImageService;
import vn.stu.edu.Food_App.sevices.ProductService;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ProductServiceImpl implements ProductService  {

    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;
    private final ImageService imageService;
    private final ModelMapper mapper;

    public ProductServiceImpl(ProductRepository productRepository, CategoryRepository categoryRepository, ImageService imageService, ModelMapper mapper) {
        this.productRepository = productRepository;
        this.categoryRepository = categoryRepository;
        this.imageService = imageService;
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
    public ProductDTO insertProduct(ProductDTO productDTO, MultipartFile image) throws IOException {
        Category category = categoryRepository.findById(productDTO.getCategory().getId()).orElseThrow(
                () -> new ResourceNotFoundException("Category ","Id:",productDTO.getCategory().getId())
        );
        Product product = new Product();
        product.setId(productDTO.getId());
        product.setName(productDTO.getName());
        product.setPrice(productDTO.getPrice());
        product.setDescription(productDTO.getDescription());
        product.setImageUrl(imageService.uploadImage(image));
        product.setCategory(category);
        return mapper.map(productRepository.save(product), ProductDTO.class);
    }

    @Override
    public ProductDTO editProduct(String id,ProductDTO productDTO, MultipartFile image) throws IOException {
        Product product = productRepository.findById(id).orElseThrow(
                () -> new ResourceNotFoundException("Product","Id",id)
        );
        if(productDTO.getName() != null) product.setName(productDTO.getName());
        if(productDTO.getPrice() != null) product.setPrice(productDTO.getPrice());
        if(productDTO.getDescription() != null) product.setDescription(productDTO.getDescription());
        if(image != null) product.setImageUrl(imageService.uploadImage(image));
        if(productDTO.getCategory() != null){
            Category category = categoryRepository.findById(productDTO.getCategory().getId()).orElseThrow(
                    () -> new ResourceNotFoundException("Category ","Id:",productDTO.getCategory().getId())
            );
            product.setCategory(category);
        }
        return mapper.map(productRepository.save(product), ProductDTO.class);
    }

    @Override
    public List<ProductDTO> getByCategory(String categoryId) {
        Category category = categoryRepository.findById(categoryId).orElseThrow(
                () -> new ResourceNotFoundException("Category ","Id:",categoryId)
        );
        return productRepository.timTheoCategory(category).stream().map(
                product -> mapper.map(product, ProductDTO.class)
        ).collect(Collectors.toList());
    }

    @Override
    public String deleteProduct(String id) {
        Product product = productRepository.findById(id).orElseThrow(
                () -> new ResourceNotFoundException("Product","Id",id)
        );
        productRepository.delete(product);
        return "Delete Complete";
    }
}
