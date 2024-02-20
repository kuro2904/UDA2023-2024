package vn.stu.edu.Food_App.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import vn.stu.edu.Food_App.dtos.ProductDTO;
import vn.stu.edu.Food_App.sevices.ProductService;

import java.util.List;

@RestController
@RequestMapping("/api/products")
public class ProductController {
    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @PostMapping
    public ResponseEntity<ProductDTO> insertProduct(@RequestBody ProductDTO productDTO){
        return new ResponseEntity<>(productService.insertProduct(productDTO), HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<List<ProductDTO>> getAll(){
        return ResponseEntity.ok(productService.getAll());
    }

    @PutMapping("product/{id}")
    public ResponseEntity<ProductDTO> editProduct(@PathVariable String id,@RequestBody ProductDTO productDTO){
        return ResponseEntity.ok(productService.editProduct(id,productDTO));
    }

    @GetMapping("category/{id}")
    public ResponseEntity<List<ProductDTO>> getByCategory(@PathVariable String id){
        return ResponseEntity.ok(productService.getByCategory(id));
    }

    @GetMapping("product/{id}")
    public ResponseEntity<ProductDTO> getById(@PathVariable String id){
        return ResponseEntity.ok(productService.getById(id));
    }

    @DeleteMapping("/product/{id}")
    public ResponseEntity<String> deleteProduct(@PathVariable String id){
        return ResponseEntity.ok(productService.deleteProduct(id));
    }

}
