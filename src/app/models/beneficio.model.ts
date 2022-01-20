export class BeneficioModel {

    constructor() {
        this.id = 0;
        this.nombre = "";
        this.descripcion
        this.fechaCreado = new Date();
        this.activo = true;
    }

    id: number;
    nombre: string;
    descripcion: string;
    fechaCreado: Date;
    activo: boolean;
}