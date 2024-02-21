package vn.stu.edu.Food_App.sevices.impl;

import org.modelmapper.ModelMapper;
import vn.stu.edu.Food_App.dtos.DeliverManDTO;
import vn.stu.edu.Food_App.repositories.DeliverManRepository;
import vn.stu.edu.Food_App.sevices.DeliverManService;

import java.util.List;

public class DeliverManServiceImpl implements DeliverManService {

    private final ModelMapper mapper;
    private final DeliverManRepository deliverManRepository;

    public DeliverManServiceImpl(ModelMapper mapper, DeliverManRepository deliverManRepository) {
        this.mapper = mapper;
        this.deliverManRepository = deliverManRepository;
    }

    @Override
    public DeliverManDTO insertDeliveryMan(DeliverManDTO dto) {
        return null;
    }

    @Override
    public DeliverManDTO editDeliveryMan(String id, DeliverManDTO dto) {
        return null;
    }

    @Override
    public String deleteDeliveryMan(String id) {
        return null;
    }

    @Override
    public List<DeliverManDTO> getAll() {
        return null;
    }

    @Override
    public DeliverManDTO getById(String id) {
        return null;
    }
}
