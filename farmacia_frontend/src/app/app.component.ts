import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterOutlet, RouterLink, RouterLinkActive } from '@angular/router'; // <--- OJO AQUÍ
import { AuthService } from './services/auth.service';

@Component({
  selector: 'app-root',
  standalone: true,
  // IMPORTANTE: Aquí agregamos RouterLink y RouterLinkActive para que los botones funcionen
  imports: [CommonModule, RouterOutlet, RouterLink, RouterLinkActive], 
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'Hospital Lima Este';

  constructor(
    public router: Router, 
    public authService: AuthService
  ) {}

  esLogin(): boolean {
    return this.router.url === '/login';
  }

  logout(): void {
    this.authService.logout();
  }

  tienePermiso(rolesPermitidos: string[]): boolean {
    if (!this.authService.isLoggedIn()) {
      return false;
    }
    const userRole = (this.authService.getUserRole() || '').toUpperCase();
    
    if (userRole === 'ADMIN') {
      return true;
    }

    const permitidosUpper = rolesPermitidos.map(r => r.toUpperCase());
    return permitidosUpper.includes(userRole);
  }
}