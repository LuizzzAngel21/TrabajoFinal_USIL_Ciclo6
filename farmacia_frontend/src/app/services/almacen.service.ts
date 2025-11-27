import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Producto } from '../models/producto.model';

@Injectable({
    providedIn: 'root'
})
export class AlmacenService {

    private apiUrl = 'http://localhost:8080/api/v1/almacen';

    constructor(private http: HttpClient) { }

    getCatalogo(): Observable<Producto[]> {
        return this.http.get<Producto[]>(`${this.apiUrl}/catalogo`);
    }
}
