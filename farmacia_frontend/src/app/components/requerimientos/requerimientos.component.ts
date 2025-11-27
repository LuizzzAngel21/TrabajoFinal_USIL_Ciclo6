import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RequerimientoService } from '../../services/requerimiento.service';
import { AlmacenService } from '../../services/almacen.service'; // Asegúrate de tener este servicio
import { Requerimiento } from '../../models/requerimiento.model';

@Component({
  selector: 'app-requerimientos',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './requerimientos.component.html',
  styleUrls: ['./requerimientos.component.css']
})
export class RequerimientosComponent implements OnInit {

  // Nombre corregido para que coincida con tu HTML
  listaRequerimientos: Requerimiento[] = []; 
  
  // Lista para el selector de productos
  listaProductos: any[] = [];

  // Objeto del formulario
  nuevoReq = {
    idUsuarioSolicitante: 1,
    idDepartamento: 1,
    prioridad: 'MEDIA',
    observacion: '',
    idProducto: 0, // Para el select
    cantidad: 0    // Para el input
  };

  constructor(
    private requerimientoService: RequerimientoService,
    private almacenService: AlmacenService
  ) {}

  ngOnInit(): void {
    this.cargarDatos();
    this.cargarProductos();
  }

  cargarDatos() {
    // Corregido: Llama a 'getPendientes' que es el que existe en tu servicio
    this.requerimientoService.getPendientes().subscribe({
      next: (data: any) => {
        this.listaRequerimientos = data;
      },
      error: (err: any) => console.error('Error al cargar requerimientos', err)
    });
  }

  cargarProductos() {
    this.almacenService.getCatalogo().subscribe({
      next: (data: any) => {
        this.listaProductos = data;
      },
      error: (err: any) => console.error('Error al cargar productos', err)
    });
  }

  guardar() {
    // Aquí armamos el objeto final que espera el Backend
    // Nota: Depende de cómo hiciste tu DTO en Java. 
    // Si tu Java espera una lista de detalles, habría que ajustar esto.
    // Por ahora enviamos el objeto simple.
    
    this.requerimientoService.crear(this.nuevoReq).subscribe({
      next: () => {
        alert('Requerimiento creado con éxito');
        this.limpiarFormulario();
        this.cargarDatos();
      },
      error: (err: any) => {
        alert('Error al guardar');
        console.error(err);
      }
    });
  }

  atender(id: number) {
    if(confirm('¿Deseas atender este requerimiento?')) {
      this.requerimientoService.atender(id).subscribe({
        next: () => {
          alert('Procesado correctamente');
          this.cargarDatos();
        },
        error: (err: any) => {
          alert('Error al atender');
          console.error(err);
        }
      });
    }
  }

  limpiarFormulario() {
    this.nuevoReq.observacion = '';
    this.nuevoReq.cantidad = 0;
    this.nuevoReq.idProducto = 0;
  }
}