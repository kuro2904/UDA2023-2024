package vn.stu.edu.Food_App.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import vn.stu.edu.Food_App.dtos.UserDTO;
import vn.stu.edu.Food_App.dtos.auth.LoginDTO;
import vn.stu.edu.Food_App.dtos.auth.RegisterDTO;
import vn.stu.edu.Food_App.security.AuthService;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping("login")
    public ResponseEntity<String> login(@RequestBody LoginDTO dto){
        return ResponseEntity.ok(authService.login(dto));
    }

    @PostMapping("register")
    public ResponseEntity<UserDTO> register(@RequestBody RegisterDTO dto){
        return new ResponseEntity<>(authService.register(dto), HttpStatus.CREATED);
    }
}
