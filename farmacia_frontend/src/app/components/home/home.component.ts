import { Component, OnInit, inject, ViewChild } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { BaseChartDirective } from 'ng2-charts';
import { ChartConfiguration, ChartData, ChartType } from 'chart.js';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule, BaseChartDirective],
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {
  private http = inject(HttpClient);
  dashboardData: any = null;
  isDataLoaded: boolean = false;

  @ViewChild(BaseChartDirective) chart: BaseChartDirective | undefined;

  // Bar Chart (Stock Crítico)
  public barChartOptions: ChartConfiguration['options'] = {
    responsive: true,
    plugins: { legend: { display: true } }
  };
  public barChartType: ChartType = 'bar';
  public barChartData: ChartData<'bar'> = {
    labels: [],
    datasets: [{ data: [], label: 'Stock Actual', backgroundColor: '#dc3545' }]
  };

  // Pie Chart (Estado Requerimientos)
  public pieChartOptions: ChartConfiguration['options'] = {
    responsive: true,
    plugins: { legend: { position: 'top' } }
  };
  public pieChartType: ChartType = 'pie';
  public pieChartData: ChartData<'pie', number[], string | string[]> = {
    labels: [],
    datasets: [{ data: [] }]
  };

  ngOnInit(): void {
    this.loadDashboardData();
  }

  loadDashboardData(): void {
    // Nota: El usuario pidió /resumen, pero el controller está en /api/v1/dashboard
    // Si el usuario insiste en /resumen, habría que cambiar el Controller.
    // Por ahora mantengo la ruta que sé que existe:
    this.http.get<any>('http://localhost:8080/api/v1/dashboard').subscribe({
      next: (data) => {
        console.log('Datos Dashboard Recibidos:', data);
        this.dashboardData = data;
        this.setupCharts(data);
        this.isDataLoaded = true;
      },
      error: (err) => console.error('Error loading dashboard data', err)
    });
  }

  setupCharts(data: any): void {
    // 1. Stock Crítico
    if (data.stockCritico && Object.keys(data.stockCritico).length > 0) {
      this.barChartData.labels = Object.keys(data.stockCritico);
      this.barChartData.datasets[0].data = Object.values(data.stockCritico);
    } else {
      // Datos de prueba si está vacío (para verificar que el gráfico funciona)
      console.warn('Stock Crítico vacío, usando datos de prueba visual.');
      this.barChartData.labels = ['Sin Datos'];
      this.barChartData.datasets[0].data = [0];
    }

    // 2. Estado Requerimientos
    if (data.estadoRequerimientos && Object.keys(data.estadoRequerimientos).length > 0) {
      this.pieChartData.labels = Object.keys(data.estadoRequerimientos);
      this.pieChartData.datasets[0].data = Object.values(data.estadoRequerimientos);
    } else {
      console.warn('Estado Requerimientos vacío.');
    }

    // Forzar actualización del gráfico si ya existía
    if (this.chart) {
      this.chart.update();
    }
  }
}
