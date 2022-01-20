import { Component, Inject, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { RazonesModel } from 'app/models/razones.model';

@Component({
  selector: 'app-razones-financieras',
  templateUrl: './razones-financieras.component.html',
  styleUrls: ['./razones-financieras.component.css']
})
export class RazonesFinancierasComponent implements OnInit {

  razones = new RazonesModel();

  constructor(public dialogRef: MatDialogRef<any>, @Inject(MAT_DIALOG_DATA) public data: string) {

  }

  ngOnInit(): void {
    const dia = new Date().getDate(); //sacamos los dias actual
    const mes = new Date().getMonth(); // sacamos los meses actual
    const ano = new Date().getFullYear(); // sacamos el año actual
    const hora = new Date().getHours();
    const minuto = new Date().getMinutes();

    let fecha;
    if (minuto < 10) {
      fecha = dia + '-' + mes + 1 + '-' + ano + ' ' + hora + ':' + '0' + minuto;
    } else {
      fecha = dia + '-' + mes + 1 + '-' + ano + ' ' + hora + ':' + minuto;
    }
    console.log(fecha);
  }

  guardar(forma: NgForm) {
    if (forma.invalid) {
      return;
    }

    this.razonesFinancieras();
    window.open("http://localhost:4200/reportes/razones-financieras", "_blank");
  }

  razonesFinancieras() {
    this.obtenerFecha();

    //Liquidez y Solvencia
    let liquidezCorriente = this.razones.ac / this.razones.pc;
    let razonRapida = (this.razones.ac - this.razones.inv) / this.razones.pc;
    let pruebaAcidicima = this.razones.efe / this.razones.pc;
    let capitalTrabajo = this.razones.ac - this.razones.pc;
    let pruebaAcidaDeudores = (this.razones.ac - this.razones.cxc) / this.razones.pc;

    //Analisis de endeudamiento
    let razonDeudaAKAccionistas = (this.razones.pc + this.razones.pnc) / this.razones.k;
    let razonDeudaTAAT = (this.razones.pc + this.razones.pnc) / (this.razones.ac + this.razones.anc);
    let razonCargosdeIntFijos = this.razones.gai / this.razones.imp;
    let razonDeudaALPaKT = this.razones.pnc / (this.razones.pnc + this.razones.k);
    let proporcionACaK = this.razones.anc / this.razones.k;
    
    localStorage.setItem('liquidezCorriente', liquidezCorriente.toString());
    localStorage.setItem('razonRapida', razonRapida.toString());
    localStorage.setItem('pruebaAcidicima', pruebaAcidicima.toString());
    localStorage.setItem('capitalTrabajo', capitalTrabajo.toString());
    localStorage.setItem('pruebaAcidaDeudores', pruebaAcidaDeudores.toString());

    localStorage.setItem('razonDeudaAKAccionistas', razonDeudaAKAccionistas.toString());
    localStorage.setItem('razonDeudaTAAT', razonDeudaTAAT.toString());
    localStorage.setItem('razonCargosdeIntFijos', razonCargosdeIntFijos.toString());
    localStorage.setItem('razonDeudaALPaKT', razonDeudaALPaKT.toString());
    localStorage.setItem('proporcionACaK', proporcionACaK.toString());
  }

  obtenerFecha() {
    //seteando las fechas minimas y maximas
    const dia = new Date().getDate(); //sacamos los dias actual
    const mes = new Date().getMonth(); // sacamos los meses actual
    const ano = new Date().getFullYear(); // sacamos el año actual
    const hora = new Date().getHours();
    const minuto = new Date().getMinutes();

    let fecha;
    if (minuto < 10) {
      fecha = dia + '-' + mes + 1 + '-' + ano + ' ' + hora + ':' + '0' + minuto;
    } else {
      fecha = dia + '-' + mes + 1 + '-' + ano + ' ' + hora + ':' + minuto;
    }
    localStorage.setItem('fecha', fecha);
  }

  onCancelar() {
    this.removerLocalStorage();
    this.dialogRef.close();
  }

  removerLocalStorage() {
    localStorage.removeItem('liquidezCorriente');
    localStorage.removeItem('razonRapida');
    localStorage.removeItem('pruebaAcidicima');
    localStorage.removeItem('capitalTrabajo');
    localStorage.removeItem('pruebaAcidaDeudores');
    localStorage.removeItem('razonDeudaAKAccionistas');
    localStorage.removeItem('razonDeudaTAAT');
    localStorage.removeItem('razonCargosdeIntFijos');
    localStorage.removeItem('razonDeudaALPaKT');
    localStorage.removeItem('proporcionACaK');
    localStorage.removeItem('fecha');
  }

}
