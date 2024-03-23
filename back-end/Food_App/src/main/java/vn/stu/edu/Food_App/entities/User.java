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
    @Column(length = 30, unique = true, nullable = false)
    private String email;
    @Column(nullable = false)
    private String password;
    @Column(length = 30, nullable = false)
    private String phoneNumber;
    @Column(length = 300, nullable = false)
    private String address;
    @ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    // Important ( fetch EAGER to query Role unless cannot authorize )
    @JoinTable(
            name = "users_roles",
            joinColumns = @JoinColumn(name = "user_id", referencedColumnName = "id"),
            inverseJoinColumns = @JoinColumn(name = "role_id", referencedColumnName = "id")
    )
    private Set<Role> roles;
    @OneToMany(mappedBy = "user")
    private List<Bill> bills;
    @ManyToMany(mappedBy = "users_used")
    private Set<Discount> discountsUsed = new HashSet<>();
}
