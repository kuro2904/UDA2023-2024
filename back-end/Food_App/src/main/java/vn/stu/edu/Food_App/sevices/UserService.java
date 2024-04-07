package vn.stu.edu.Food_App.sevices;

import vn.stu.edu.Food_App.dtos.UserDTO;

import java.util.List;

public interface UserService {
    UserDTO updateUser(String id, UserDTO userDTO);
    String deleteUser(String id);
    List<UserDTO> getAllUser();
}
