import { Component, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { CreditoPersonalModel } from 'app/models/creditoPersonal.model';
import { EmpresaModel } from 'app/models/empresa.model';
import { CreditosService } from 'app/services/creditos.service';
import { PersonaService } from 'app/services/persona.service';
import { EmpresaAddComponent } from '../empresa-add/empresa-add.component';
import { RefinanciarComponent } from '../refinanciar/refinanciar.component';
declare var $: any;
@Component({
  selector: 'app-empresa-list',
  templateUrl: './empresa-list.component.html',
  styleUrls: ['./empresa-list.component.css']
})
export class EmpresaListComponent implements OnInit {

  listaEmpresa: any[] = [];
  cargando1 = false;
  page1 = 1;
  page = 1;
  page2 = 1;
  cargando2 = false;
  cargando = false;
  fechaSimulada: Date;
  listaCreditoEmpresaCurso: any[] = [];
  listaCreditoEmpresaMora: any[] = [];

  constructor(public dialog: MatDialog, public personaService: PersonaService, private serviceCP: CreditosService) { }

  ngOnInit(): void {
    this.llenarEmpresa();
  }

  onAgrego1() {
    this.llenarEmpresa();
  }
 
  LE(value: any) {
    if (value.index == 0) {
      this.listaCreditoEmpresaCurso.length = 0;
      this.listaCreditoEmpresaMora.length = 0;
      this.llenarEmpresa();
    } else if (value.index == 1) {
      this.listaEmpresa.length = 0;
      this.listaCreditoEmpresaMora.length = 0;
      this.llenarCreditosCurso();
    } else if (value.index == 2) {
      this.listaEmpresa.length = 0;
      this.listaCreditoEmpresaCurso.length = 0;
      this.llenarCreditosMora();
    }
  }

  llenarCreditosCurso() {
    this.cargando = true;
    this.serviceCP.listaCreditoEmpresaEnCurso().subscribe((lista: any) => {
      this.listaCreditoEmpresaCurso = lista.body;
      console.log(this.listaCreditoEmpresaCurso);
      this.cargando = false;
    });
  }

  llenarCreditosMora() {
    this.cargando2 = true;
    this.serviceCP.empresaEnMora().subscribe((lista: any) => {
      this.listaCreditoEmpresaMora = lista.body.objeto;
      console.log(this.listaCreditoEmpresaMora);
      this.cargando2 = false;
    });
  }

  onAgregoRefinanciar() {
    // this.llenarRefinanciar();
   }

  openDialogRefinanciar(financiar?: CreditoPersonalModel) {
    let dialogref = this.dialog.open(RefinanciarComponent, { data: financiar});
    const sub = dialogref.componentInstance.onAgregoRefinanciar.subscribe(() => {
      this.onAgregoRefinanciar();
    });
    dialogref.afterClosed().subscribe( res => {});
  }

  llenarEmpresa() {
    this.cargando1 = true;
    this.personaService.listarEmpresa().subscribe((lista: any) => {
      this.listaEmpresa = lista.body;
      console.log(lista.body);
      this.cargando1 = false;
    });
  }

  openDialogEmpresa(empresa?: EmpresaModel) {
    const data = {
      onAgrego1: this.onAgrego1
    }
    let dialogref = this.dialog.open(EmpresaAddComponent, { data: empresa });
    const sub = dialogref.componentInstance.onAgregado1.subscribe(() => {
      this.onAgrego1();
    });
    dialogref.afterClosed().subscribe( res => {});
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
