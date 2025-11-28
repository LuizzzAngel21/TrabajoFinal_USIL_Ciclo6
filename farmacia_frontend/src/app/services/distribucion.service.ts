import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
    providedIn: 'root'
})
export class DistribucionService {
    private apiUrl = 'http://localhost:8080/api/v1/distribucion';

    constructor(private http: HttpClient) { }

    getPendientes(): Observable<any[]> {
        return this.http.get<any[]>(`${this.apiUrl}/pendientes`);
    }

    getVehiculos(): Observable<any[]> {
        return this.http.get<any[]>(`${this.apiUrl}/vehiculos`);
    }

    asignarVehiculo(idOrden: number, idVehiculo: number): Observable<void> {
        return this.http.put<void>(`${this.apiUrl}/${idOrden}/asignar/${idVehiculo}`, {});
    }
}
