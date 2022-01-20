export class BeneficiosVeteranosModel {

    constructor() {
        this.id = 0;
        this.idVeterano = 0;
        this.idBeneficio = 0;
        this.fechaCreado = new Date();
        this.activo = true;
    }

    id: number;
    idVeterano: number;
    idBeneficio: number;
    fechaCreado: Date;
    activo: boolean;
}