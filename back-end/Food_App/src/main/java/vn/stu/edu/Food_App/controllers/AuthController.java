//package vn.stu.edu.Food_App.controllers;
//
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RestController;
//import vn.stu.edu.Food_App.dtos.auth.LoginDTO;
//import vn.stu.edu.Food_App.sevices.AuthService;
//
//@RestController
//@RequestMapping("/api/auth")
//public class AuthController {
//
//    private final AuthService authService;
//
//    public AuthController(AuthService authService) {
//        this.authService = authService;
//    }
//
//    @PostMapping("login")
//    public ResponseEntity<String> login(LoginDTO dto){
//        return ResponseEntity.ok(authService.login(dto));
//    }
//}
