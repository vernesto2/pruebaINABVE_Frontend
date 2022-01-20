import { CreditoModel } from './credito.model';
import { CuotaPKModel } from './cuotaPK.model';

export class CuotaModel {
    id: CuotaPKModel;
    diasAntesDespues: number;
    fechaCorrespondiente: Date;
    capitalAmortizado: number;
    mora: number;
    credito: CreditoModel;
}