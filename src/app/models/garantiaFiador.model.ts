import { GarantiaFiadorPkModel } from './garantiaFiadorPk.model';
import { PersonaNaturalModel } from './personaNatural.model';
import { CreditoPersonalModel } from "./creditoPersonal.model";
import { IngresoEgresoModel } from "./ingresoEgreso.model";

export class GarantiaFiadorModel {
    id: GarantiaFiadorPkModel;
    creditoPersona: CreditoPersonalModel;
    //ingresoEgreso: Array<IngresoEgresoModel>;
    ingresoEgreso = new IngresoEgresoModel();
    personaNatual = new PersonaNaturalModel();
}