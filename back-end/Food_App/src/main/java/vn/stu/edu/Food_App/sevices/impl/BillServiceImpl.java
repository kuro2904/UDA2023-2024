package vn.stu.edu.Food_App.sevices.impl;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import vn.stu.edu.Food_App.dtos.BillDTO;
import vn.stu.edu.Food_App.entities.*;
import vn.stu.edu.Food_App.exceptions.ResourceNotFoundException;
import vn.stu.edu.Food_App.repositories.*;
import vn.stu.edu.Food_App.sevices.BillService;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class BillServiceImpl implements BillService {

    private final BillRepository billRepository;
    private final BillDetailRepository billDetailRepository;
    private final DeliverManRepository deliverManRepository;
    private final DiscountRepository discountRepository;
    private final UserRepository userRepository;
    private final ProductRepository productRepository;
    private final ModelMapper mapper;

    public BillServiceImpl(BillRepository billRepository, BillDetailRepository billDetailRepository, DeliverManRepository deliverManRepository, DiscountRepository discountRepository, UserRepository userRepository, ProductRepository productRepository, ModelMapper mapper) {
        this.billRepository = billRepository;
        this.billDetailRepository = billDetailRepository;
        this.deliverManRepository = deliverManRepository;
        this.discountRepository = discountRepository;
        this.userRepository = userRepository;
        this.productRepository = productRepository;
        this.mapper = mapper;
    }

    @Override
    public BillDTO placeOrder(BillDTO orderRequest) {
        Bill order = new Bill();
        List<BillDetail> details = new ArrayList<>();
        DeliverMan deliverMan = deliverManRepository.findById(orderRequest.getDeliveryManId()).orElseThrow(
                ()-> new ResourceNotFoundException("Deliver man","Id", orderRequest.getDeliveryManId())
        );
        Discount discount = discountRepository.findById(orderRequest.getDiscountId()).orElseThrow(
                () -> new ResourceNotFoundException("Discount","Id",orderRequest.getDiscountId())
        );
        for(var products : orderRequest.getDetails()){
            Product product = productRepository.findById(products.getProductId()).orElseThrow(
                    () -> new ResourceNotFoundException("Product","Id", products.getProductId())
            );
            BillDetail billDetail = new BillDetail();
            billDetail.setQuantity(products.getQuantity());
            billDetail.setProducts(product);
            billDetail.setTotal_price(billDetail.getTotal_price());
            details.add(billDetailRepository.save(billDetail));
        }

        if(orderRequest.getUser_id() != null){
            User customer = userRepository.findById(orderRequest.getUser_id()).orElseThrow(
                    () -> new ResourceNotFoundException("User","Id", orderRequest.getUser_id())
            );
            order.setUser(customer);
            order.setCus_address(customer.getAddress());
            order.setCus_phone(customer.getPhoneNumber());
        }else {
            order.setCus_phone(orderRequest.getCus_phone());
            order.setCus_address(orderRequest.getCus_address());
        }
        order.getDeliverMen().add(deliverMan);
        order.setId(UUID.randomUUID().toString());
        order.getDiscounts().add(discount);
        order.setPaymentMethod(PaymentMethod.valueOf(orderRequest.getPaymentMethod()));
        order.setCreateDate(orderRequest.getCreateDate());
        order.setDetails(details);
        order.setCreateDate(orderRequest.getCreateDate());
        order.setStatus(Status.valueOf(orderRequest.getStatus()));
        return mapper.map(billRepository.save(order),BillDTO.class);
    }

    @Override
    public List<BillDTO> getAllOrder() {
        return billRepository.findAll().stream().map(bill -> mapper.map(bill, BillDTO.class)).collect(Collectors.toList());
    }
}
