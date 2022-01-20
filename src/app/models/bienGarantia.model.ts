import { CreditoModel } from "./credito.model";

export class BienGarantiaModel {
    codigo: string;
    descripcion: string;
    valoradoEn: number;
    tipoBien: string;
    creditos: CreditoModel;
}