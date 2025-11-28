import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { DistribucionService } from '../../services/distribucion.service';

@Component({
    selector: 'app-distribucion',
    standalone: true,
    imports: [CommonModule, FormsModule],
    templateUrl: './distribucion.component.html',
    styleUrls: ['./distribucion.component.css']
})
export class DistribucionComponent implements OnInit {
    ordenesPendientes: any[] = [];
    vehiculos: any[] = [];

    ordenSeleccionada: any = null;
    idVehiculoSeleccionado: number | null = null;

    constructor(private distribucionService: DistribucionService) { }

    ngOnInit(): void {
        this.cargarPendientes();
        this.cargarVehiculos();
    }

    cargarPendientes(): void {
        this.distribucionService.getPendientes().subscribe({
            next: (data) => this.ordenesPendientes = data,
            error: (err) => console.error('Error al cargar pendientes', err)
        });
    }

    cargarVehiculos(): void {
        this.distribucionService.getVehiculos().subscribe({
            next: (data) => this.vehiculos = data,
            error: (err) => console.error('Error al cargar vehículos', err)
        });
    }

    abrirModal(orden: any): void {
        this.ordenSeleccionada = orden;
        this.idVehiculoSeleccionado = null;
    }

    asignarVehiculo(): void {
        if (!this.ordenSeleccionada || !this.idVehiculoSeleccionado) {
            alert('Seleccione un vehículo');
            return;
        }

        this.distribucionService.asignarVehiculo(this.ordenSeleccionada.idOrdenDist, this.idVehiculoSeleccionado)
            .subscribe({
                next: () => {
                    alert('Vehículo asignado correctamente');
                    this.ordenSeleccionada = null;
                    this.cargarPendientes();
                    // Cerrar modal (manejado por data-bs-dismiss en el botón)
                },
                error: (err) => {
                    console.error('Error al asignar vehículo', err);
                    alert('Error al asignar vehículo');
                }
            });
    }
}
