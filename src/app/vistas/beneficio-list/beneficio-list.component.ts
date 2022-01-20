import { Component, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { BeneficioModel } from 'app/models/beneficio.model';
import { BeneficioService } from 'app/services/beneficio.service';
import { BeneficioAddComponent } from '../beneficio-add/beneficio-add.component';
declare var $: any;

@Component({
  selector: 'app-beneficio-list',
  templateUrl: './beneficio-list.component.html',
  styleUrls: ['./beneficio-list.component.css']
})
export class BeneficioListComponent implements OnInit {

  lista: any[];
  cargando = false;
  page = 1; //variable que llevara el control de la pagina de la paginacion

  constructor(public dialog: MatDialog, public serviceBeneficio: BeneficioService) { }

  ngOnInit(): void {
    this.llenarLista();
  }

  llenarLista(){
    this.cargando = true;
    this.serviceBeneficio.listarActivos().subscribe((res: any) => {
      this.lista = res.body;
      this.cargando = false;
    })
  }

  openDialog(beneficio?: BeneficioModel) {
    const data = {
      onAgrego: this.onAgrego
    }
    const dialogref = this.dialog.open(BeneficioAddComponent, { data: beneficio});
    const sub = dialogref.componentInstance.onAgregado.subscribe(() => {
      this.onAgrego();
    });
    dialogref.beforeClosed().subscribe( res => {});
  }

  onAgrego(){
    this.llenarLista();
  }

  Eliminar(beneficio: BeneficioModel) {
    beneficio.activo = false;
    this.serviceBeneficio.actualizar(beneficio).subscribe(res => {
      console.log(res);
        if (res.status == 200) {
          this.showNotification('top', 'right', 'Se dio de baja Correctamente!', 'save', 'success');
          this.llenarLista();
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

}
