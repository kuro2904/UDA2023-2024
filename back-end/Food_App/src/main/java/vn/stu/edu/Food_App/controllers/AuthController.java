package vn.stu.edu.Food_App.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import vn.stu.edu.Food_App.dtos.UserDTO;
import vn.stu.edu.Food_App.dtos.auth.LoginDTO;
import vn.stu.edu.Food_App.dtos.auth.RegisterDTO;
import vn.stu.edu.Food_App.security.AuthService;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;

@RestController
@RequestMapping("/api/auth")
@CrossOrigin
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping("login")
    public ResponseEntity<UserDTO> login(@RequestBody LoginDTO dto){
        return ResponseEntity.ok(authService.login(dto));
    }

    @PostMapping("register")
    public ResponseEntity<UserDTO> register(@RequestBody RegisterDTO dto){
        return new ResponseEntity<>(authService.register(dto), HttpStatus.CREATED);
    }

    @PostMapping("admin/register")
    public ResponseEntity<UserDTO> registerAdmin(@RequestBody RegisterDTO dto){
        return new ResponseEntity<>(authService.registerAdmin(dto),HttpStatus.CREATED);
    }
    @PostMapping("super-user/register")
    public ResponseEntity<UserDTO> registerSuperUser(@RequestBody RegisterDTO dto){
        return new ResponseEntity<>(authService.createSuperUser(dto),HttpStatus.CREATED);
    }
}
