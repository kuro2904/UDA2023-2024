package vn.stu.edu.Food_App.entities;

import jakarta.persistence.*;
import lombok.*;
import vn.stu.edu.Food_App.dtos.ProductDTO;

@Setter
@Getter
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Topping {
    @Id @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private String name;
    private String price;
    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

    public Topping(String name){
        this.name = name;
    }
}
