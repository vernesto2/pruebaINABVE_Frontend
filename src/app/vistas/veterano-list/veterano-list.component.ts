import { Component, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { VeteranoModel } from 'app/models/veterano.model';
import { VeteranoService } from 'app/services/veterano.service';
import { BeneficiosveteranosListComponent } from '../beneficiosveteranos-list/beneficiosveteranos-list.component';
import { VeteranoAddComponent } from '../veterano-add/veterano-add.component';
declare var $: any;

@Component({
  selector: 'app-veterano-list',
  templateUrl: './veterano-list.component.html',
  styleUrls: ['./veterano-list.component.css']
})
export class VeteranoListComponent implements OnInit {

  listaVeteranos: any[];
  cargando = false;
  page = 1; //variable que llevara el control de la pagina de la paginacion

  constructor(public dialog: MatDialog, public serviceVeteranos: VeteranoService) { }

  ngOnInit(): void {
    this.llenarVeteranos();
  }

  llenarVeteranos(){
    this.cargando = true;
    this.serviceVeteranos.listarActivos().subscribe((res: any) => {
      this.listaVeteranos = res.body;
      this.cargando = false;
    })
  }

  openDialog(veterano?: VeteranoModel) {
    const data = {
      onAgrego: this.onAgrego
    }
    const dialogref = this.dialog.open(VeteranoAddComponent, { data: veterano});
    const sub = dialogref.componentInstance.onAgregado.subscribe(() => {
      this.onAgrego();
    });
    dialogref.beforeClosed().subscribe( res => {});
  }

  openDialogBeneficioAsociar(veterano?: VeteranoModel) {
    const data = {
      onAgrego: this.onAgrego
    }
    const dialogref = this.dialog.open(BeneficiosveteranosListComponent, { data: veterano});
    /* const sub = dialogref.componentInstance.onAgregado.subscribe(() => {
      //this.onAgrego();
    }); */
    dialogref.beforeClosed().subscribe( res => {});
  }

  onAgrego(){
    this.llenarVeteranos();
  }

  Eliminar(veterano: VeteranoModel) {
    veterano.activo = false;
    this.serviceVeteranos.actualizar(veterano).subscribe(res => {
      console.log(res);
        if (res.status == 200) {
          this.showNotification('top', 'right', 'Se dio de baja Correctamente!', 'save', 'success');
          this.llenarVeteranos();
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
