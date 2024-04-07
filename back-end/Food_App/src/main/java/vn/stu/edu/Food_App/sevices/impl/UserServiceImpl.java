package vn.stu.edu.Food_App.sevices.impl;

import jakarta.transaction.Transactional;
import org.modelmapper.ModelMapper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import vn.stu.edu.Food_App.dtos.UserDTO;
import vn.stu.edu.Food_App.entities.User;
import vn.stu.edu.Food_App.exceptions.ResourceNotFoundException;
import vn.stu.edu.Food_App.repositories.RoleRepository;
import vn.stu.edu.Food_App.repositories.UserRepository;
import vn.stu.edu.Food_App.sevices.UserService;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final ModelMapper mapper;

    public UserServiceImpl(UserRepository userRepository, PasswordEncoder passwordEncoder, ModelMapper mapper) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.mapper = mapper;
    }

    @Override
    public UserDTO updateUser(String email, UserDTO userDTO) {
        User user = userRepository.findByEmail(email).orElseThrow(
                () -> new ResourceNotFoundException("User", "Email", email)
        );
        if(userDTO.getAddress() != null && !userDTO.getAddress().isBlank()) user.setAddress(userDTO.getAddress());
        if(userDTO.getEmail() != null && !userDTO.getEmail().isBlank()) user.setEmail(userDTO.getEmail());
        if(userDTO.getPhoneNumber() != null && !userDTO.getPhoneNumber().isBlank()) user.setPhoneNumber(userDTO.getPhoneNumber());
        if(userDTO.getPassword() != null && !userDTO.getPassword().isBlank()) user.setPassword(passwordEncoder.encode(userDTO.getPassword()));
        User rs = userRepository.save(user);
        return new UserDTO(
                rs.getId(),
                rs.getEmail(),
                rs.getPhoneNumber(),
                rs.getAddress(),
                rs.getRoles().stream().findFirst().get().getName(),
                rs.getPassword()
        );
    }

    @Override
    public String deleteUser(String id) {
        User user = userRepository.findById(id).orElseThrow(
                () -> new ResourceNotFoundException("User","Id", id)
        );
        userRepository.delete(user);
        return "Delete Complete";
    }

    @Override
    public List<UserDTO> getAllUser() {
        List<User> users = userRepository.findAll();
        return users.stream().map(
                user -> mapper.map(user,UserDTO.class)
        ).collect(Collectors.toList());
    }

}
