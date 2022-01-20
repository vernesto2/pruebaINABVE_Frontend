import { DetalleActivoModel } from "./detalleActivo.model";
import { DetalleActivoPKModel } from "./detalleActivoPK.model";

export class detalleAModel{
    codigoGenerado: string;
    nombre:string;
    idAdquisicion: number;
    correlativo:number;
    detalleActivos: DetalleActivoModel;
    precio: number;
}