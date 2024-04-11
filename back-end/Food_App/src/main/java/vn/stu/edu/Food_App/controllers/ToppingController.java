package vn.stu.edu.Food_App.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import vn.stu.edu.Food_App.dtos.ToppingDTO;
import vn.stu.edu.Food_App.sevices.ToppingService;

import java.util.List;

@RestController
@RequestMapping("/api/toppings")
public class ToppingController {
    private final ToppingService toppingService;

    public ToppingController(ToppingService toppingService) {
        this.toppingService = toppingService;
    }

    @GetMapping("/topping/{id}")
    public ResponseEntity<ToppingDTO> getTopping(@PathVariable int id){
        return ResponseEntity.ok(toppingService.getById(id));
    }

    @GetMapping
    public ResponseEntity<List<ToppingDTO>> getAll(){
        return ResponseEntity.ok(toppingService.getAll());
    }

    @GetMapping("/product/{productId}")
    public ResponseEntity<List<ToppingDTO>> getByProduct(@PathVariable String productId){
        return ResponseEntity.ok(toppingService.getByProduct(productId));
    }



    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@PathVariable int id){
        return ResponseEntity.ok(toppingService.delete(id));
    }
}
