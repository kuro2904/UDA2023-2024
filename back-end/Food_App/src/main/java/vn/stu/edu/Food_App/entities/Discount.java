package vn.stu.edu.Food_App.entities;


import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.GenericGenerator;

import java.util.HashSet;
import java.util.Set;

@Entity
@Setter
@Getter
@AllArgsConstructor
@Builder
@NoArgsConstructor
public class Discount {
    @Id @GeneratedValue(generator="system-uuid")
    @GenericGenerator(name="system-uuid", strategy = "uuid")
    private String id;
    private String name;
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
