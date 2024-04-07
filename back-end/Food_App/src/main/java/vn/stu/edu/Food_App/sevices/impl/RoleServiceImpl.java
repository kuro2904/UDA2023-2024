package vn.stu.edu.Food_App.sevices.impl;

import jakarta.transaction.Transactional;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import vn.stu.edu.Food_App.dtos.RoleDTO;
import vn.stu.edu.Food_App.entities.Role;
import vn.stu.edu.Food_App.exceptions.ResourceNotFoundException;
import vn.stu.edu.Food_App.repositories.RoleRepository;
import vn.stu.edu.Food_App.sevices.RoleService;

import java.util.Set;
import java.util.stream.Collectors;

@Service
@Transactional
public class RoleServiceImpl implements RoleService {

    private final RoleRepository roleRepository;
    private final ModelMapper mapper;

    public RoleServiceImpl(RoleRepository roleRepository, ModelMapper mapper) {
        this.roleRepository = roleRepository;
        this.mapper = mapper;
    }

    @Override
    public RoleDTO createRole(RoleDTO dto) {
        Role role = mapper.map(dto, Role.class);
        return mapper.map(roleRepository.save(role),RoleDTO.class);
    }

    @Override
    public RoleDTO findById(String id) {
        Role role = roleRepository.findById(id).orElseThrow(
                () -> new ResourceNotFoundException("Role","Id", id)
        );
        return mapper.map(role,RoleDTO.class);
    }

    @Override
    public Set<RoleDTO> findAll() {
        return roleRepository.findAll().stream().map(
                role -> mapper.map(role,RoleDTO.class)
        ).collect(Collectors.toSet());
    }

    @Override
    public String deleteRole(String id) {
        Role role = roleRepository.findById(id).orElseThrow(
                () -> new ResourceNotFoundException("Role","Id", id)
        );
        roleRepository.delete(role);
        return "Delete Complete";
    }

    @Override
    public RoleDTO updateRole(String id, RoleDTO dto) {
        Role role = roleRepository.findById(id).orElseThrow(
                () -> new ResourceNotFoundException("Role","Id", id)
        );
        role.setName(dto.getName());
        return mapper.map(roleRepository.save(role),RoleDTO.class);
    }
}
