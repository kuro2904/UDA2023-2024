package vn.stu.edu.Food_App.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.stu.edu.Food_App.entities.Bill;
import vn.stu.edu.Food_App.entities.User;

import java.util.List;

public interface BillRepository extends JpaRepository<Bill,String> {
    List<Bill> findByUser(User user);
}
