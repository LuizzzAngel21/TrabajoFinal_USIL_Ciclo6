import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, tap } from 'rxjs';
import { Router } from '@angular/router';

@Injectable({
    providedIn: 'root'
})
export class AuthService {

    private apiUrl = 'http://localhost:8080/api/v1/auth';
    private userKey = 'user_session';

    constructor(private http: HttpClient, private router: Router) { }

    login(nombreUsuario: string, contrasena: string): Observable<any> {
        return this.http.post<any>(`${this.apiUrl}/login`, { nombreUsuario, contrasena }).pipe(
            tap(response => {
                localStorage.setItem(this.userKey, JSON.stringify(response));
            })
        );
    }

    logout(): void {
        localStorage.removeItem(this.userKey);
        this.router.navigate(['/login']);
    }

    isLoggedIn(): boolean {
        return !!localStorage.getItem(this.userKey);
    }

    getUserRole(): string | null {
        const user = this.getCurrentUser();
        return user ? user.rol : null;
    }

    getCurrentUser(): any {
        const userStr = localStorage.getItem(this.userKey);
        return userStr ? JSON.parse(userStr) : null;
    }
}
