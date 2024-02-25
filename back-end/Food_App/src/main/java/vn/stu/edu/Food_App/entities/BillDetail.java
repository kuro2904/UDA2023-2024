package vn.stu.edu.Food_App.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.core.parameters.P;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Data
public class BillDetail {
    @Id @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private int quantity;
    @ManyToMany(targetEntity = Product.class)
    private Set<Product> products = new HashSet<>();
    private String total_price;

    public String getTotal_price() {
        long totalPrice = 1L;
        for(Product product : products){
            totalPrice = Long.parseLong(product.getPrice().replace("k VND","")) * quantity;
        }
        return String.valueOf(totalPrice) + "k VND";
    }
}
