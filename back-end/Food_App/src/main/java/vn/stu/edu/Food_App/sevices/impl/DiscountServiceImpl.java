package vn.stu.edu.Food_App.sevices.impl;

import jakarta.transaction.Transactional;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import vn.stu.edu.Food_App.dtos.DiscountDTO;
import vn.stu.edu.Food_App.entities.Discount;
import vn.stu.edu.Food_App.exceptions.ResourceNotFoundException;
import vn.stu.edu.Food_App.repositories.DiscountRepository;
import vn.stu.edu.Food_App.sevices.DiscountService;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class DiscountServiceImpl implements DiscountService {

    private final ModelMapper mapper;
    private final DiscountRepository discountRepository;

    public DiscountServiceImpl(ModelMapper mapper, DiscountRepository discountRepository) {
        this.mapper = mapper;
        this.discountRepository = discountRepository;
    }

    @Override
    public DiscountDTO insertDiscount(DiscountDTO dto) {
        Discount discount = new Discount();
        discount.setName(dto.getName());
        discount.setDiscount_percent(dto.getDiscount_percent());
        discount.setStart_date(dto.getStart_date());
        discount.setExpire_date(dto.getExpire_date());
        return mapper.map(discountRepository.save(discount), DiscountDTO.class);
    }

    @Override
    public List<DiscountDTO> getAllDiscount() {
        return discountRepository.findAll().stream().map(
                discount -> mapper.map(discount, DiscountDTO.class)
        ).collect(Collectors.toList());
    }

    @Override
    public DiscountDTO getDiscountById(String id) {
        Discount discount = discountRepository.findById(id).orElseThrow(
                () -> new ResourceNotFoundException("Discount","Id",id)
        );
        return mapper.map(discount, DiscountDTO.class);
    }
}
