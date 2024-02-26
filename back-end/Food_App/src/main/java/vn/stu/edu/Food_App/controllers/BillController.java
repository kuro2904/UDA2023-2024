package vn.stu.edu.Food_App.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import vn.stu.edu.Food_App.dtos.BillDTO;
import vn.stu.edu.Food_App.sevices.BillService;

import java.util.List;

@RestController
@RequestMapping("/api/orders")
public class BillController {

    private final BillService service;

    public BillController(BillService service) {
        this.service = service;
    }

    @PostMapping
    public ResponseEntity<BillDTO> placeOrder(@RequestBody BillDTO request){
        return new ResponseEntity<>(service.placeOrder(request), HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<List<BillDTO>> getAll(){
        return ResponseEntity.ok(service.getAllOrder());
    }
}
