import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Requerimiento } from '../models/requerimiento.model';

@Injectable({
    providedIn: 'root'
})
export class RequerimientoService {

    private apiUrl = 'http://localhost:8080/api/v1/requerimientos';

    constructor(private http: HttpClient) { }

    // Listar
    getPendientes(): Observable<Requerimiento[]> {
        return this.http.get<Requerimiento[]>(`${this.apiUrl}/pendientes`);
    }

    // Crear
    crear(datos: any): Observable<any> {
        return this.http.post(this.apiUrl, datos);
    }

    // Atender
    atender(id: number): Observable<any> {
        return this.http.put(`${this.apiUrl}/${id}/atender`, {});
    }
}
