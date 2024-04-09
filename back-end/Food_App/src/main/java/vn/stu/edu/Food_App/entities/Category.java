package vn.stu.edu.Food_App.entities;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.GenericGenerator;

import java.util.ArrayList;
import java.util.List;

@Entity
@Setter
@Getter
@NoArgsConstructor
@Builder
@AllArgsConstructor
@Table(name = "categories")
public class Category {
    @Id @GeneratedValue(generator="system-uuid")
    @GenericGenerator(name="system-uuid", strategy = "uuid")
    private String id;
    @Column(nullable = false)
    private String name;
    private String description;
    private String imageUrl;
    @OneToMany(mappedBy = "category",cascade = CascadeType.ALL)
    private List<Product> products;
}
