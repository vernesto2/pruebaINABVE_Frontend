import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-razones',
  templateUrl: './razones.component.html',
  styleUrls: ['./razones.component.css']
})
export class RazonesComponent implements OnInit {

  fecha = '';
  liquidezCorriente;
  razonRapida;
  pruebaAcidicima;
  capitalTrabajo;
  pruebaAcidaDeudores;
  razonDeudaAKAccionistas;
  razonDeudaTAAT;
  razonCargosdeIntFijos;
  razonDeudaALPaKT;
  proporcionACaK;

  constructor() { }

  ngOnInit(): void {
    this.razonesFinancieras();
    const dia = new Date().getDate(); //sacamos los dias actual
    const mes = new Date().getMonth(); // sacamos los meses actual
    const ano = new Date().getFullYear(); // sacamos el año actual
    const hora = new Date().getHours();
    const minuto = new Date().getMinutes();

    if (minuto < 10) {
      this.fecha = dia + '-' + mes + 1 + '-' + ano + ' ' + hora + ':' + '0' + minuto;
    } else {
      this.fecha = dia + '-' + mes + 1 + '-' + ano + ' ' + hora + ':' + minuto;
    }
  }

  razonesFinancieras() {
    //Liquidez y Solvencia
    this.liquidezCorriente = localStorage.getItem('liquidezCorriente');
    this.razonRapida = localStorage.getItem('razonRapida');
    this.pruebaAcidicima = localStorage.getItem('pruebaAcidicima');
    this.capitalTrabajo = localStorage.getItem('pruebaAcidaDeudores');
    this.pruebaAcidaDeudores = localStorage.getItem('pruebaAcidaDeudores');

    //Analisis de endeudamiento
    this.razonDeudaAKAccionistas = localStorage.getItem('razonDeudaAKAccionistas');
    this.razonDeudaTAAT = localStorage.getItem('razonDeudaTAAT');
    this.razonCargosdeIntFijos = localStorage.getItem('razonCargosdeIntFijos');
    this.razonDeudaALPaKT = localStorage.getItem('razonDeudaALPaKT');
    this.proporcionACaK = localStorage.getItem('proporcionACaK');

  }

}
