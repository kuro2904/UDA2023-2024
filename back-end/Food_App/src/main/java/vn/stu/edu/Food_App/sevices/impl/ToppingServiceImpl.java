package vn.stu.edu.Food_App.sevices.impl;

import org.springframework.stereotype.Service;
import vn.stu.edu.Food_App.dtos.ToppingDTO;
import vn.stu.edu.Food_App.entities.Product;
import vn.stu.edu.Food_App.sevices.ToppingService;

import java.util.List;

@Service
public class ToppingService implements ToppingService {
    @Override
    public List<ToppingDTO> getAll() {
        return null;
    }

    @Override
    public ToppingDTO getById(int id) {
        return null;
    }

    @Override
    public ToppingDTO insert(ToppingDTO request) {
        return null;
    }

    @Override
    public ToppingDTO update(int id, ToppingDTO request) {
        return null;
    }

    @Override
    public void delete(int id) {

    }

    @Override
    public List<ToppingDTO> getByProduct(Product product) {
        return null;
    }
}
