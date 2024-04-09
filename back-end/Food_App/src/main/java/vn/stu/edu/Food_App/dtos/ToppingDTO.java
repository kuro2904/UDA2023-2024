package vn.stu.edu.Food_App.dtos;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import vn.stu.edu.Food_App.entities.Topping;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ToppingDTO {
    private int id;
    private String name;

    public ToppingDTO(Topping topping){
        this.id  = topping.getId();
        this.name = topping.getName();
    }
}
