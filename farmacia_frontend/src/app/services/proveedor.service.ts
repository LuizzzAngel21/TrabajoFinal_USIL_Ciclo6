import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Proveedor } from '../models/proveedor.model';

@Injectable({
    providedIn: 'root'
})
export class ProveedorService {

    private apiUrl = 'http://localhost:8080/api/v1/compras/proveedores';

    constructor(private http: HttpClient) { }

    listarProveedores(): Observable<Proveedor[]> {
        return this.http.get<Proveedor[]>(this.apiUrl);
    }

    getPrecioReferencial(idProducto: number, idProveedor: number): Observable<number> {
        return this.http.get<number>(`http://localhost:8080/api/v1/compras/precio/${idProducto}/${idProveedor}`);
    }
}
