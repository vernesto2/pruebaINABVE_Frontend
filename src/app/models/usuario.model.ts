import { CreditoModel } from "./credito.model";

export class UsuarioModel {
    nit: string;
    nombre: string;
    clave: string;
    reClave: string;
    tipo: string;
    creditos: Array<CreditoModel>;
}