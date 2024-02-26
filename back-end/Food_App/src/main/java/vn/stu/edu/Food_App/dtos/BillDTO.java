package vn.stu.edu.Food_App.dtos;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class BillDTO {
    private String id;
    private String user_id;
    private String cus_phone;
    private String cus_address;
    private String createDate;
    private String status;
    private String discountId;
    private String deliveryManId;
    private String paymentMethod;
    private List<BillDetailDTO> details;

}
