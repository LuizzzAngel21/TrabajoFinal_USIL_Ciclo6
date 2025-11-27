export interface SolicitudCompra {
    idSolicitud: number;
    motivo: string;
    estado: string;
    fechaSolicitud: string;
    detalleSolicitudCompra?: any[]; // Array de detalles
}


