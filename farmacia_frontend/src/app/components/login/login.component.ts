import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../services/auth.service';

@Component({
    selector: 'app-login',
    standalone: true,
    imports: [CommonModule, FormsModule],
    templateUrl: './login.component.html',
    styleUrls: ['./login.component.css']
})
export class LoginComponent {
    nombreUsuario: string = '';
    contrasena: string = '';
    errorMessage: string = '';

    constructor(private authService: AuthService, private router: Router) { }

    onSubmit(): void {
        this.errorMessage = '';
        this.authService.login(this.nombreUsuario, this.contrasena).subscribe({
            next: () => {
                const role = this.authService.getUserRole();
                switch (role) {
                    case 'SOLICITANTE':
                        this.router.navigate(['/requerimientos']);
                        break;
                    case 'COMPRAS':
                        this.router.navigate(['/compras']);
                        break;
                    case 'ALMACEN':
                        this.router.navigate(['/almacen']);
                        break;
                    case 'ADMIN':
                        this.router.navigate(['/requerimientos']);
                        break;
                    default:
                        this.router.navigate(['/requerimientos']);
                        break;
                }
            },
            error: (err) => {
                console.error('Login error', err);
                this.errorMessage = 'Credenciales incorrectas. Intente nuevamente.';
            }
        });
    }
}
