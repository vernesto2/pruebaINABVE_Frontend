import { Component, Inject, OnInit } from '@angular/core';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';
import { AgrupacionModel } from 'app/models/agrupacion.model';
import { ValorActualModel } from 'app/models/valorActual.model';
import { ActivoFijoService } from 'app/services/activo-fijo.service';

@Component({
  selector: 'app-agrupacion-activo',
  templateUrl: './agrupacion-activo.component.html',
  styles: [
  ]
})
export class AgrupacionActivoComponent implements OnInit {

  listaTipoActivo: AgrupacionModel;
  listaActivo:any[]=[];
  listaActivos:any[]=[];
  listaActivoActules:any[]=[];
  nombre:string;
  cantidadTipo:number;
  idTipo:number;
  fecha:Date;
  constructor(public activoServicio:ActivoFijoService,@Inject(MAT_DIALOG_DATA) public data: AgrupacionModel) { 
    this.listaTipoActivo=data;
    this.nombre=this.listaTipoActivo.tipoActivo;
    this.cantidadTipo=this.listaTipoActivo.cantidad;
    this.idTipo=this.listaTipoActivo.codigoTipoActivo;
    this.fecha=new Date();
  }

  ngOnInit(): void {
    this.activoServicio.listaragrupadaActivo(this.idTipo).subscribe((listaA: any) => {
      this.listaActivo=listaA.body;
      for(let i=0;i<this.listaActivo.length;i++){
        this.activoServicio.listarActivos(this.idTipo,this.listaActivo[i].idactivo).subscribe((listar:any)=>{
          this.listaActivos[i]=listar.body;

        });
      }
    })

  }

}
