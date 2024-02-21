package vn.stu.edu.Food_App.sevices.impl;

import org.modelmapper.ModelMapper;
import vn.stu.edu.Food_App.dtos.DiscountDTO;
import vn.stu.edu.Food_App.repositories.DiscountRepository;
import vn.stu.edu.Food_App.sevices.DiscountService;

import java.util.List;

public class DiscountServiceImpl implements DiscountService {

    private final ModelMapper mapper;
    private final DiscountRepository discountRepository;

    public DiscountServiceImpl(ModelMapper mapper, DiscountRepository discountRepository) {
        this.mapper = mapper;
        this.discountRepository = discountRepository;
    }

    @Override
    public DiscountDTO insertDiscount(DiscountDTO dto) {
        return null;
    }

    @Override
    public List<DiscountDTO> getAllDiscount() {
        return null;
    }

    @Override
    public DiscountDTO getDiscountById(String id) {
        return null;
    }
}
