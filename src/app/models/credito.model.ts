import { CreditoPersonalModel } from './creditoPersonal.model';
import { CreditoEmpresaModel } from './creditoEmpresa.model';
import { PoliticaModel } from './politica.model';
import { UsuarioModel } from './usuario.model';
import { BienGarantiaModel } from './bienGarantia.model';

export class CreditoModel{
    id: number;
    estado: string;
    fechaAprobacion: Date;
    fechaCancelado: Date;
    fechaSolicitud: Date;
    monto: number;
    tiempo: number;
    puntos: number;
    bienGarantias: Array<BienGarantiaModel> = [];
    politica: PoliticaModel;
    usuario: UsuarioModel;
    creditoEmpresa: CreditoEmpresaModel;
    creditoPersona: CreditoPersonalModel;

}