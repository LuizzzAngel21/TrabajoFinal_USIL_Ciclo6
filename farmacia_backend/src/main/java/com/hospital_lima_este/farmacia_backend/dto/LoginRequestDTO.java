package com.hospital_lima_este.farmacia_backend.dto;

import lombok.Data;

@Data
public class LoginRequestDTO {
    private String nombreUsuario;
    private String contrasena;
}
