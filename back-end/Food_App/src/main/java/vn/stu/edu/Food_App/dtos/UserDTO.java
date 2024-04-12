package vn.stu.edu.Food_App.dtos;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UserDTO {
    private String id;
    private String email;
    private String phoneNumber;
    private String address;
    private String role;
    private String password;
}
