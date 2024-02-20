package vn.stu.edu.Food_App.sevices;

import vn.stu.edu.Food_App.dtos.ProductDTO;
import vn.stu.edu.Food_App.entities.Product;

import java.util.List;

public interface ProductService {
    ProductDTO getById(String id);
    List<ProductDTO> getAll();
    ProductDTO insertProduct(ProductDTO productDTO);
    ProductDTO editProduct(String id,ProductDTO productDTO);
    List<ProductDTO> getByCategory(String categoryId);
    String deleteProduct(String id);
}
