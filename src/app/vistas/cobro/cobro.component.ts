import { Router } from '@angular/router';
import { environment } from './../../../environments/environment';
import { FormGroup } from '@angular/forms';
import { Component, OnInit } from '@angular/core';
import { CreditosService } from 'app/services/creditos.service';
import { PersonaService } from 'app/services/persona.service';
declare var $: any;

@Component({
  selector: 'app-cobro',
  templateUrl: './cobro.component.html',
  styleUrls: ['./cobro.component.css']
})
export class CobroComponent implements OnInit {

  mostrar = false;
  vercampos = true;
  listaCreditoPersonal: any[] = [];
  listaCreditoEmpresa: any[] = [];
  page = 1;
  page1 = 1;
  cargando = false;
  cargando1 = false;
  fechaSimulada = new Date();

  //variables para mostrar la info
  dui: '';
  nombres: '';
  numCuota = 0;
  montoCuota = 0;
  abonoInteres = 0;
  abonoCapital = 0;
  saldoMora = 0;
  dias = 0;
  
  saldoActual: 0;

  efectivo = 0;
  cuotaCancelar = 0;
  interesCancelar = 0;
  capitalCancelar = 0;
  capitalRestante = 0;
  cambio = 0;

  interesMasMora = 0;
  tipoLista = 0;

  fechaCorrespondiente = '';

  fecha: Date;
  botonValido = true;
  simulada = true;

  opcionPagar = 0;
  idCredito = 0;


  constructor(public serviceCP: CreditosService, public personaService: PersonaService,
    private router: Router) {
  }

  ngOnInit(): void {
    this.iniciarFecha();
    this.llenarCreditoPersonal();
  }

  mensaje() {
    console.log(this.mostrar);
  }

  guardarPago(forma: FormGroup) {
    if (forma.invalid) {
      return;
    }

    if (this.opcionPagar == 1) { //cuota exacta
      this.serviceCP.hacerPagoCuota(this.idCredito).subscribe((resp: any) => {
        this.showNotification('top', 'right', resp.mensaje, 'done_all', 'success');
        if (this.tipoLista == 0) {
          this.llenarCreditoPersonal();
        } else {
          this.llenarCreditoEmpresa();
        }
        this.mostrar = false;
      }, err => {
        this.showNotification('bottom', 'right', 'No se completo', 'cancel', 'danger');
      });
    } else if (this.opcionPagar == 2) { //otro monto
      this.serviceCP.hacerPagoMayor(this.idCredito, this.cuotaCancelar).subscribe((resp: any) => {
        this.showNotification('top', 'right', resp.mensaje, 'done_all', 'success');
        if (this.tipoLista == 0) {
          this.llenarCreditoPersonal();
        } else {
          this.llenarCreditoEmpresa();
        }
        this.mostrar = false;
      }, err => {
        this.showNotification('bottom', 'right', 'No se completo', 'cancel', 'danger');
      });
    } else if (this.opcionPagar == 3) { // pagar todo
      this.serviceCP.hacerPagoMayor(this.idCredito, this.cuotaCancelar).subscribe((resp: any) => {
        this.showNotification('top', 'right', resp.mensaje, 'done_all', 'success');
        if (this.tipoLista == 0) {
          this.llenarCreditoPersonal();
        } else {
          this.llenarCreditoEmpresa();
        }
        this.mostrar = false;
      }, err => {
        this.showNotification('bottom', 'right', 'No se completo', 'cancel', 'danger');
      });
    }

  }

  habilitarMontos(value: number) {
    this.opcionPagar = value;
    if (value == 2) {
      this.vercampos = false;
      this.cuotaCancelar = 0;
      this.interesCancelar = this.abonoInteres;
      this.capitalCancelar = 0;
      this.capitalRestante = this.saldoActual;
      this.botonValido = true;
    } else if (value == 1) {
      this.vercampos = true;
      this.cuotaCancelar = this.montoCuota + this.saldoMora;
      this.interesCancelar = this.abonoInteres;
      this.capitalCancelar = this.abonoCapital;
      this.capitalRestante = this.saldoActual - this.capitalCancelar;
      if (this.efectivo > 0) {
        this.botonValido = false;
      } else {
        this.botonValido = true;
      }
    } else if (value == 3) {
      this.vercampos = false;
      this.cuotaCancelar = this.saldoActual + this.interesMasMora;
      this.capitalCancelar = this.saldoActual;
      this.capitalRestante = 0;
      this.interesCancelar = this.abonoInteres;
      this.interesMasMora = this.interesCancelar + this.saldoMora;
    }
  } 

  calcularCambio(value: number) {
    console.log(value);
    this.cuotaCancelar = value;
    if (this.efectivo > 0) {
      this.cambio = this.efectivo - this.cuotaCancelar;
      this.capitalCancelar = this.cuotaCancelar - this.interesMasMora;
      this.capitalRestante = this.saldoActual - this.capitalCancelar;
      if (this.cambio >= 0) {
        this.botonValido = false;
      } else {
        this.botonValido = true;
      }
    } else {
      this.botonValido = true;
      this.cambio = 0;
    }

  }

