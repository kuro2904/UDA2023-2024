package vn.stu.edu.Food_App.security;

import org.modelmapper.ModelMapper;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import vn.stu.edu.Food_App.dtos.UserDTO;
import vn.stu.edu.Food_App.dtos.auth.LoginDTO;
import vn.stu.edu.Food_App.dtos.auth.RegisterDTO;
import vn.stu.edu.Food_App.entities.Role;
import vn.stu.edu.Food_App.entities.User;
import vn.stu.edu.Food_App.exceptions.FoodAppAPIException;
import vn.stu.edu.Food_App.exceptions.ResourceNotFoundException;
import vn.stu.edu.Food_App.repositories.RoleRepository;
import vn.stu.edu.Food_App.repositories.UserRepository;
import vn.stu.edu.Food_App.security.AuthService;

import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

@Service
public class AthServiceImpl implements AuthService {

    private final AuthenticationManager authenticationManager;
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PasswordEncoder passwordEncoder;
    private final ModelMapper mapper;

    public AthServiceImpl(AuthenticationManager authenticationManager, UserRepository userRepository, RoleRepository roleRepository, PasswordEncoder passwordEncoder, ModelMapper mapper) {
        this.authenticationManager = authenticationManager;
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.passwordEncoder = passwordEncoder;
        this.mapper = mapper;
    }

    @Override
    public String login(LoginDTO dto) {
        Authentication authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(
                dto.getEmail(),dto.getPassword()
        ));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        return "Login Successfully";
    }

    @Override
    public UserDTO register(RegisterDTO dto) {
        if(userRepository.existsByEmail(dto.getEmail())) throw new FoodAppAPIException(HttpStatus.BAD_REQUEST, "Email is already exists");
        if(userRepository.existsByPhoneNumber(dto.getPhoneNumber())) throw new FoodAppAPIException(HttpStatus.BAD_REQUEST, "Phone is already exists");
        String randomID = UUID.randomUUID().toString().substring(0,30);
        User user = new User();
        user.setId(randomID);
        user.setEmail(dto.getEmail());
        user.setPassword(passwordEncoder.encode(dto.getPassword()));
        user.setAddress(dto.getAddress());
        user.setPhoneNumber(dto.getPhoneNumber());
        Set<Role> roles = new HashSet<>();
        Role user_role = roleRepository.findByName("ROLE_CUSTOMER").orElseThrow(
                () -> new ResourceNotFoundException("Role","Name","ROLE_CUSTOMER")
        );
        roles.add(user_role);
        user.setRoles(roles);
        return mapper.map(userRepository.save(user), UserDTO.class);
    }

    @Override
    public UserDTO registerAdmin(RegisterDTO dto) {
        if(userRepository.existsByEmail(dto.getEmail())) throw new FoodAppAPIException(HttpStatus.BAD_REQUEST, "Email is already exists");
        if(userRepository.existsByPhoneNumber(dto.getPhoneNumber())) throw new FoodAppAPIException(HttpStatus.BAD_REQUEST, "Phone is already exists");
        String randomID = UUID.randomUUID().toString().substring(0,30);
        User user = new User();
        user.setId(randomID);
        user.setEmail(dto.getEmail());
        user.setPassword(passwordEncoder.encode(dto.getPassword()));
        user.setAddress(dto.getAddress());
        user.setPhoneNumber(dto.getPhoneNumber());
        Set<Role> roles = new HashSet<>();
        Role user_role = roleRepository.findByName("ROLE_ADMIN").orElseThrow(
                () -> new ResourceNotFoundException("Role","Name","ROLE_ADMIN")
        );
        roles.add(user_role);
        user.setRoles(roles);
        return mapper.map(userRepository.save(user), UserDTO.class);
    }

    @Override
    public UserDTO createSuperUser(RegisterDTO dto) {
        if(userRepository.existsByEmail(dto.getEmail())) throw new FoodAppAPIException(HttpStatus.BAD_REQUEST, "Email is already exists");
        if(userRepository.existsByPhoneNumber(dto.getPhoneNumber())) throw new FoodAppAPIException(HttpStatus.BAD_REQUEST, "Phone is already exists");
        String randomID = UUID.randomUUID().toString().substring(0,30);
        User user = new User();
        user.setId(randomID);
        user.setEmail(dto.getEmail());
        user.setPassword(passwordEncoder.encode(dto.getPassword()));
        user.setAddress(dto.getAddress());
        user.setPhoneNumber(dto.getPhoneNumber());
        Set<Role> roles = new HashSet<>();
        Role user_role = roleRepository.save(new Role("ROLE_OWNER","ROLE_OWNER"));
        roles.add(user_role);
        user.setRoles(roles);
        return mapper.map(userRepository.save(user), UserDTO.class);
    }
}
