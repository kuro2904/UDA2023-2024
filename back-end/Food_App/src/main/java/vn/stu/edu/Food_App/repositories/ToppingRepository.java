package vn.stu.edu.Food_App.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.stu.edu.Food_App.entities.Product;
import vn.stu.edu.Food_App.entities.Topping;

import java.util.List;

public interface ToppingRepository extends JpaRepository<Topping,Integer> {
    List<Topping> findByProduct(Product product);
}