  cargandoCredito() {
    $.notify({
      icon: 'refresh',
      message: 'Cargando...'

    }, {
      type: 'info',
      placement: {
        from: 'top',
        align: 'right'
      },
      template: '<div data-notify="container" class="col-xl-3 col-lg-3 col-11 col-sm-3 col-md-3 alert alert-{0} alert-with-icon" role="alert">' +
        '<button mat-button  type="button" aria-hidden="true" class="close mat-button" data-notify="dismiss">  <i class="material-icons">close</i></button>' +
        '<i class="material-icons fa-spin" data-notify="icon">refresh</i> ' +
        '<span data-notify="title">{1}</span> ' +
        '<span data-notify="message">{2}</span>'
    });
  }

  efectivoEstablecer(value: number) {
    this.efectivo = value;
    if (this.cuotaCancelar > 0) {
      this.cambio = this.efectivo - this.cuotaCancelar;
      if (this.cambio >= 0) {
        this.botonValido = false;
      } else {
        this.botonValido = true;
      }
    } else {
      this.botonValido = true;
    }
  }

  iniciarFecha() {
    const dias = new Date().getDate(); //sacamos los dias actual
    const mes = new Date().getMonth(); // sacamos los meses actual
    const año = new Date().getFullYear(); // sacamos el año actual
    //const fecha = año + '-' + mes + 1 + '-' + dias + 1;

    this.fecha = new Date(año, mes, dias);
  }

  llenarCreditoPersonal() {
    this.cargando = true;
    this.serviceCP.listaCreditoPersonaEnCurso().subscribe((res: any) => {
      this.listaCreditoPersonal = res.body;
      console.log(res.body);
      this.cargando = false;
    });
  }

  listar(value: any) {
    this.tipoLista = value.index;
    if (value.index == 0) {
      this.listaCreditoPersonal.length = 0;
      this.llenarCreditoPersonal();

    } else if (value.index == 1) {
      this.listaCreditoEmpresa.length = 0;
      this.llenarCreditoEmpresa();
    }
  }

  llenarCreditoEmpresa() {
    this.cargando1 = true;
    this.serviceCP.listaCreditoEmpresaEnCurso().subscribe((res: any) => {
      this.listaCreditoEmpresa = res.body;
      //console.log(res.body);
      this.cargando1 = false;
    });
  }

  seleccionarCredito(value: any) {
    this.mostrar = true;
    this.cargandoCredito();
    //console.log(value);
    this.idCredito = value.id;
    this.serviceCP.traerPago(value.id).subscribe((res: any) => {
      console.log(res);
      if (res.status == 200) {
        if (this.tipoLista == 0) {
          this.dui = value.dui;
          this.nombres = value.nombres + value.apellidos;
        } else {
          this.dui = value.nit;
          this.nombres = value.nombre;
        }
        this.numCuota = res.body.cuota.id.numero;
        this.abonoInteres = res.body.cuota.interes;
        this.abonoCapital = res.body.cuota.capitalAmortizado;
        this.montoCuota = this.abonoCapital + this.abonoInteres;
        this.saldoMora = res.body.cuota.mora;
        this.dias = res.body.cuota.diasAntesDespues;
        this.fechaCorrespondiente = res.body.cuota.fechaCorrespondiente;
        this.saldoActual = res.body.capitalVivo;
        this.capitalRestante = this.saldoActual;
        this.interesMasMora = this.abonoInteres + this.saldoMora;
        this.showNotification('top', 'right', 'Datos recuperados', 'done_all', 'success');
      }
    }, err => {
      this.showNotification('bottom', 'right', 'Ocurrio un problema', 'cancel', 'danger');
    });

  }

  buscarDUICliente(value: any) {
    this.personaService.buscarPor(value).subscribe((lista: any) => {
      this.listaCreditoPersonal = lista.body;
      //console.log(this.listaCliente);
    }, err => {
    });
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

  abrirTicket() {
    localStorage.setItem('numCuota', this.numCuota.toString());
    localStorage.setItem('capitalCancelado', this.capitalCancelar.toString());
    localStorage.setItem('interesCancelado', this.interesCancelar.toString());
    localStorage.setItem('cuotaCancelada', this.cuotaCancelar.toString());
    localStorage.setItem('saldoMora', this.saldoMora.toString());
    localStorage.setItem('capitalRestante', this.capitalRestante.toString());
    localStorage.setItem('fechaCorrespondiente', this.fechaCorrespondiente.toString());
    localStorage.setItem('montoEntregado', this.efectivo.toString());
    localStorage.setItem('cambio', this.cambio.toString());
    //this.router.navigateByUrl('inicio');
    window.open("http://localhost:4200/reportes/ticket", "_blank");
  }


  buscarNitoNombre(value?: string) {
    this.serviceCP.buscarNitNombreEmpresa(value).subscribe((lista: any) => {
      console.log(lista);
      this.listaCreditoEmpresa = lista.body;
    }, err => {
      this.showNotification('bottom', 'right', err.error.mensaje, 'cancel', 'danger');
    });
  }
}
