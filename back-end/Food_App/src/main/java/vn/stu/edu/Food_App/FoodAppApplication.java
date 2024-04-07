package vn.stu.edu.Food_App;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import vn.stu.edu.Food_App.entities.Role;
import vn.stu.edu.Food_App.entities.User;
import vn.stu.edu.Food_App.repositories.UserRepository;

import java.util.ArrayList;
import java.util.List;

@SpringBootApplication
public class FoodAppApplication {

	@Bean
	public ModelMapper modelMapper () {
		return new ModelMapper();
	}

	public static void main(String[] args) {
		SpringApplication.run(FoodAppApplication.class, args);
	}

}
