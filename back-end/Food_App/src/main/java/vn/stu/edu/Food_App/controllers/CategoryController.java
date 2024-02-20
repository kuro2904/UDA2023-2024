package vn.stu.edu.Food_App.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import vn.stu.edu.Food_App.dtos.CategoryDTO;
import vn.stu.edu.Food_App.sevices.CategoryService;

import java.util.List;

@RestController
@RequestMapping("/api/categories")
public class CategoryController {
    private final CategoryService service;

    public CategoryController(CategoryService service) {
        this.service = service;
    }

    @PostMapping
    public ResponseEntity<CategoryDTO> insert(@RequestBody CategoryDTO request){
        return new ResponseEntity<>(service.insert(request), HttpStatus.CREATED);
    }

    @GetMapping("category/{id}")
    public ResponseEntity<CategoryDTO> getById(@PathVariable String id){
        return ResponseEntity.ok(service.getById(id));
    }
    @PutMapping("category/{id}")
    public ResponseEntity<CategoryDTO> editById(@PathVariable String id, @RequestBody CategoryDTO categoryDTO){
        return ResponseEntity.ok(service.editById(id, categoryDTO));
    }
    @DeleteMapping("category/{id}")
    public ResponseEntity<String> deleteById(@PathVariable String id){
        return ResponseEntity.ok(service.deleteById(id));
    }

    @GetMapping()
    public ResponseEntity<List<CategoryDTO>> getAll(){
        return ResponseEntity.ok(service.getAll());
    }
}
