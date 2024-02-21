package vn.stu.edu.Food_App.sevices.impl;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import vn.stu.edu.Food_App.dtos.DeliverManDTO;
import vn.stu.edu.Food_App.entities.DeliverMan;
import vn.stu.edu.Food_App.repositories.DeliverManRepository;
import vn.stu.edu.Food_App.sevices.DeliverManService;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class DeliverManServiceImpl implements DeliverManService {

    private final ModelMapper mapper;
    private final DeliverManRepository deliverManRepository;

    public DeliverManServiceImpl(ModelMapper mapper, DeliverManRepository deliverManRepository) {
        this.mapper = mapper;
        this.deliverManRepository = deliverManRepository;
    }

    @Override
    public DeliverManDTO insertDeliveryMan(DeliverManDTO dto) {
        DeliverMan deliverMan = new DeliverMan();
        deliverMan.setId(dto.getId());
        deliverMan.setName(dto.getName());
        return mapper.map(deliverManRepository.save(deliverMan),DeliverManDTO.class);
    }

    @Override
    public DeliverManDTO editDeliveryMan(String id, DeliverManDTO dto) {
        DeliverMan deliverMan = deliverManRepository.findById(id).orElseThrow(
                () -> new RuntimeException("Cannot Found Delivery Man: " + id)
        );
        if(dto.getName() != null) deliverMan.setName(dto.getName());
        return mapper.map(deliverMan,DeliverManDTO.class);
    }

    @Override
    public String deleteDeliveryMan(String id) {
        DeliverMan deliverMan = deliverManRepository.findById(id).orElseThrow(
                () -> new RuntimeException("Cannot Found Delivery Man: " + id)
        );
        deliverManRepository.delete(deliverMan);
        return "Delete Complete";
    }

    @Override
    public List<DeliverManDTO> getAll() {
        return deliverManRepository.findAll().stream().map(
                deliverMan -> mapper.map(deliverMan,DeliverManDTO.class)
        ).collect(Collectors.toList());
    }

    @Override
    public DeliverManDTO getById(String id) {
        DeliverMan deliverMan = deliverManRepository.findById(id).orElseThrow(
                () -> new RuntimeException("Cannot Found Delivery Man: " + id)
        );
        return mapper.map(deliverMan,DeliverManDTO.class);
    }
}
