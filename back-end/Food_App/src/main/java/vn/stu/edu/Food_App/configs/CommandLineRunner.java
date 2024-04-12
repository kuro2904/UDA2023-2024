package vn.stu.edu.Food_App.configs;

import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import vn.stu.edu.Food_App.entities.*;
import vn.stu.edu.Food_App.repositories.*;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Component
@RequiredArgsConstructor
public class CommandLineRunner implements org.springframework.boot.CommandLineRunner {

    private final DiscountRepository discountRepository;
    private final DeliverManRepository deliverManRepository;
    private final RoleRepository roleRepository;
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final CategoryRepository categoryRepository;
    private final ToppingRepository toppingRepository;
    private final ProductRepository productRepository;

    @Override
    public void run(String... args) {

        Role role_owner = Role.builder()
                .name("ROLE_OWNER")
                .build();

        Role role_customer = Role.builder()
                .name("ROLE_CUSTOMER")
                .build();

        Set<Role> roles_owner = new HashSet<>();
        roles_owner.add(roleRepository.save(role_owner));
        Set<Role> roles_customer = new HashSet<>();
        roles_customer.add(roleRepository.save(role_customer));

        User owner = User.builder()
                .email("owner")
                .phoneNumber("owner")
                .password(passwordEncoder.encode("owner"))
                .address("owner")
                .roles(roles_owner)
                .build();

        User cus = User.builder()
                .email("trung2001sgp@gmail.com")
                .phoneNumber("0707965470")
                .password(passwordEncoder.encode("123456"))
                .address("tp HCM")
                .roles(roles_customer)
                .build();

        userRepository.saveAll(List.of(owner, cus));

        Discount discount = Discount.builder()
                .discount_percent(25)
                .expire_date("24-5-2021")
                .start_date("10-1-2021")
                .name("SUMMER")
                .build();

        Discount discount2 = Discount.builder()
                .discount_percent(15)
                .expire_date("24-10-2021")
                .start_date("10-12-2021")
                .name("WINTER")
                .build();

        discountRepository.saveAll(List.of(discount2, discount));

        DeliverMan deliverMan1 = DeliverMan.builder()
                .name("Man1")
                .build();

        DeliverMan deliverMan2 = DeliverMan.builder()
                .name("Man2").build();

        deliverManRepository.saveAll(List.of(deliverMan1, deliverMan2));

        Topping topping1 = Topping.builder()
                .name("topping1")
                .price("123")
                .build();
        Topping topping2 = Topping.builder()
                .name("topping2")
                .price("123")
                .build();

        List<Topping> toppings = toppingRepository.saveAll(List.of(topping2, topping1));

        Category category1 = Category.builder()
                .name("Category1")
                .description("asdasd")
                .build();

        Category category2 = Category.builder()
                .name("Category2")
                .description("asdasd")
                .build();

        categoryRepository.saveAll(List.of(category2, category1));

        Product product = Product.builder()
                .name("Product1")
                .price("1234k VND")
                .description("Product 1")
                .category(category1)
                .build();

        // Lưu sản phẩm vào cơ sở dữ liệu và nhận ID
        product = productRepository.save(product);

        // Tạo danh sách topping và truyền ID của sản phẩm
        List<Topping> productToppings = new ArrayList<>();
        for (Topping topping : toppings) {
            topping.setProduct(product);
            productToppings.add(topping);
        }

        // Lưu danh sách topping vào cơ sở dữ liệu
        toppingRepository.saveAll(productToppings);

        Product product1 = Product.builder()
                .name("Product2")
                .price("1234k VND")
                .description("Product 1")
                .category(category1)
                .build();

        Product product2 = Product.builder()
                .name("Product2")
                .price("1234k VND")
                .description("Product 1")
                .category(category2)
                .build();

        productRepository.saveAll(List.of(product, product1, product2));
    }
}
