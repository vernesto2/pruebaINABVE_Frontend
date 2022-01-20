import { ActivoFijoModel } from "./activoFijo.model";
import { DepartamentoModel } from "./departamento.mode";
import { UsuarioModel } from "./usuario.model";

export class AdquisicionActivoModel {
    id: number;
    descripcion: string;
    fecha: Date;
    precioUnidad: number;
    cantidad: number;
    tipoAdquisicion: string;
    vidaUtil: number;
    activoFijo: ActivoFijoModel;
    departamento: DepartamentoModel;
    usuario: UsuarioModel;
}