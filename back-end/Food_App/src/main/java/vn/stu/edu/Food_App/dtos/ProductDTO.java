package vn.stu.edu.Food_App.dtos;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import vn.stu.edu.Food_App.entities.Product;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ProductDTO {
    private String id;
    private String name;
    private String price;
    private String description;
    private String imageUrl;
    private String categoryId;
    private List<ToppingDTO> topping = new ArrayList<>();

    public ProductDTO(Product product){
        this.id = product.getId();
        this.name = product.getName();
        this.price = product.getPrice();
        this.description = product.getDescription();
        this.imageUrl = product.getImageUrl();
        this.categoryId = product.getCategory().getId();
        this.topping = product.getToppings().stream().map(ToppingDTO::new).collect(Collectors.toList());
    }
}
