import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { SolicitudCompra } from '../models/compra.model';

@Injectable({
    providedIn: 'root'
})
export class CompraService {

    private apiUrl = 'http://localhost:8080/api/v1/compras';

    constructor(private http: HttpClient) { }

    getSolicitudesPendientes(): Observable<SolicitudCompra[]> {
        return this.http.get<SolicitudCompra[]>(`${this.apiUrl}/solicitudes`);
    }

    getDetallesSolicitud(idSolicitud: number): Observable<any[]> {
        return this.http.get<any[]>(`${this.apiUrl}/solicitudes/${idSolicitud}/detalles`);
    }

    generarOrden(payload: any): Observable<void> {
        return this.http.post<void>(`${this.apiUrl}/generar-orden`, payload);
    }

    getOrdenesEmitidas(): Observable<any[]> {
        return this.http.get<any[]>(`${this.apiUrl}/ordenes`);
    }

    recepcionarOrden(idOrden: number): Observable<void> {
        return this.http.post<void>(`${this.apiUrl}/ordenes/${idOrden}/recepcionar`, {});
    }
}
