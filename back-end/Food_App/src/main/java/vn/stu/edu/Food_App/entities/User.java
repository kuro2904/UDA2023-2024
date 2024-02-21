package vn.stu.edu.Food_App.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    @Id
    @Column(length = 30)
    private String id;
    @Column(length = 30,unique = true,nullable = false)
    private String email;
    @Column(nullable = false)
    private String password;
    @Column(length = 30,nullable = false)
    private String phone_number;
    @Column(length = 300, nullable = false)
    private String address;
    @ManyToOne
    @JoinColumn(name = "role_id")
    private Role role;
    @OneToMany(mappedBy = "user")
    private List<Bill> bills;
    @ManyToMany(mappedBy = "users_used")
    private Set<Discount> discountsUsed = new HashSet<>();

}
