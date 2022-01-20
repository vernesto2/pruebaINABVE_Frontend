import { DetalleActivoModel } from "./detalleActivo.model";
import { DetalleActivoPKModel } from "./detalleActivoPK.model";

export class BajaActivoModel {
    fecha: Date;
    motivo: string;
    detalleActivos: Array<DetalleActivoModel>;
    
}