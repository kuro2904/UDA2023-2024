package vn.stu.edu.Food_App.dtos;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DiscountDTO {
    private String id;
    private String name;
    private long discount_percent;
    private String start_date;
    private String expire_date;
}
