package vn.stu.edu.Food_App.sevices.impl;

import org.modelmapper.ModelMapper;
import vn.stu.edu.Food_App.dtos.UserDTO;
import vn.stu.edu.Food_App.entities.User;
import vn.stu.edu.Food_App.repositories.RoleRepository;
import vn.stu.edu.Food_App.repositories.UserRepository;
import vn.stu.edu.Food_App.sevices.UserService;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final ModelMapper mapper;

    public UserServiceImpl(UserRepository userRepository, RoleRepository roleRepository,ModelMapper mapper) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.mapper = mapper;
    }

    @Override
    public UserDTO insertUser(UserDTO userDTO) {
        return null;
    }

    @Override
    public UserDTO updateUser(String id, UserDTO userDTO) {
        return null;
    }

    @Override
    public String deleteUser(String id) {
        User user = userRepository.findById(id).orElseThrow(
                ()-> new RuntimeException("Cannot Found User By Id: " + id)
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

    @Override
    public UserDTO findById(String id) {
        User user = userRepository.findById(id).orElseThrow(
                ()-> new RuntimeException("Cannot Found User By Id: " + id)
        );
        return mapper.map(user,UserDTO.class);
    }

    @Override
    public UserDTO findByEmailOrPhone(String emailOrPhone) {
//        Optional<User> user = userRepository.findByEmail(emailOrPhone);
//        if (user.isEmpty()) user = userRepository.findByPhone(emailOrPhone);
//        if(user.isEmpty()) throw  new RuntimeException("Cannot Found User By Email Or Phone: " + emailOrPhone);
        return null;
    }
}
