package vn.stu.edu.Food_App.sevices;

import vn.stu.edu.Food_App.dtos.DiscountDTO;

import java.util.List;

public interface DiscountService {
    DiscountDTO insertDiscount(DiscountDTO dto);
    List<DiscountDTO> getAllDiscount();
    DiscountDTO getDiscountById(String id);
}
