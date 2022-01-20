export class VeteranoModel {

    constructor() {
        this.id = 0;
        this.dui = "";
        this.carnet = "";
        this.primerNombre
        this.primerNombre = "";
        this.segundoNombre = "";
        this.primerApellido = "";
        this.segundoApellido = "";
        this.fechaCreado = new Date();
        this.activo = true;
    }

    id: number;
    dui: string;
    carnet: string;
    primerNombre: string;
    segundoNombre: string;
    primerApellido: string;
    segundoApellido: string;
    fechaCreado: Date;
    activo: boolean;
}