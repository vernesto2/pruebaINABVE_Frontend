import { PersonaModel } from './persona.model';
import { CreditoModel } from "./credito.model";
import { GarantiaFiadorModel } from './garantiaFiador.model';
import { PersonaNaturalModel } from './personaNatural.model';

export class CreditoPersonalModel {
    idCredito: number;
    credito: CreditoModel;
    personaNatural: PersonaNaturalModel;
    //garantiaFiador: Array<GarantiaFiadorModel>;
    garantiaFiadors: Array<GarantiaFiadorModel> = [];
}