//package vn.stu.edu.Food_App.sevices.impl;
//
//import org.springframework.security.authentication.AuthenticationManager;
//import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
//import org.springframework.security.core.Authentication;
//import org.springframework.security.core.context.SecurityContextHolder;
//import vn.stu.edu.Food_App.dtos.auth.LoginDTO;
//import vn.stu.edu.Food_App.sevices.AuthService;
//
//public class AthServiceImpl implements AuthService {
//
//    private AuthenticationManager authenticationManager;
//
//    public AthServiceImpl(AuthenticationManager authenticationManager) {
//        this.authenticationManager = authenticationManager;
//    }
//
//    @Override
//    public String login(LoginDTO dto) {
//        Authentication authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(
//                dto.getUserNameOrPassword(),dto.getPassword()
//        ));
//        SecurityContextHolder.getContext().setAuthentication(authentication);
//        return "User Logged-in successfully !";
//    }
//}
