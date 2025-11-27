import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { CompraService } from '../../services/compra.service';
import { ProveedorService } from '../../services/proveedor.service';
import { SolicitudCompra } from '../../models/compra.model';
import { Proveedor } from '../../models/proveedor.model';

@Component({
    selector: 'app-compras',
    standalone: true,
    imports: [CommonModule, FormsModule],
    templateUrl: './compras.component.html',
    styleUrls: ['./compras.component.css'],
})
export class ComprasComponent implements OnInit {
    solicitudes: SolicitudCompra[] = [];
    proveedores: Proveedor[] = [];

    solicitudSeleccionada: SolicitudCompra | null = null;
    idProveedor: number | null = null;

    // Variables para visualización y cálculo
    precioTotal: number = 0;
    precioUnitarioMostrado: number = 0;
    cantidadMostrada: number = 0;

    // Variables internas
    idProductoSeleccionado: number = 0;
    nombreProducto: string = '';

    constructor(
        private compraService: CompraService,
        private proveedorService: ProveedorService
    ) { }

    ngOnInit(): void {
        this.cargarSolicitudes();
        this.cargarProveedores();
    }

    cargarSolicitudes(): void {
        this.compraService.getSolicitudesPendientes().subscribe({
            next: (data: SolicitudCompra[]) => {
                this.solicitudes = data;
            },
            error: (err: any) => console.error('Error al cargar solicitudes', err),
        });
    }

    cargarProveedores(): void {
        this.proveedorService.listarProveedores().subscribe({
            next: (data: Proveedor[]) => {
                this.proveedores = data;
            },
            error: (err: any) => console.error('Error al cargar proveedores', err),
        });
    }

    abrirModal(solicitud: SolicitudCompra): void {
        this.solicitudSeleccionada = solicitud;
        this.idProveedor = null;

        // Resetear variables
        this.precioTotal = 0;
        this.precioUnitarioMostrado = 0;
        this.cantidadMostrada = 0;
        this.idProductoSeleccionado = 0;
        this.nombreProducto = solicitud.motivo;

        // Llamar al servicio para obtener detalles
        this.compraService.getDetallesSolicitud(solicitud.idSolicitud).subscribe({
            next: (detalles: any[]) => {
                if (detalles && detalles.length > 0) {
                    const detalle = detalles[0];

                    // Asignar variables mostradas
                    this.cantidadMostrada = detalle.cantidadSolicitada;
                    this.idProductoSeleccionado = detalle.producto ? detalle.producto.idProducto : (detalle.idProducto || 0);
                    this.nombreProducto = detalle.producto ? detalle.producto.nombreProducto : solicitud.motivo;

                    console.log('Detalles cargados:', detalle);

                    // Si ya hay proveedor seleccionado, recalcular
                    if (this.idProveedor) {
                        this.obtenerPrecioUnitario();
                    }
                } else {
                    console.warn('La solicitud no tiene detalles');
                }
            },
            error: (err) => {
                console.error('Error al cargar detalles de la solicitud', err);
            }
        });
    }

    obtenerPrecioUnitario(): void {
        if (this.idProveedor && this.idProductoSeleccionado > 0 && this.cantidadMostrada > 0) {

            this.proveedorService.getPrecioReferencial(this.idProductoSeleccionado, this.idProveedor).subscribe({
                next: (precioRef) => {
                    this.precioUnitarioMostrado = precioRef;
                    this.precioTotal = this.precioUnitarioMostrado * this.cantidadMostrada;

                    console.log('Precio Unitario:', this.precioUnitarioMostrado);
                    console.log('Total Calculado:', this.precioTotal);
                },
                error: (err) => {
                    console.error('Error al obtener precio referencial', err);
                    this.precioUnitarioMostrado = 0;
                    this.precioTotal = 0;
                }
            });
        } else {
            this.precioUnitarioMostrado = 0;
            this.precioTotal = 0;
        }
    }

    confirmarCompra(): void {
        if (!this.idProveedor || this.precioTotal <= 0 || !this.solicitudSeleccionada) {
            alert('Error: Debe seleccionar un proveedor y un precio total válido.');
            return;
        }

        const payload = {
            idSolicitud: this.solicitudSeleccionada.idSolicitud,
            idProveedor: this.idProveedor,
            precio: this.precioTotal,
        };

        this.compraService.generarOrden(payload).subscribe({
            next: () => {
                alert('Orden de Compra generada exitosamente');
                this.solicitudSeleccionada = null;
                this.cargarSolicitudes();
                // El modal se cerrará automáticamente por el atributo data-bs-dismiss en el botón
            },
            error: (err: any) => {
                console.error('Error al generar orden:', err);
                alert('Error al generar la orden');
            },
        });
    }
}