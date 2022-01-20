import { CreditoModel } from 'app/models/credito.model';
import { CreditoEmpresaModel } from './../models/creditoEmpresa.model';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { CreditoPersonalModel } from 'app/models/creditoPersonal.model';
import { environment } from 'environments/environment';
import { IngresoEgresoModel } from 'app/models/ingresoEgreso.model';

@Injectable({
  providedIn: 'root'
})
export class CreditosService {

  private base_uri = environment.base_uri;

  constructor(private http: HttpClient) { }

  //consultas de personas
  agregarCreditoPersona(credito: CreditoModel, tipoCredito: string, tipoTiempo: string): Observable<any> {
    if (tipoTiempo == 'año') {
      credito.tiempo = credito.tiempo * 12;
    }
    return this.http.post(`${this.base_uri}/credito/PERSONA/${tipoCredito}`, credito, { observe: 'response' });
  }

  comprobarIngresos(ingresosEgresosCliente: IngresoEgresoModel, ingresosEgresosFiador: IngresoEgresoModel): Observable<any> {
    return this.http.post(`${this.base_uri}/credito/ingresosegresos`, { ingresosEgresosFiador, ingresosEgresosCliente }, { observe: 'response' });
  }

  listaCreditoPersonaEnCurso(): Observable<any> {
    return this.http.get(`${this.base_uri}/credito/persona/encurso`, { observe: 'response' });
  }
  
  consultarSiPersonaPoseeCredito(dui: string): Observable<any> {
    return this.http.get(`${this.base_uri}/credito/librecredito/PERSONA/${dui}`, { observe: 'response' });
  }

  traerPago(idCredito: number): Observable<any> {
    return this.http.get(`${this.base_uri}/credito/pago/${idCredito}`, { observe: 'response' });
  }

  personaEnMora(): Observable<any> {
    return this.http.get(`${this.base_uri}/credito/persona/enmora/`, { observe: 'response' });
  }

  //Consultas de empresas
  agregarCreditoEmpresa(credito: CreditoModel, tipoCredito: string, tipoTiempo: string): Observable<any> {
    if (tipoTiempo == 'año') {
      credito.tiempo = credito.tiempo * 12;
    }
    return this.http.post(`${this.base_uri}/credito/EMPRESA/${tipoCredito}`, credito, { observe: 'response' });
  }

  consultarSiEmpresaPoseeCredito(nit: string): Observable<any> {
    return this.http.get(`${this.base_uri}/credito/librecredito/EMPRESA/${nit}`, { observe: 'response' });
  }

  listaCreditoEmpresaEnCurso(): Observable<any> {
    return this.http.get(`${this.base_uri}/credito/empresa/encurso`, { observe: 'response' });
  }

  buscarNitNombreEmpresa(buscar: string): Observable<any> {
    return this.http.get(`${this.base_uri}/empresa/buscar/${buscar}`, { observe: 'response' });
  }

  empresaEnMora(): Observable<any> {
    return this.http.get(`${this.base_uri}/credito/empresa/enmora/`, { observe: 'response' });
  }

  //Consultas que se usan tanto en persona como empresa
  obtenerBienPorCodigo(codigo: string): Observable<any> {
    return this.http.get(`${this.base_uri}/biengarantia/${codigo}`, { observe: 'response' });
  }

  consultarSiBiengarantiaPoseeCredito(codigo: string): Observable<any> {
    return this.http.get(`${this.base_uri}/credito/librecredito/BIENGARANTIA/${codigo}`, { observe: 'response' });
  }

  calcularPrecredito(monto: number, tiempo: number, tipoCredito: string, fecha: Date): Observable<any> {
    const dias = fecha.getDate(); //sacamos los dias actual
    const mes = fecha.getMonth(); // sacamos los meses actual
    const año = fecha.getFullYear(); // sacamos el año actual

    let fechas = año + '-' + mes + 1 + '-' + dias;
    return this.http.get(`${this.base_uri}/credito/precredito/${monto}/${tiempo}/${tipoCredito}/${fechas}`, { observe: 'response' });
  }

  rangoPolitica(): Observable<any> {
    return this.http.get(`${this.base_uri}/politica/rangopolitica`, { observe: 'response' });
  }

  //pago de cuotas
  hacerPagoCuota(idCredito: number): Observable<any> {
    return this.http.put(`${this.base_uri}/credito/pago/${idCredito}`, { observe: 'response' });
  }

  hacerPagoMayor(idCredito: number, efectivo: number): Observable<any> {
    console.log(efectivo);
    return this.http.put(`${this.base_uri}/credito/pago/${idCredito}/${efectivo}`, { observe: 'response' });
  }

}
