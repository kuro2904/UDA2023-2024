package vn.stu.edu.Food_App.dtos;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DiscountDTO {
    private String id;
    private long discount_percent;
    private String start_date;
    private String expire_date;
}
