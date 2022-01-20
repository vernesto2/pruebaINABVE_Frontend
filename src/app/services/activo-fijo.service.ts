import { ActivoFijoModel } from './../models/activoFijo.model';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'environments/environment';
import { Observable } from 'rxjs';
import { AdquisicionActivoModel } from 'app/models/adquisicionActivo.model';
import { BasePortalOutlet } from '@angular/cdk/portal';
import { BajaActivoModel } from 'app/models/bajaActivo.model';

@Injectable({
  providedIn: 'root'
})
export class ActivoFijoService {

  private base_uri = environment.base_uri;

  constructor(private http: HttpClient) { }

  listarUnidad(): Observable<any> {
    return this.http.get(`${this.base_uri}/unidad`,{observe: 'response'});
  }

  listarDepartamentoPorUnidad(codigo: number): Observable<any>  {
    return this.http.get(`${this.base_uri}/departamento/porunidad/${codigo}`,{observe: 'response'});
  }

  listarTipoActivo(): Observable<any> {
    return this.http.get(`${this.base_uri}/tipoactivo`,{observe: 'response'});
  }

  listarActivo(): Observable<any> {
    return this.http.get(`${this.base_uri}/activofijo`,{observe: 'response'});
  }

  listarEncargado(encargado:string): Observable<any> {
    return this.http.get(`${this.base_uri}/usuario/tipo/${encargado}`,{observe: 'response'});
  }

  agregarActivo(activo: ActivoFijoModel): Observable<any>  {
    return this.http.post(`${this.base_uri}/activofijo`, activo,{observe: 'response'});
  }

  bajaActivo(baja: BajaActivoModel): Observable<any>  {
    return this.http.post(`${this.base_uri}/bajaactivofijo`, baja,{observe: 'response'});
  }
 
  agregarAdquisicionActivo(adquisicion: AdquisicionActivoModel): Observable<any>  {
    return this.http.post(`${this.base_uri}/adquisicionactivofijo`, adquisicion,{observe: 'response'});
  }

  listarAdquisicion(): Observable<any> {
    return this.http.get(`${this.base_uri}/detalleactivofijo/disponibles`,{observe: 'response'});
  }

  listardebaja(): Observable<any> {
    return this.http.get(`${this.base_uri}/detalleactivofijo/baja`,{observe: 'response'});
  }

  listaragrupadatipo(): Observable<any> {
    return this.http.get(`${this.base_uri}/detalleactivofijo/agruparTipo`,{observe: 'response'});
  }

  listaragrupadaActivo(id:number): Observable<any> {
    return this.http.get(`${this.base_uri}/detalleactivofijo/agruparTipo/${id}`,{observe: 'response'});
  }

  listarActivos(id:number,idactivo): Observable<any> {
    return this.http.get(`${this.base_uri}/detalleactivofijo/agruparTipo/${id}/${idactivo}`,{observe: 'response'});
  }
}