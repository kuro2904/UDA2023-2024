package vn.stu.edu.Food_App.entities;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Discount {
    @Id
    private String id;
    private long discount_percent;
    private String start_date;
    private String expire_date;
    @ManyToMany
    @JoinTable(name = "discount_bill",
    joinColumns = @JoinColumn(name = "discount_id",referencedColumnName = "id"),
    inverseJoinColumns = @JoinColumn(name = "bill_id",referencedColumnName = "id" ))
    private Set<Bill> bills = new HashSet<>();
    @ManyToMany
    @JoinTable(
            name = "discount_user",
            joinColumns = @JoinColumn(name = "discount_id"),
            inverseJoinColumns = @JoinColumn(name = "user_id")
    )
    private Set<User> users_used = new HashSet<>();
}
