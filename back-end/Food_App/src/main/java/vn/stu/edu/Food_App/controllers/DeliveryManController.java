package vn.stu.edu.Food_App.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import vn.stu.edu.Food_App.dtos.DeliverManDTO;
import vn.stu.edu.Food_App.sevices.DeliverManService;

import java.util.List;

@RestController
@RequestMapping("/api/deliverymen")
public class DeliveryManController {
    private final DeliverManService service;

    public DeliveryManController(DeliverManService service) {
        this.service = service;
    }

    @PostMapping
    public ResponseEntity<DeliverManDTO> insert(@RequestBody DeliverManDTO request){
        return new ResponseEntity<>(service.insertDeliveryMan(request), HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<List<DeliverManDTO>> getAll(){
        return ResponseEntity.ok(service.getAll());
    }

    @GetMapping("man/{id}")
    public ResponseEntity<DeliverManDTO> getById(@PathVariable String id) {
        return ResponseEntity.ok(service.getById(id));
    }

    @PutMapping("man/{id}")
    public ResponseEntity<DeliverManDTO> edit(@PathVariable String id, @RequestBody DeliverManDTO dto){
        return ResponseEntity.ok(service.editDeliveryMan(id,dto));
    }

    @DeleteMapping("/man/{id}")
    public ResponseEntity<String> delete(@PathVariable String id){
        return ResponseEntity.ok(service.deleteDeliveryMan(id));
    }

}
