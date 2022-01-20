import { CreditoEmpresaModel } from './creditoEmpresa.model';
import { PersonaModel } from "./persona.model";
import { PersonaNaturalModel } from "./personaNatural.model";

export class EmpresaModel {
    nit: string;
    personaNatural: PersonaNaturalModel;
    nombre: string;
    persona: PersonaModel;
    creditoEmpresa: CreditoEmpresaModel;
}