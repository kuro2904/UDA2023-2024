package vn.stu.edu.Food_App.dtos;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.util.List;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class BillDTO {
    private String id;
    private String user_email;
    private String cus_phone;
    private String cus_address;
    private String createDate;
    private String status;
    private String discountId;
    private String deliveryManId;
    private String paymentMethod;
    private String note;
    private List<BillDetailDTO> details;

    public BillDTO(String id, String email, String cus_phone, String cus_address, String createDate, String status, String paymentMethod, List<BillDetailDTO> details, String note) {
        this.id = id;
        this.user_email = email;
        this.cus_phone = cus_phone;
        this.cus_address = cus_address;
        this.createDate = createDate;
        this.status = status;
        this.paymentMethod = paymentMethod;
        this.details = details;
        this.note = note;
    }
}
