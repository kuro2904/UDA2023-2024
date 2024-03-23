package vn.stu.edu.Food_App.sevices;

import vn.stu.edu.Food_App.dtos.DeliverManDTO;

import java.util.List;

public interface DeliverManService {
    DeliverManDTO insertDeliveryMan(DeliverManDTO dto);
    DeliverManDTO editDeliveryMan(String id,DeliverManDTO dto);
    String deleteDeliveryMan(String id);
    List<DeliverManDTO> getAll();
    DeliverManDTO getById(String id);
}
