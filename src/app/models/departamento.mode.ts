import { departamentoPKModel } from "./departamentoPK.model";
import { UnidadModel } from "./unidad.model";

export class DepartamentoModel {
    id: departamentoPKModel;
    nombre: string;
    unidad: UnidadModel;
}