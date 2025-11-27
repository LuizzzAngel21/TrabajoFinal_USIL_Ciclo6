export interface Proveedor {
    idProveedor: number;
    nombreProveedor: string;
    ruc: string;
    direccion?: string;
    telefono?: string;
    correo?: string;
    estado: boolean;
}
