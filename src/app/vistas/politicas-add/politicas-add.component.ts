import { PoliticasService } from './../../services/politicas.service';
import { PoliticaModel } from './../../models/politica.model';
import { Component, OnInit, Inject, EventEmitter } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog'
import { Output } from '@angular/core';
import { FormGroup, NgForm } from '@angular/forms';
declare var $: any;

@Component({
  selector: 'app-politicas-add',
  templateUrl: './politicas-add.component.html',
  styleUrls: ['./politicas-add.component.css']
})
export class PoliticasAddComponent implements OnInit {
  //inicializar el constructor del modal
  politicas = new PoliticaModel();

   //variables de comunicacion con el padre
   @Output() onAgregado = new EventEmitter();

   //variables para validar rangos de fecha
   minDateInicio: Date;
   maxDateInicio: Date;
   minDateFin: Date;
   maxDateFin: Date;
   fecValida = true;
   forma: FormGroup;
   estado = false;
   ocultarBoton = false;

  constructor(public dialogRef: MatDialogRef<PoliticasAddComponent>, @Inject(MAT_DIALOG_DATA) public data: PoliticaModel, 
  public servicePolitica: PoliticasService) {

    // if para mostrar el formulario lleno al 
    // presionar el boton del ojito
    if (this.data != null) {
      this.politicas = data;
      this.estado = true;
      this.ocultarBoton = true;
    }
    
    //seteando las fechas minimas y maximas
    const currentDay = new Date().getDate(); //sacamos los dias actual
    const currentMonth = new Date().getMonth(); // sacamos los meses actual
    const currentYear = new Date().getFullYear(); // sacamos el año actual
    
    this.minDateInicio = new Date(currentYear, currentMonth, currentDay);
    this.maxDateInicio = new Date(currentYear, currentMonth +1, currentDay); 
  }

  ngOnInit(): void {
  }

  guardarPoliticas(forma: NgForm) {
    if (forma.invalid) {
      return;
    }
    console.log(this.politicas);
    this.servicePolitica.agregarPoliticas(this.politicas).subscribe(res => {
      console.log(res);
        if (res.status == 200) {
          this.showNotification('top', 'right', 'Agregado Correctamente!', 'save', 'success');
          this.onAgregado.emit();
        } else {
          this.showNotification('bottom', 'right', 'Ocurrio un problema!', 'cancel', 'danger');
        }
      this.onAgregado.emit();
    })
  }

  fechaSeleccionada(fechaSel: Date) {
    this.minDateFin = new Date(fechaSel.getFullYear(), fechaSel.getMonth() +1, fechaSel.getDate() +1);
    this.maxDateFin = new Date(fechaSel.getFullYear() + 5, fechaSel.getMonth(), fechaSel.getDate());
    this.fecValida = false;
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

  onCancelar() {
    this.dialogRef.close();
  }
}
