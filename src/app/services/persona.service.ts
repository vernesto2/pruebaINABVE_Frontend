import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { environment } from 'environments/environment';
import { PersonaNaturalModel } from 'app/models/personaNatural.model';
import { Observable, throwError } from 'rxjs';
import { EmpresaModel } from 'app/models/empresa.model';
import { UsuarioModel } from 'app/models/usuario.model';

@Injectable({
  providedIn: 'root'
})
export class PersonaService {

  private base_uri = environment.base_uri;

  constructor(private http: HttpClient) { }

  //EndPoint de Ubicacion y Departamento (Combos)
  listarDepartamento(): Observable<any> {
    return this.http.get(`${this.base_uri}/ubicacion/departamentos`, { observe: 'response' });
  }

  listarMunicipioPorDepto(codigo: number): Observable<any> {
    return this.http.get(`${this.base_uri}/ubicacion/listamunicipios/${codigo}`, { observe: 'response' });
  }

  deptoPorCodigo(codigo: string): Observable<any> {
    //console.log(codigo);
    return this.http.get(`${this.base_uri}/ubicacion/${codigo}`, { observe: 'response' });
  }

  //EndPoint de Persona Natural
  listarPersonas(): Observable<any> {
    return this.http.get(`${this.base_uri}/personanatural`, { observe: 'response' });
  }

  agregarPersona(persona: PersonaNaturalModel): Observable<any> {
    return this.http.post(`${this.base_uri}/personanatural`, persona, { observe: 'response' });
  }

  editarPersona(persona: PersonaNaturalModel): Observable<any> {
    return this.http.put(`${this.base_uri}/personanatural/${persona.nit}`, persona, { observe: 'response' });
  }

  buscarPor(busqueda: any): Observable<any> {
    return this.http.get(`${this.base_uri}/personanatural/buscarpor/${busqueda}`, {observe: 'response'});
  }

  buscarNIT(nit: string): Observable<any> {
    return this.http.get(`${this.base_uri}/personanatural/nit/${nit}`, {observe: 'response'});
  }

  //EndPoint de Empresa
  listarEmpresa(): Observable<any> {
    return this.http.get(`${this.base_uri}/empresa`, {observe: 'response'});
  }

  agregarEmpresa(empresa: EmpresaModel): Observable<any> {
    return this.http.post(`${this.base_uri}/empresa`, empresa, { observe: 'response' });
  }

  editarEmpresa(empresa: EmpresaModel): Observable<any> {
    return this.http.put(`${this.base_uri}/empresa/${empresa.nit}`, empresa, { observe: 'response' });
  }

  buscarEmpresaNit(nit: string): Observable<any> {
    return this.http.get(`${this.base_uri}/empresa/${nit}`, { observe: 'response' });
  }

  simularFecha(fecha: string): Observable<any> {
    return this.http.put(`${this.base_uri}/fecha/${fecha}`, { observe: 'response' });
  }

  //EndPoint de Usuario
  agregarUsuario(usuario: UsuarioModel): Observable<any> {
    return this.http.post(`${this.base_uri}/usuario`, usuario, {observe: 'response'});
  }

  listarUsuario(): Observable<any> {
    return this.http.get(`${this.base_uri}/usuario`, {observe: 'response'});
  }

  editarUsuario(usuario: UsuarioModel): Observable<any> {
    return this.http.put(`${this.base_uri}/usuario/${usuario.nit}`, usuario, {observe: 'response'});
  }
}
