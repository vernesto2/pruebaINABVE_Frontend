import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BeneficiosVeteranosModel } from 'app/models/beneficiosveteranos.model';
import { environment } from 'environments/environment';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class BeneficiosveteranosService {

  private base_uri = environment.base_uri + '/beneficiosveteranos';

  constructor(private http: HttpClient) { }

  //EndPoint de Ubicacion y Departamento (Combos)
  listarActivos(): Observable<any> {
    return this.http.get(`${this.base_uri}/listar`, { observe: 'response' });
  }

  obtenerPorId(id: number): Observable<any> {
    return this.http.get(`${this.base_uri}/obtenerporid/${id}`, { observe: 'response' });
  }

  insertar(beneficiosveteranos: BeneficiosVeteranosModel): Observable<any> {
    return this.http.post(`${this.base_uri}/crear`, beneficiosveteranos, { observe: 'response' });
  }

  actualizar(beneficiosveteranos: BeneficiosVeteranosModel): Observable<any> {
    return this.http.put(`${this.base_uri}/editar/${beneficiosveteranos.id}`, beneficiosveteranos, { observe: 'response' });
  }

  listarBeneficiosVinculados(idVeterano: number): Observable<any> {
    return this.http.get(`${this.base_uri}/listarBeneficiosVeteranos/${idVeterano}`, { observe: 'response' });
  }
}
