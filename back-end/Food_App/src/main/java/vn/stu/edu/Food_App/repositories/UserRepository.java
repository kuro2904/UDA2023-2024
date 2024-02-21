package vn.stu.edu.Food_App.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.stu.edu.Food_App.entities.User;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User,String> {
//    Optional<User> findByEmail(String email);
//    Optional<User> findByPhone(String phone);
}
