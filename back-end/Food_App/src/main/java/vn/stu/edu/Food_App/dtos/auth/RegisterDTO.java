package vn.stu.edu.Food_App.dtos.auth;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class RegisterDTO {
    private String id;
    private String email;
    private String password;
    private String phoneNumber;
    private String address;
}
