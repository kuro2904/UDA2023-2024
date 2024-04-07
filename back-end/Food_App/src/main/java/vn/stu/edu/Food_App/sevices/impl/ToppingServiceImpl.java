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
    public ToppingDTO insert(ToppingDTO request) {
        Product product = productRepository.findById(request.getProduct().getId()).orElseThrow(
                () -> new ResourceNotFoundException("Product", "Id", request.getProduct().getId())
        );
        Topping topping = new Topping();
        topping.setName(request.getName());
        topping.setProduct(product);
        return new ToppingDTO(toppingRepository.save(topping));
    }

    @Override
    public ToppingDTO update(int id, ToppingDTO request) {
        Topping topping = toppingRepository.findById(id).orElseThrow(
                () -> new ResourceNotFoundException("Topping", "Id", String.valueOf(id))
        );
        Product product = productRepository.findById(request.getProduct().getId()).orElseThrow(
                () -> new ResourceNotFoundException("Product", "Id", request.getProduct().getId())
        );
        if (request.getName() != null && !request.getName().isBlank()) topping.setName(request.getName());
        if (request.getProduct() != null) topping.setProduct(product);
        return new ToppingDTO(toppingRepository.save(topping));
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
}
