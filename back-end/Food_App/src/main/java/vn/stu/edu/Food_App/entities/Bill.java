package vn.stu.edu.Food_App.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Bill {
    @Id
    private String id;
    private LocalDateTime createDate;
    @Enumerated(EnumType.STRING)
    private Status status;
    @ManyToMany
    private Set<Discount> discounts = new HashSet<>();
    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
    @OneToMany(mappedBy = "bill", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<BillDetail> details = new ArrayList<>();
    @ManyToMany(mappedBy = "bills", cascade = CascadeType.ALL)
    private List<DeliverMan> deliverMen = new ArrayList<>();
}
