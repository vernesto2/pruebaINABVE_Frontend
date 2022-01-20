import { PoliticaModel } from './../models/politica.model';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'environments/environment';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class PoliticasService {

  private base_uri = environment.base_uri;
  
  constructor(private http: HttpClient) { }

  agregarPoliticas(politicas: PoliticaModel): Observable<any> {
    return this.http.post(`${this.base_uri}/politica`, politicas, { observe: 'response' });
  }

  listarPoliticas(): Observable<any> {
    return this.http.get(`${this.base_uri}/politica`, { observe: 'response' });
  }
}
