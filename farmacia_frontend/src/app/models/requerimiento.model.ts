export interface Requerimiento {
    idRequerimiento: number;
    codigoSolicitud: string;      // <--- Debe llamarse igual que en el JSON
    nombreSolicitante: string;
    areaDepartamento: string;     // <--- Debe llamarse igual que en el JSON
    fechaSolicitud: string;
    estado: string;
    prioridad: string;
    colorPrioridad: string;
    cantidadItems: number;
}