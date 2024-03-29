package vn.stu.edu.Food_App.sevices;

import vn.stu.edu.Food_App.dtos.BillDTO;

import java.util.List;

public interface BillService {
    BillDTO placeOrder(BillDTO order);
    List<BillDTO> getAllOrder();

    List<BillDTO> getHistoryOrder(String email);
}
