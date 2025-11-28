import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AlmacenService } from '../../services/almacen.service';
import { Producto } from '../../models/producto.model';

@Component({
    selector: 'app-almacen',
    standalone: true,
    imports: [CommonModule],
    templateUrl: './almacen.component.html',
    styleUrls: ['./almacen.component.css']
})
export class AlmacenComponent implements OnInit {
    productos: Producto[] = [];
    historial: any[] = [];
    productoSeleccionado: string = '';

    constructor(private almacenService: AlmacenService) { }

    ngOnInit(): void {
        this.almacenService.getCatalogo().subscribe({
            next: (data) => {
                this.productos = data;
            },
            error: (err) => {
                console.error('Error al cargar catálogo', err);
            }
        });
    }

    verHistorial(prod: any): void {
        this.productoSeleccionado = prod.nombre;
        this.historial = [];
        this.almacenService.getHistorial(prod.idProducto).subscribe({
            next: (data) => {
                this.historial = data;
            },
            error: (err) => {
                console.error('Error al cargar historial', err);
            }
        });
    }
}
