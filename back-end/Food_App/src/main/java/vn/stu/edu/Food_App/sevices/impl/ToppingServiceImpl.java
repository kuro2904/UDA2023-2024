package vn.stu.edu.Food_App.sevices.impl;

import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;
import vn.stu.edu.Food_App.dtos.ToppingDTO;
import vn.stu.edu.Food_App.entities.Product;
import vn.stu.edu.Food_App.entities.Topping;
import vn.stu.edu.Food_App.exceptions.ResourceNotFoundException;
import vn.stu.edu.Food_App.repositories.ProductRepository;
import vn.stu.edu.Food_App.repositories.ToppingRepository;
import vn.stu.edu.Food_App.sevices.ToppingService;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class ToppingServiceImpl implements ToppingService {

    private final ToppingRepository toppingRepository;
    private final ProductRepository productRepository;

    public ToppingServiceImpl(ToppingRepository toppingRepository, ProductRepository productRepository) {
        this.toppingRepository = toppingRepository;
        this.productRepository = productRepository;
    }

    @Override
    public List<ToppingDTO> getAll() {
        return toppingRepository.findAll().stream().map(ToppingDTO::new).collect(Collectors.toList());
    }

    @Override
    public ToppingDTO getById(int id) {
        Topping topping = toppingRepository.findById(id).orElseThrow(
                () -> new ResourceNotFoundException("Topping", "Id", String.valueOf(id))
        );
        return new ToppingDTO(topping);
    }



    @Override
    public String delete(int id) {
        Topping topping = toppingRepository.findById(id).orElseThrow(
                () -> new ResourceNotFoundException("Topping", "Id", String.valueOf(id))
        );
        toppingRepository.delete(topping);
        return "Delete Topping successfully";
    }

    @Override
    public List<ToppingDTO> getByProduct(String productId) {
        Product product1 = productRepository.findById(productId).orElseThrow(
                () -> new ResourceNotFoundException("Product", "Id", productId)
        );
        return toppingRepository.findByProduct(product1).stream().map(ToppingDTO::new).collect(Collectors.toList());
    }

    @Override
    public ToppingDTO edit(int toppingId, ToppingDTO toppingDTO) {
        Topping topping = toppingRepository.findById(toppingId).orElseThrow(
                () -> new ResourceNotFoundException("Topping", "Id", String.valueOf(toppingId))
        );
        topping.setName(toppingDTO.getName());
        topping.setPrice(toppingDTO.getPrice());
        return new ToppingDTO(toppingRepository.save(topping));
    }
}
