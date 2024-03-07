package vn.stu.edu.Food_App.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.validation.annotation.Validated;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Validated
@Table(name = "products")
public class Product {
    @Id
    @Column(length = 10)
    private String id;
    @Column(nullable = false, length = 30)
    private String name;
    @Column(nullable = false,length = 10)
    private String price;
    @Column( nullable = false, length = 2555)
    private String description;

    private String imageUrl;
    @ManyToOne
    @JoinColumn(name = "category_id")
    private Category category;
}
