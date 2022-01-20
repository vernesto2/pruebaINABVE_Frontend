import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';

@Component({
  selector: 'app-proyecciones',
  templateUrl: './proyecciones.component.html',
  styleUrls: ['./proyecciones.component.css']
})
export class ProyeccionesComponent implements OnInit {
  listaCuotas: any[];
  cargando = false;
  monto = 0;
  montoFijo = 0;
  interesTotal = 0;
  totalNeto = 0;

  constructor(public dialogRef: MatDialogRef<ProyeccionesComponent>, @Inject(MAT_DIALOG_DATA) public data: any) {
    if(data.lista != null){
      this.listaCuotas = data.lista;
      this.monto = data.monto;
      this.montoFijo = data.monto;
    }
    //console.log(data);
   }
  
  ngOnInit(): void {
    if (this.listaCuotas.length > 0) {
      this.calcularResumen();
    }
  }

  calcularResumen() {
    for (let i = 0; i < this.listaCuotas.length; i++) {
      this.interesTotal += this.listaCuotas[i].interes;
      
    }
    this.totalNeto += this.interesTotal + this.montoFijo;
  }

  onCancelar() {
    this.dialogRef.close();
  }
}
