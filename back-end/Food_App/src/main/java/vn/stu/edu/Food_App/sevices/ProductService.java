package vn.stu.edu.Food_App.sevices;

import org.springframework.web.multipart.MultipartFile;
import vn.stu.edu.Food_App.dtos.ProductDTO;
import vn.stu.edu.Food_App.dtos.ToppingDTO;
import vn.stu.edu.Food_App.entities.Product;

import java.io.IOException;
import java.util.List;

public interface ProductService {
    ProductDTO getById(String id);
    List<ProductDTO> getAll();
    ProductDTO insertProduct(ProductDTO productDTO, MultipartFile image) throws IOException;
    ProductDTO editProduct(String id,ProductDTO productDTO, MultipartFile image) throws IOException;
    List<ProductDTO> getByCategory(String categoryId);
    String deleteProduct(String id);
    ProductDTO addToppingToProduct(String productId, ToppingDTO toppingDTO);
}
