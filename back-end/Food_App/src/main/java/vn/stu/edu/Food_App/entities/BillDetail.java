package vn.stu.edu.Food_App.entities;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.security.core.parameters.P;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@AllArgsConstructor
@Builder
@NoArgsConstructor
@Setter
@Getter
public class BillDetail {
    @Id @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private int quantity;
    @ManyToOne(targetEntity = Product.class)
    @JoinColumn(name = "product_id")
    private Product product;
    private String total_price;

}
