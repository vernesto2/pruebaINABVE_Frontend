import { DireccionModel } from "./direccion.model";
import { EmpresaModel } from "./empresa.model";
import { TelefonoModel } from "./telefono.model";

export class PersonaModel {
    nit: string;
    tipoPersona: string;
    empresa: EmpresaModel;
    direccion: DireccionModel;
    telefonos: Array<TelefonoModel>;
}