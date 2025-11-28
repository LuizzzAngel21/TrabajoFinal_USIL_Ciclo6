package com.hospital_lima_este.farmacia_backend.service;

import com.hospital_lima_este.farmacia_backend.dto.LoginRequestDTO;
import com.hospital_lima_este.farmacia_backend.dto.LoginResponseDTO;
import com.hospital_lima_este.farmacia_backend.model.Usuario;
import com.hospital_lima_este.farmacia_backend.repository.UsuarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final UsuarioRepository usuarioRepository;

    public LoginResponseDTO login(LoginRequestDTO request) {
        Usuario usuario = usuarioRepository.findByNombreUsuarioAndContrasenaAndActivoTrue(
                request.getNombreUsuario(), request.getContrasena())
                .orElseThrow(() -> new RuntimeException("Credenciales inválidas"));

        return LoginResponseDTO.builder()
                .idUsuario(usuario.getIdUsuario())
                .nombreUsuario(usuario.getNombreUsuario())
                .rol(usuario.getRol() != null ? usuario.getRol().getNombreRol() : "SIN_ROL")
                .build();
    }
}
