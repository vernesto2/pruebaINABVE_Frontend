import { Component, EventEmitter, Inject, OnInit, Output } from '@angular/core';
import { FormGroup, NgForm } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { VeteranoModel } from 'app/models/veterano.model';
import { VeteranoService } from 'app/services/veterano.service';
declare var $: any;

@Component({
  selector: 'app-veterano-add',
  templateUrl: './veterano-add.component.html',
  styleUrls: ['./veterano-add.component.css']
})
export class VeteranoAddComponent implements OnInit {

  veterano = new VeteranoModel();
  //variables de comunicacion con el padre
  @Output() onAgregado = new EventEmitter();

  forma: FormGroup;

  constructor(public dialogRef: MatDialogRef<VeteranoAddComponent>, @Inject(MAT_DIALOG_DATA) public data: VeteranoModel, 
  public serviceVeterano: VeteranoService) { 

    // if para mostrar el formulario lleno al 
    // presionar el boton del ojito
    if (this.data != null) {
      this.veterano = data;
    }

  }

  ngOnInit(): void {
  }

  guardar(forma: NgForm) {
    if (forma.invalid) {
      return;
    }
    console.log(this.veterano);
    if (this.veterano.id == 0) {
      this.serviceVeterano.insertar(this.veterano).subscribe(res => {
        console.log(res);
          if (res.status == 200) {
            this.showNotification('top', 'right', 'Agregado Correctamente!', 'save', 'success');
            this.onAgregado.emit();
          } else {
            this.showNotification('bottom', 'right', 'Ocurrio un problema!', 'cancel', 'danger');
          }
        this.onAgregado.emit();
      })
    } else {
      this.serviceVeterano.actualizar(this.veterano).subscribe(res => {
        console.log(res);
          if (res.status == 200) {
            this.showNotification('top', 'right', 'Actualizado Correctamente!', 'save', 'success');
            this.onAgregado.emit();
          } else {
            this.showNotification('bottom', 'right', 'Ocurrio un problema!', 'cancel', 'danger');
          }
        this.onAgregado.emit();
      })
    }
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
