import { PersonaModel } from "./persona.model";
import { TelefonoPKModel } from "./telefonoPKModel.model";

export class TelefonoModel {
    id: TelefonoPKModel;
    tipoContacto: string;
    persona: PersonaModel;
}