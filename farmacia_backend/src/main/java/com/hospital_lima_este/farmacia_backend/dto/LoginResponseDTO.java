package com.hospital_lima_este.farmacia_backend.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class LoginResponseDTO {
    private Integer idUsuario;
    private String nombreUsuario;
    private String rol;
}
