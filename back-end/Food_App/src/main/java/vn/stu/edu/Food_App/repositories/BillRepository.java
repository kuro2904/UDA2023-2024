package vn.stu.edu.Food_App.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.stu.edu.Food_App.entities.Bill;

public interface BillRepository extends JpaRepository<Bill,String> {
}
