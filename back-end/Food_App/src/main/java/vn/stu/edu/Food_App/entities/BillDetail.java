package vn.stu.edu.Food_App.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Data
public class BillDetail {
    @Id
    private int id;
    private int quantity;
    @ManyToOne
    @JoinColumn(name = "bill_id")
    private Bill bill;
    @OneToOne(targetEntity = Product.class)
    private Product product;
    private String total_price;
}
