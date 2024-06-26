package vn.stu.edu.Food_App.entities;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.GenericGenerator;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Setter
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Bill {
    @Id @GeneratedValue(generator="system-uuid")
    @GenericGenerator(name="system-uuid", strategy = "uuid")
    private String id;
    private String createDate;
    @Enumerated
    private Status status;
    @ManyToMany
    private Set<Discount> discounts = new HashSet<>();
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    private String cus_phone;
    private String cus_address;
    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true,targetEntity = BillDetail.class)
    private List<BillDetail> details = new ArrayList<>();
    @ManyToOne
    @JoinColumn(name = "delivery_man_id")
    private DeliverMan deliverMan;
    @Enumerated
    private PaymentMethod paymentMethod;
    private String note;

}
