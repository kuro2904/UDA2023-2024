package vn.stu.edu.Food_App.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
public class DeliverMan {
    @Id
    private String id;
    private String name;
    @ManyToMany
    @JoinTable(
            name = "delivers_bills",
            joinColumns = @JoinColumn(name = "dilivery_man_id",referencedColumnName = "id"),
            inverseJoinColumns = @JoinColumn(name = "bill_id",referencedColumnName = "id")
    )
    private List<Bill> bills = new ArrayList<>();
}
