import { AdquisicionActivoModel } from "./adquisicionActivo.model";
import { BajaActivoModel } from "./bajaActivo.model";
import { DetalleActivoPKModel } from "./detalleActivoPK.model";

export class DetalleActivoModel {
    id: DetalleActivoPKModel;
    precio: number;
    nombre: string;
    codigoGenerado: string;
    idAdquisicion: number;
    correlativo:number;
}