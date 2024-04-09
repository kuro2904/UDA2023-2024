package vn.stu.edu.Food_App.sevices;

import vn.stu.edu.Food_App.dtos.ToppingDTO;
import vn.stu.edu.Food_App.entities.Product;

import java.util.List;

public interface ToppingService {
    List<ToppingDTO> getAll();
    ToppingDTO getById(int id);
    String delete(int id);
    List<ToppingDTO> getByProduct(String productId);
}
