package vn.stu.edu.Food_App.sevices;

import vn.stu.edu.Food_App.dtos.RoleDTO;

import java.util.List;
import java.util.Optional;
import java.util.Set;

public interface RoleService {
    RoleDTO createRole(RoleDTO dto);
    RoleDTO findById(String id);
    Set<RoleDTO> findAll();
    String deleteRole(String id);
    RoleDTO updateRole(String id, RoleDTO dto);
}
