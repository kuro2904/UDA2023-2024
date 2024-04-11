package vn.stu.edu.Food_App.entities;

import jakarta.persistence.*;
import lombok.*;
import vn.stu.edu.Food_App.dtos.ProductDTO;

import java.util.List;

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
    @ManyToMany(mappedBy = "toppings")
    private List<BillDetail> billDetails;
    public Topping(String name){
        this.name = name;
    }
}
