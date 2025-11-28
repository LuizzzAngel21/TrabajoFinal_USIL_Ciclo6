package com.hospital_lima_este.farmacia_backend.controller;

import com.hospital_lima_este.farmacia_backend.dto.LoginRequestDTO;
import com.hospital_lima_este.farmacia_backend.dto.LoginResponseDTO;
import com.hospital_lima_este.farmacia_backend.service.AuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/auth")
@CrossOrigin(origins = "*")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequestDTO request) {
        try {
            LoginResponseDTO response = authService.login(request);
            return ResponseEntity.ok(response);
        } catch (RuntimeException e) {
            return ResponseEntity.status(401).body("Error: " + e.getMessage());
        }
    }
}
