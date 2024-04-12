package vn.stu.edu.Food_App.controllers;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import vn.stu.edu.Food_App.dtos.ProductDTO;
import vn.stu.edu.Food_App.dtos.ToppingDTO;
import vn.stu.edu.Food_App.sevices.ProductService;

import java.io.IOException;
import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("/api/products")
public class ProductController {
    private final ProductService productService;
    private final ObjectMapper mapper;

    public ProductController(ProductService productService, ObjectMapper mapper) {
        this.productService = productService;
        this.mapper = mapper;
    }

    @PostMapping
    public ResponseEntity<ProductDTO> insertProduct(@RequestParam("request") String request, @RequestParam(name = "image",required = false)MultipartFile image) throws IOException {
        return new ResponseEntity<>(productService.insertProduct(mapper.readValue(request, ProductDTO.class),image), HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<List<ProductDTO>> getAll(){
        return ResponseEntity.ok(productService.getAll());
    }

    @PutMapping("product/{id}")
    public ResponseEntity<ProductDTO> editProduct(@PathVariable String id,@RequestParam String request, @RequestParam(name = "image",required = false) MultipartFile image) throws IOException {
        return ResponseEntity.ok(productService.editProduct(id,mapper.readValue(request, ProductDTO.class),image));
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

    @PutMapping("/product/{productId}/topping")
    public ResponseEntity<ProductDTO> addTopping(@PathVariable(name = "productId") String productId, @RequestBody ToppingDTO topping){
        return new ResponseEntity<>(productService.addToppingToProduct(productId, topping),HttpStatus.CREATED);
    }

}
