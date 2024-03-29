package vn.stu.edu.Food_App.dtos;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Set;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class BillDetailDTO {
    private int quantity;
    private String productId;
    private String total_price;

    @Override
    public String toString() {
        return "BillDetailDTO{" +
                "quantity=" + quantity +
                ", productId='" + productId + '\'' +
                ", total_price='" + total_price + '\'' +
                '}';
    }
}
