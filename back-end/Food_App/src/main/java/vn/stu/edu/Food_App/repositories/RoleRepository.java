package vn.stu.edu.Food_App.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.stu.edu.Food_App.entities.Role;

public interface RoleRepository extends JpaRepository<Role,String> {
}
