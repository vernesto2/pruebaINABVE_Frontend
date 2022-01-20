import { createHostListener } from '@angular/compiler/src/core';
import { Component, Inject, OnInit, EventEmitter } from '@angular/core';
import { Output } from '@angular/core';
import { FormGroup, NgForm } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { BajaActivoModel } from 'app/models/bajaActivo.model';
import { detalleAModel } from 'app/models/detalleAct.model';
import { DetalleActivoModel } from 'app/models/detalleActivo.model';
import { ActivoFijoService } from 'app/services/activo-fijo.service';
declare var $: any; //variable que se usara para las notificaciones

@Component({
  selector: 'app-detalle-baja-activo',
  templateUrl: './detalle-baja-activo.component.html',
  styleUrls: ['./detalle-baja-activo.component.css']
})
export class DetalleBajaActivoComponent implements OnInit {
  @Output() onAgregado = new EventEmitter();

  forma:FormGroup;
  page=1;
  listadarbaja: any;
  fecha:Date;
  n=0;
  activobaja=new BajaActivoModel();
  baja:Array<DetalleActivoModel>=[];
  //activobaja= new detalleAModel();

  constructor(public activoServicio:ActivoFijoService, public dialogRef: MatDialogRef<DetalleBajaActivoComponent>, @Inject(MAT_DIALOG_DATA) public data: DetalleActivoModel) { 
    if(data != null){
      this.listadarbaja=data;
      console.log(JSON.stringify(data));
    }
    this.fecha=new Date();
  }

  ngOnInit(): void {
  }

  onCancelar() {
    this.dialogRef.close();
  }
/*[{"codigoGenerado":"2322-0001-0001-0005-0001","nombre":"Silla Plastica","idAdquisicion":5,"correlativo":1,
"detalleActivos":{"id":{"idAdquisicion":5,"correlativo":1},"precio":0}},
{"codigoGenerado":"2322-0001-0001-0005-0002","nombre":"Silla Plastica","idAdquisicion":5,"correlativo":2,
"detalleActivos":{"id":{"idAdquisicion":5,"correlativo":2},"precio":0}}] */
  setPrecio(det:DetalleActivoModel,i:number,precio:number){
    //det.id=this.listadarbaja[i].de
    this.listadarbaja[i].precio=precio;
    //this.listadarbaja[i].detalleActivos.precio=precio;
  }
  darBaja(forma:NgForm){
   if(forma.invalid){
    return;
  }
  console.log(this.listadarbaja);
  this.activobaja.fecha=this.fecha;
  this.activobaja.detalleActivos=this.listadarbaja;
  console.log(JSON.stringify(this.activobaja)); 
  this.activoServicio.bajaActivo(this.activobaja).subscribe(res => {
    console.log(res);
    this.listadarbaja=null;
    console.log(this.listadarbaja);
      if (res.status == 200) {
        this.showNotification('top', 'right', 'Agregado Correctamente!', 'save', 'success');
        this.onAgregado.emit();
      } else {
        this.showNotification('bottom', 'right', 'Ocurrio un problema!', 'cancel', 'danger');
      }
    this.onAgregado.emit();
  })
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
}
