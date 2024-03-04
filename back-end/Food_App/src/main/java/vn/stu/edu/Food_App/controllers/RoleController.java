package vn.stu.edu.Food_App.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import vn.stu.edu.Food_App.dtos.RoleDTO;
import vn.stu.edu.Food_App.sevices.RoleService;

import java.util.Set;

@RestController
@CrossOrigin
@RequestMapping("/api/roles")
public class RoleController {

    private final RoleService roleService;

    public RoleController(RoleService roleService) {
        this.roleService = roleService;
    }

    @PreAuthorize("hasRole('OWNER')")
    @PostMapping
    public ResponseEntity<RoleDTO> insertRole(@RequestBody RoleDTO request){
        return new ResponseEntity<>(roleService.createRole(request), HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<Set<RoleDTO>> getAllRole(){
        return ResponseEntity.ok(roleService.findAll());
    }

    @PreAuthorize("hasRole('OWNER')")
    @PutMapping("role/{id}")
    public ResponseEntity<RoleDTO> editRole(@PathVariable String id, @RequestBody RoleDTO request){
        return ResponseEntity.ok(roleService.updateRole(id,request));
    }

    @PreAuthorize("hasRole('OWNER')")
    @DeleteMapping("role/{id}")
    public ResponseEntity<String> deleteRole(@PathVariable String id){
        return ResponseEntity.ok(roleService.deleteRole(id));
    }

    @GetMapping("role/{id}")
    public ResponseEntity<RoleDTO> getById(@PathVariable String id){
        return ResponseEntity.ok(roleService.findById(id));
    }

}
