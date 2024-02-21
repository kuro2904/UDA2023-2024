package vn.stu.edu.Food_App.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import vn.stu.edu.Food_App.dtos.DiscountDTO;
import vn.stu.edu.Food_App.sevices.DiscountService;

import java.util.List;

@RestController
@RequestMapping("/api/discounts")
public class DiscountController {
    private final DiscountService service;

    public DiscountController(DiscountService service) {
        this.service = service;
    }

    @GetMapping
    public ResponseEntity<List<DiscountDTO>> getAll(){
        return ResponseEntity.ok(service.getAllDiscount());
    }

    @GetMapping("/discount/{id}")
    public ResponseEntity<DiscountDTO> getById(@PathVariable String id){
        return ResponseEntity.ok(service.getDiscountById(id));
    }

    @PostMapping()
    public ResponseEntity<DiscountDTO> insertDiscount(@RequestBody DiscountDTO discountDTO){
        return new ResponseEntity<>(service.insertDiscount(discountDTO), HttpStatus.CREATED);
    }
}
