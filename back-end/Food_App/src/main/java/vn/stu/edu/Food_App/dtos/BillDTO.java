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
    private String user_email;
    private String cus_phone;
    private String cus_address;
    private String createDate;
    private String status;
    private String discountId;
    private String deliveryManId;
    private String paymentMethod;
    private List<BillDetailDTO> details;

    public BillDTO(String id, String email, String cus_phone, String cus_address, String createDate, String status, String paymentMethod, List<BillDetailDTO> details) {
        this.id = id;
        this.user_email = email;
        this.cus_phone = cus_phone;
        this.cus_address = cus_address;
        this.createDate = createDate;
        this.status = status;
        this.paymentMethod = paymentMethod;
        this.details = details;
    }

    @Override
    public String toString() {
        return "BillDTO{" +
                "id='" + id + '\'' +
                ", user_id='" + user_email + '\'' +
                ", cus_phone='" + cus_phone + '\'' +
                ", cus_address='" + cus_address + '\'' +
                ", createDate='" + createDate + '\'' +
                ", status='" + status + '\'' +
                ", discountId='" + discountId + '\'' +
                ", deliveryManId='" + deliveryManId + '\'' +
                ", paymentMethod='" + paymentMethod + '\'' +
                ", details=" + details +
                '}';
    }
}
