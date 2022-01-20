import { EmpresaModel } from 'app/models/empresa.model';
import { CreditoModel } from "./credito.model";

export class CreditoEmpresaModel {
    idCredito: number;
    credito: CreditoModel;
    empresa: EmpresaModel;
    
}