package vn.stu.edu.Food_App.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.stu.edu.Food_App.entities.BillDetail;

public interface BillDetailRepository extends JpaRepository<BillDetail,String> {
}
