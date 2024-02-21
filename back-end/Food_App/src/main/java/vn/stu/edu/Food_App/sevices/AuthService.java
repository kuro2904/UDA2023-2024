package vn.stu.edu.Food_App.sevices;

import vn.stu.edu.Food_App.dtos.auth.LoginDTO;

public interface AuthService {
    String login(LoginDTO dto);

}
