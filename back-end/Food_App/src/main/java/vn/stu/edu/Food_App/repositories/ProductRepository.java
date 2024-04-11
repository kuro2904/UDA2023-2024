package vn.stu.edu.Food_App.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import vn.stu.edu.Food_App.entities.Category;
import vn.stu.edu.Food_App.entities.Product;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product,String> {

    @Query("SELECT p FROM Product p WHERE p.category = :category")
     List<Product> timTheoCategory(Category category);

}

