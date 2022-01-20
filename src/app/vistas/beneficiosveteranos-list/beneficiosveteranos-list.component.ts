import { Component, Inject, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { BeneficioModel } from 'app/models/beneficio.model';
import { BeneficiosVeteranosModel } from 'app/models/beneficiosveteranos.model';
import { VeteranoModel } from 'app/models/veterano.model';
import { BeneficioService } from 'app/services/beneficio.service';
import { BeneficiosveteranosService } from 'app/services/beneficiosveteranos.service';
declare var $: any;

@Component({
  selector: 'app-beneficiosveteranos-list',
  templateUrl: './beneficiosveteranos-list.component.html',
  styleUrls: ['./beneficiosveteranos-list.component.css']
})
export class BeneficiosveteranosListComponent implements OnInit {

  lista: any[];
  listaBeneficios: any[];
  cargando = false;
  veterano = new VeteranoModel();
  beneficio = new BeneficioModel();
  beneficioVeterano = new BeneficiosVeteranosModel();
  page = 1; //variable que llevara el control de la pagina de la paginacion

  constructor(public serviceBeneficiosVeteranos: BeneficiosveteranosService, public dialogRef: MatDialogRef<BeneficiosveteranosListComponent>, @Inject(MAT_DIALOG_DATA) public data: VeteranoModel,
              public serviceBeneficios: BeneficioService) { 

                // if para mostrar el formulario lleno al 
                // presionar el boton del ojito
                if (this.data != null) {
                  this.veterano = data;
                }
              }

  ngOnInit(): void {
    this.llenarLista();
    this.llenarListaBeneficios();
  }

  llenarLista(){
    this.cargando = true;
    this.serviceBeneficiosVeteranos.listarBeneficiosVinculados(this.veterano.id).subscribe((res: any) => {
      this.lista = res.body;
      this.cargando = false;
    })
  }

  llenarListaBeneficios(){
    this.serviceBeneficios.listarBeneficiosVeteranos(this.veterano.id).subscribe((res: any) => {
      this.listaBeneficios = res.body;
    })
  }

  Eliminar(beneficiosveteranos: any) {
    beneficiosveteranos.activo = false;
    this.serviceBeneficiosVeteranos.actualizar(beneficiosveteranos).subscribe(res => {
      console.log(res);
        if (res.status == 200) {
          this.showNotification('top', 'right', 'Se dio de baja Correctamente!', 'save', 'success');
          this.llenarLista();
          this.llenarListaBeneficios();
        } else {
          this.showNotification('bottom', 'right', 'Ocurrio un problema!', 'cancel', 'danger');
        }
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

  guardar(forma: NgForm) {
    if (forma.invalid) {
      return;
    }

    this.beneficioVeterano.idBeneficio = this.beneficio.id;
    this.beneficioVeterano.idVeterano = this.veterano.id;
    if (this.beneficioVeterano.id == 0) {
      this.serviceBeneficiosVeteranos.insertar(this.beneficioVeterano).subscribe(res => {
          if (res.status == 200) {
            this.showNotification('top', 'right', 'Agregado Correctamente!', 'save', 'success');
            this.llenarLista();
          } else {
            this.showNotification('bottom', 'right', 'Ocurrio un problema!', 'cancel', 'danger');
          }
      })
    } 
  }

  changeSelect(event) {
    this.beneficioVeterano.idBeneficio = event.value;
  }

}
