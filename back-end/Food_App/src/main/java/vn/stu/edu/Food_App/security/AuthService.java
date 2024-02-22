package vn.stu.edu.Food_App.security;

import vn.stu.edu.Food_App.dtos.UserDTO;
import vn.stu.edu.Food_App.dtos.auth.LoginDTO;
import vn.stu.edu.Food_App.dtos.auth.RegisterDTO;

public interface AuthService {
    String login(LoginDTO dto);
    UserDTO register(RegisterDTO dto);
}
