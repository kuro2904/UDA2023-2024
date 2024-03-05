package vn.stu.edu.Food_App.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import vn.stu.edu.Food_App.dtos.CategoryDTO;
import vn.stu.edu.Food_App.sevices.CategoryService;

import java.io.IOException;
import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("/api/categories")
public class CategoryController {
    private final CategoryService service;
    private final ObjectMapper mapper;

    public CategoryController(CategoryService service, ObjectMapper mapper) {
        this.service = service;
        this.mapper = mapper;
    }

    @PostMapping
    public ResponseEntity<CategoryDTO> insert(@RequestParam("request") String request,@RequestPart(required = false) @RequestParam("image") MultipartFile image) throws IOException {
        return new ResponseEntity<>(service.insert(mapper.readValue(request, CategoryDTO.class), image), HttpStatus.CREATED);
    }

    @GetMapping("category/{id}")
    public ResponseEntity<CategoryDTO> getById(@PathVariable String id) {
        return ResponseEntity.ok(service.getById(id));
    }

    @PutMapping("category/{id}")
    public ResponseEntity<CategoryDTO> editById(@PathVariable String id, @RequestParam String request, @RequestParam("image") MultipartFile image) throws IOException {
        CategoryDTO categoryDTO = mapper.readValue(request, CategoryDTO.class);
        return ResponseEntity.ok(service.editById(id, categoryDTO, image));
    }

    @DeleteMapping("category/{id}")
    public ResponseEntity<String> deleteById(@PathVariable String id) {
        return ResponseEntity.ok(service.deleteById(id));
    }

    @GetMapping()
    public ResponseEntity<List<CategoryDTO>> getAll() {
        return ResponseEntity.ok(service.getAll());
    }
}
