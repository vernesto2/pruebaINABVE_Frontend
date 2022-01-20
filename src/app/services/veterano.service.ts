import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { VeteranoModel } from 'app/models/veterano.model';
import { environment } from 'environments/environment';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class VeteranoService {

  private base_uri = environment.base_uri + '/veterano';

  constructor(private http: HttpClient) { }

  //EndPoint de Ubicacion y Departamento (Combos)
  listarActivos(): Observable<any> {
    return this.http.get(`${this.base_uri}/listar`, { observe: 'response' });
  }

  obtenerPorId(id: number): Observable<any> {
    return this.http.get(`${this.base_uri}/obtenerporid/${id}`, { observe: 'response' });
  }

  insertar(veterano: VeteranoModel): Observable<any> {
    return this.http.post(`${this.base_uri}/crear`, veterano, { observe: 'response' });
  }

  actualizar(veterano: VeteranoModel): Observable<any> {
    return this.http.put(`${this.base_uri}/editar/${veterano.id}`, veterano, { observe: 'response' });
  }
}
