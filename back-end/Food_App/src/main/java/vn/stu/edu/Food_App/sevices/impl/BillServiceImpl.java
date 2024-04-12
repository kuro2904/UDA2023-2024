package vn.stu.edu.Food_App.sevices.impl;

import jakarta.transaction.Transactional;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import vn.stu.edu.Food_App.dtos.BillDTO;
import vn.stu.edu.Food_App.dtos.BillDetailDTO;
import vn.stu.edu.Food_App.dtos.ToppingDTO;
import vn.stu.edu.Food_App.entities.*;
import vn.stu.edu.Food_App.exceptions.ResourceNotFoundException;
import vn.stu.edu.Food_App.repositories.*;
import vn.stu.edu.Food_App.sevices.BillService;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class BillServiceImpl implements BillService {

    private final BillRepository billRepository;
    private final BillDetailRepository billDetailRepository;
    private final DeliverManRepository deliverManRepository;
    private final DiscountRepository discountRepository;
    private final UserRepository userRepository;
    private final ProductRepository productRepository;
    private final ToppingRepository toppingRepository;

    public BillServiceImpl(
            BillRepository billRepository,
            ToppingRepository toppingRepository,
            BillDetailRepository billDetailRepository,
            DeliverManRepository deliverManRepository,
            DiscountRepository discountRepository,
            UserRepository userRepository,
            ProductRepository productRepository) {
        this.billRepository = billRepository;
        this.billDetailRepository = billDetailRepository;
        this.deliverManRepository = deliverManRepository;
        this.discountRepository = discountRepository;
        this.userRepository = userRepository;
        this.productRepository = productRepository;
        this.toppingRepository = toppingRepository;
    }

    @Override
    public BillDTO placeOrder(BillDTO orderRequest) {
        Bill order = new Bill();
        Discount discount = null;
        DeliverMan deliverMan = null;
        List<BillDetail> details = new ArrayList<>();

        // Xử lý thông tin vận chuyển
        if (orderRequest.getDeliveryManId() != null) {
            deliverMan = deliverManRepository.findById(orderRequest.getDeliveryManId()).orElseThrow(
                    () -> new ResourceNotFoundException("Deliver man", "Id", orderRequest.getDeliveryManId())
            );
        }

        // Xử lý thông tin giảm giá
        if (orderRequest.getDiscountId() != null) {
            discount = discountRepository.findById(orderRequest.getDiscountId()).orElseThrow(
                    () -> new ResourceNotFoundException("Discount", "Id", orderRequest.getDiscountId())
            );
        }

        // Xử lý chi tiết đơn hàng
        for (var productDTO : orderRequest.getDetails()) {
            // Lấy thông tin sản phẩm từ cơ sở dữ liệu
            Product product = productRepository.findById(productDTO.getProductId()).orElseThrow(
                    () -> new ResourceNotFoundException("Product", "Id", productDTO.getProductId())
            );

            // Tạo một chi tiết đơn hàng mới
            BillDetail billDetail = new BillDetail();
            billDetail.setQuantity(productDTO.getQuantity());
            billDetail.setProduct(product);

            // Xử lý danh sách topping
            List<Topping> toppings = new ArrayList<>();
            for (ToppingDTO toppingDTO : productDTO.getTopping()) {
                // Kiểm tra xem topping đã tồn tại trong cơ sở dữ liệu hay chưa
                Topping topping = toppingRepository.findById(toppingDTO.getId()).orElse(null);

                // Nếu topping chưa tồn tại, thêm mới vào cơ sở dữ liệu
                if (topping == null) {
                    topping = new Topping();
                    topping.setId(toppingDTO.getId());
                    topping.setPrice(toppingDTO.getPrice());
                    // Lưu topping mới vào cơ sở dữ liệu
                    topping = toppingRepository.save(topping);
                }

                // Thêm topping vào danh sách của chi tiết đơn hàng
                toppings.add(topping);
            }

            // Thiết lập danh sách topping cho chi tiết đơn hàng
            billDetail.setToppings(toppings);

            // Lưu chi tiết đơn hàng vào danh sách chi tiết đơn hàng
            details.add(billDetailRepository.save(billDetail));
        }

        // Xử lý thông tin khách hàng
        if (orderRequest.getUser_email() != null && !orderRequest.getUser_email().isBlank()) {
            User customer = userRepository.findByEmail(orderRequest.getUser_email()).orElseThrow(
                    () -> new ResourceNotFoundException("User", "Email", orderRequest.getUser_email())
            );
            order.setUser(customer);
            order.setCus_address(customer.getAddress());
            order.setCus_phone(customer.getPhoneNumber());
        } else {
            order.setCus_phone(orderRequest.getCus_phone());
            order.setCus_address(orderRequest.getCus_address());
        }

        // Thiết lập thông tin vận chuyển và giảm giá
        if (deliverMan != null) {
            order.setDeliverMan(deliverMan);
        }
        if (discount != null) {
            order.getDiscounts().add(discount);
        }

        // Thiết lập các thông tin khác cho đơn hàng
        order.setPaymentMethod(PaymentMethod.valueOf(orderRequest.getPaymentMethod()));
        order.setCreateDate(orderRequest.getCreateDate());
        order.setStatus(Status.valueOf(orderRequest.getStatus()));
        order.setNote(orderRequest.getNote());
        order.setDetails(details);

        // Lưu đơn hàng vào cơ sở dữ liệu và trả về kết quả
        Bill bill = billRepository.save(order);
        return new BillDTO(
                bill.getId(),
                bill.getUser() == null ? "Unknown" : bill.getUser().getEmail(),
                bill.getCus_phone(),
                bill.getCus_address(),
                bill.getCreateDate(),
                bill.getStatus().name(),
                bill.getPaymentMethod().name(),
                bill.getDetails().stream().map(detail ->
                        new BillDetailDTO(detail.getQuantity(),
                                detail.getProduct().getId(),
                                detail.getTotal_price(),
                                detail.getToppings().stream().map(ToppingDTO::new).collect(Collectors.toList()))).collect(Collectors.toList()),
                bill.getNote()
        );
    }


    @Override
    public List<BillDTO> getAllOrder() {
        return billRepository.findAll().stream().map(bill -> new BillDTO(
                bill.getId(),
                bill.getUser() == null ? "Unknow" : bill.getUser().getId(),
                bill.getCus_phone(),
                bill.getCus_address(),
                bill.getCreateDate(),
                bill.getStatus().name(),
                bill.getPaymentMethod().name(),
                bill.getDetails().stream().map(details ->
                        new BillDetailDTO(details.getQuantity(),
                                details.getProduct().getId(),
                                details.getTotal_price(),
                                details.getToppings().stream().map(ToppingDTO::new).collect(Collectors.toList()))).collect(Collectors.toList()),
                bill.getNote()
        )).collect(Collectors.toList());
    }

    @Override
    public List<BillDTO> getHistoryOrder(String email) {
        User user = userRepository.findByEmail(email).orElseThrow(
                () -> new ResourceNotFoundException("User", "Email", email)
        );
        return billRepository.findByUser(user).stream().map(bill ->
                new BillDTO(
                        bill.getId(),
                        bill.getUser() == null ? "Unknown" : bill.getUser().getId(),
                        bill.getCus_phone(),
                        bill.getCus_address(),
                        bill.getCreateDate(),
                        bill.getStatus().name(),
                        bill.getPaymentMethod().name(),
                        bill.getDetails().stream().map(details ->
                                new BillDetailDTO(details.getQuantity(),
                                        details.getProduct().getId(),
                                        details.getTotal_price(),
                                        details.getToppings().stream().map(ToppingDTO::new).collect(Collectors.toList())))
                                .collect(Collectors.toList()),
                        bill.getNote()
                )).collect(Collectors.toList());
    }
}
