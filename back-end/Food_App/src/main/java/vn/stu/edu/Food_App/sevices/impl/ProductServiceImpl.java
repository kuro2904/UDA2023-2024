package vn.stu.edu.Food_App.sevices.impl;

import jakarta.transaction.Transactional;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import vn.stu.edu.Food_App.dtos.ProductDTO;
import vn.stu.edu.Food_App.dtos.ToppingDTO;
import vn.stu.edu.Food_App.entities.Category;
import vn.stu.edu.Food_App.entities.Product;
import vn.stu.edu.Food_App.entities.Topping;
import vn.stu.edu.Food_App.exceptions.ResourceNotFoundException;
import vn.stu.edu.Food_App.repositories.CategoryRepository;
import vn.stu.edu.Food_App.repositories.ProductRepository;
import vn.stu.edu.Food_App.repositories.ToppingRepository;
import vn.stu.edu.Food_App.sevices.ImageService;
import vn.stu.edu.Food_App.sevices.ProductService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class ProductServiceImpl implements ProductService  {

    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;
    private final ImageService imageService;
    private final ModelMapper mapper;
    private final ToppingRepository toppingRepository;

    public ProductServiceImpl(ProductRepository productRepository, CategoryRepository categoryRepository, ImageService imageService, ModelMapper mapper, ToppingRepository toppingRepository) {
        this.productRepository = productRepository;
        this.categoryRepository = categoryRepository;
        this.imageService = imageService;
        this.mapper = mapper;
        this.toppingRepository = toppingRepository;
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
        return productRepository.findAll().stream().map(ProductDTO::new).collect(Collectors.toList());
    }

    @Override
    public ProductDTO insertProduct(ProductDTO productDTO, MultipartFile image) throws IOException {
        Product product = new Product();
        product.setName(productDTO.getName());
        product.setPrice(productDTO.getPrice());
        product.setDescription(productDTO.getDescription());
        saveImage(productDTO, image, product);

        // Thêm sản phẩm vào cơ sở dữ liệu
        product = productRepository.save(product);

        if(productDTO.getTopping() != null) {
            List<Topping> list = new ArrayList<>();
            for (ToppingDTO toppingDTO : productDTO.getTopping()) {
                // Truyền ID của sản phẩm cho mỗi loại topping
                Topping topping = new Topping(toppingDTO.getName(), toppingDTO.getPrice(), product);
                topping = toppingRepository.save(topping);
                list.add(topping);
            }
            // Cập nhật danh sách topping của sản phẩm
            product.setToppings(list);
            // Cập nhật lại sản phẩm sau khi đã thêm topping
            product = productRepository.save(product);
        }
        return new ProductDTO(product);
    }


    @Override
    public ProductDTO editProduct(String id,ProductDTO productDTO, MultipartFile image) throws IOException {
        Product product = productRepository.findById(id).orElseThrow(
                () -> new ResourceNotFoundException("Product","Id",id)
        );
        if(productDTO.getName() != null) product.setName(productDTO.getName());
        if(productDTO.getPrice() != null) product.setPrice(productDTO.getPrice());
        if(productDTO.getDescription() != null) product.setDescription(productDTO.getDescription());
        saveImage(productDTO, image, product);
        return mapper.map(productRepository.save(product), ProductDTO.class);
    }

    private void saveImage(ProductDTO productDTO, MultipartFile image, Product product) throws IOException {
        if(image != null && image.getSize() >0) product.setImageUrl(imageService.uploadImage(image));
        if(productDTO.getCategoryId() != null){
            Category category = categoryRepository.findById(productDTO.getCategoryId()).orElseThrow(
                    () -> new ResourceNotFoundException("Category ","Id:",productDTO.getCategoryId())
            );
            product.setCategory(category);
        }
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

    @Override
    public ProductDTO addToppingToProduct(String productId, ToppingDTO toppingDTO) {
        Product product = productRepository.findById(productId).orElseThrow(
                () -> new ResourceNotFoundException("Product","Id",productId)
        );
        Topping topping = new Topping();
        topping.setName(toppingDTO.getName());
        topping.setPrice(toppingDTO.getPrice());

        Topping rs = toppingRepository.save(topping);

        product.getToppings().add(rs);
        rs.setProduct(product);
        toppingRepository.save(rs);
        return new ProductDTO(productRepository.save(product));
    }
}
