package vn.stu.edu.Food_App.configs;

import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import vn.stu.edu.Food_App.entities.*;
import vn.stu.edu.Food_App.repositories.*;

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

        userRepository.saveAll(List.of(owner,cus));

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

        discountRepository.saveAll(List.of(discount2,discount));

        DeliverMan deliverMan1 = DeliverMan.builder()
                .name("Man1")
                .build();

        DeliverMan deliverMan2 = DeliverMan.builder()
                .name("Man2").build();

        deliverManRepository.saveAll(List.of(deliverMan1,deliverMan2));


    }
}
