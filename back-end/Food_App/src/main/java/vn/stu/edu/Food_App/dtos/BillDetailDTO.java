package vn.stu.edu.Food_App.dtos;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class BillDetailDTO {
    private int quantity;
    private String productId;
    private String total_price;
    private List<ToppingDTO> topping = new ArrayList<>();
}
