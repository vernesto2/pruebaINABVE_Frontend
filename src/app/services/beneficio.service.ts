import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BeneficioModel } from 'app/models/beneficio.model';
import { environment } from 'environments/environment';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class BeneficioService {

  private base_uri = environment.base_uri + '/beneficio';

  constructor(private http: HttpClient) { }

  //EndPoint de Ubicacion y Departamento (Combos)
  listarActivos(): Observable<any> {
    return this.http.get(`${this.base_uri}/listar`, { observe: 'response' });
  }

  obtenerPorId(id: number): Observable<any> {
    return this.http.get(`${this.base_uri}/obtenerporid/${id}`, { observe: 'response' });
  }

  insertar(beneficio: BeneficioModel): Observable<any> {
    return this.http.post(`${this.base_uri}/crear`, beneficio, { observe: 'response' });
  }

  actualizar(beneficio: BeneficioModel): Observable<any> {
    return this.http.put(`${this.base_uri}/editar/${beneficio.id}`, beneficio, { observe: 'response' });
  }
}
