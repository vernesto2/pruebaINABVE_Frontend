import { Router } from '@angular/router';
import { Component, OnInit, Inject, EventEmitter, Output } from '@angular/core';
import { FormBuilder, FormGroup, NgForm } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ActivoFijoModel } from 'app/models/activoFijo.model';
import { ActivoFijoService } from 'app/services/activo-fijo.service';
import { AdquisicionActivoModel } from 'app/models/adquisicionActivo.model';
import { UnidadModel } from 'app/models/unidad.model';
import { StepperSelectionEvent } from '@angular/cdk/stepper';
import { DepartamentoModel } from 'app/models/departamento.mode';
declare var $: any; //variable que se usara para las notificaciones

@Component({
  selector: 'app-activo-fijo-add',
  templateUrl: './activo-fijo-add.component.html',
  styleUrls: ['./activo-fijo-add.component.css']
})
export class ActivoFijoAddComponent implements OnInit {
  @Output() onAgregado = new EventEmitter();
  maxDate: Date;
  minDate: Date;
  valido = true;
  meses: number;
  vidautil: number;
  cargando = false;
  activofijo=new ActivoFijoModel();
  adquisicionActivo= new AdquisicionActivoModel();
  nombreactivo:string;
  page=1;
  mostrar = false;
  //combox
  listaDepartamento: any[];
  listaActivo: any[];
  listaUnidad: any[];
  listaTipoActivo: any[];
  listaEncargado: any[];
  constructor(public activoServicio:ActivoFijoService,public dialogRef: MatDialogRef<ActivoFijoAddComponent>,
     @Inject(MAT_DIALOG_DATA) public data: string,private router: Router) {
      this.maxDate = new Date();
      this.nombreactivo=this.activofijo.nombre;
  }

  ngOnInit(): void {
    this.llenar();
    this.llenarTabla();
  }

  unidadSeleccionada(uni: UnidadModel){
    this.activoServicio.listarDepartamentoPorUnidad(uni.codigo).subscribe((listaUSel:any)=>{
      this.listaDepartamento=listaUSel.body;
      console.log("Departamento "+JSON.stringify(uni));
    });
  }

  departamentoSeleccionada(dep: DepartamentoModel){
    console.log("Departamento "+JSON.stringify(dep));
  }

  llenar(){
    this.activoServicio.listarUnidad().subscribe((listaU:any)=>{
      this.listaUnidad=listaU.body;
      console.log(listaU.body);
    });
    this.activoServicio.listarTipoActivo().subscribe((listaT:any)=>{
      this.listaTipoActivo=listaT.body;
      console.log(listaT.body);
    });
    this.activoServicio.listarEncargado("ENCARGADO_ACTIVO_FIJO").subscribe((listaE:any)=>{
      this.listaEncargado=listaE.body;
      console.log(listaE.body);
    });
  }

  llenarTabla(){
    this.cargando = true;
    this.activoServicio.listarActivo().subscribe((listaA:any)=>{
      this.listaActivo=listaA.body;
      this.cargando = false;
      console.log(listaA.body);
    });
  }

  guardarActivo(forma: NgForm){
    this.mostrar = true;
    if(forma.invalid){
      return;
    }
    console.log("contenido de guardar "+JSON.stringify(this.activofijo));
    this.activoServicio.agregarActivo(this.activofijo).subscribe(res => {
      console.log(res);
        if (res.status == 200) {
          this.showNotification('top', 'right', 'Agregado Correctamente!', 'save', 'success');
          this.llenarTabla();
        } else {
          this.showNotification('bottom', 'right', 'Ocurrio un problema!', 'cancel', 'danger');
        }
      this.onAgregado.emit();
    })
  }

  guardarAdquisicion(forma: NgForm){
    if(forma.invalid){
      return;
    }
    this.adquisicionActivo.activoFijo=this.activofijo;
    this.adquisicionActivo.vidaUtil=this.meses;
    console.log("contenido de guardar "+JSON.stringify(this.adquisicionActivo));
    this.activoServicio.agregarAdquisicionActivo(this.adquisicionActivo).subscribe(res => {
      console.log(res);
        if (res.status == 200) {
          this.showNotification('top', 'right', 'Agregado Correctamente!', 'save', 'success');
          this.llenarTabla();
        } else {
          this.showNotification('bottom', 'right', 'Ocurrio un problema!', 'cancel', 'danger');
        }
    })
  }

  activoSelecionado(a:ActivoFijoModel){
    this.mostrar = true;
    this.activofijo.nombre=a.nombre;
    this.activofijo=a;
    console.log(JSON.stringify(a));
  }

  showNotification(from, align, message, icon, type) {
    $.notify({
        icon: icon,
        message: message
    }, {
        type: type,
        timer: 4000,
        placement: {
            from: from,
            align: align
        },
        template: '<div data-notify="container" class="col-xl-3 col-lg-3 col-11 col-sm-3 col-md-3 alert alert-{0} alert-with-icon" role="alert">' +
          '<button mat-button  type="button" aria-hidden="true" class="close mat-button" data-notify="dismiss">  <i class="material-icons">close</i></button>' +
          '<i class="material-icons" data-notify="icon">' + icon + '</i> ' +
          '<span data-notify="title">{1}</span> ' +
          '<span data-notify="message">{2}</span>' +
          '<div class="progress" data-notify="progressbar">' +
            '<div class="progress-bar progress-bar-{0}" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"></div>' +
          '</div>' +
          '<a href="{3}" target="{4}" data-notify="url"></a>' +
        '</div>'
    });
  }
  obtenerMeses(){
    this.meses=this.vidautil*12;
    console.log(this.meses);
  }
  pasarMeses(){
    this.meses=this.vidautil;
    console.log(this.meses);
  }
  selectionChange(e){
    if(e.selectedIndex==0){
      this.mostrar=false;
    }
    if(e.selectedIndex==1){
      this.mostrar=false;
    }
  }

}
