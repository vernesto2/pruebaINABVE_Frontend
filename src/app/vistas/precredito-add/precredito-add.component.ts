import { PersonaService } from 'app/services/persona.service';
import { PersonaNaturalModel } from './../../models/personaNatural.model';
import { ProyeccionesComponent } from './../proyecciones/proyecciones.component';
import { BienGarantiaModel } from './../../models/bienGarantia.model';
import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, NgForm, Validators } from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';
import { CreditoModel } from 'app/models/credito.model';
import { CreditoPersonalModel } from 'app/models/creditoPersonal.model';
import { GarantiaFiadorModel } from 'app/models/garantiaFiador.model';
import { IngresoEgresoModel } from 'app/models/ingresoEgreso.model';
import { CreditosService } from 'app/services/creditos.service';
import { Observable } from 'rxjs';
import { PersonaAddComponent } from '../persona-add/persona-add.component';
import { UsuarioModel } from 'app/models/usuario.model';

declare var $: any;

@Component({
  selector: 'app-precredito-add',
  templateUrl: './precredito-add.component.html',
  styleUrls: ['./precredito-add.component.css']
})
export class PrecreditoAddComponent implements OnInit {

  creditoPersonal = new CreditoPersonalModel();
  credito = new CreditoModel();
  garantiaFiador = new GarantiaFiadorModel();
  tipoCredito = '';

  usuario = new UsuarioModel();

  forma: FormGroup;
  hipotecario = true;
  fiador = true;

  listaCuotas: any = [];
  activarProyeccion = true;
  cuota = '';
  interes = '';
  capital = '';
  tipoTiempo = '';
  disTiempo = true;
  meses = 0;

  //Para seleccionar Cliente y Fiador
  listaCliente: any[] = [];
  clienteSel = new PersonaNaturalModel();
  listaFiador: any[] = [];
  fiadorSel = new PersonaNaturalModel();
  duiCliente = 'DUI';
  nombreCliente = 'Nombres';
  duiFiador = 'DUI';
  nombreFiador = 'Nombres';
  fecha: Date;
  //variables de validacion
  montoInferior = 0;
  montoSuperior = 0;
  tiempoInferior = 0;
  tiempoSuperior = 0;
  rangos: any;

  //validacion para guardar
  validarBoton = true;
  clienteValido = true;

  //ingresosEgresos
  ingresosEgresosCliente = new IngresoEgresoModel();
  ingresoEgresoFiador = new IngresoEgresoModel();

  //hipotecario
  valorFinanciado = 0;
  bienHipotecado = new BienGarantiaModel();
  listaBien: any[] = [];
  codigoBienSel = 'Código';
  tipoBienSel = 'Tipo de bien';

  constructor(public dialog: MatDialog, private fb: FormBuilder, public servicesCP: CreditosService,
    private personaService: PersonaService) { }

  ngOnInit(): void {

    this.iniciarFecha();
    this.usuario.nit = '10060309961011';
    this.validarRangos();
  }

  iniciarFecha() {
    const dias = new Date().getDate(); //sacamos los dias actual
    const mes = new Date().getMonth(); // sacamos los meses actual
    const año = new Date().getFullYear(); // sacamos el año actual
    //const fecha = año + '-' + mes + 1 + '-' + dias + 1;

    this.fecha = new Date(año, mes, dias);
    this.credito.fechaAprobacion = new Date(this.fecha.toString());
  }

  cambioFiador() {
    if (this.hipotecario = true) {
      this.fiador = false;
    }
  }

  cambioHipotecario() {
    if (this.fiador = true) {
      this.hipotecario = false;
    }
  }

  separarModeloConsumo() {
    this.creditoPersonal.personaNatural = this.clienteSel;
    this.garantiaFiador.personaNatual = this.fiadorSel;
    this.ingresoEgresoFiador.nota = '';
    this.garantiaFiador.ingresoEgreso = this.ingresoEgresoFiador;
    this.creditoPersonal.garantiaFiadors.push(this.garantiaFiador);
    this.credito.fechaSolicitud = this.credito.fechaAprobacion;
    this.credito.usuario = this.usuario;
    this.credito.creditoPersona = this.creditoPersonal;
    console.log(JSON.stringify(this.credito));
  }

  separarModeloHipoteca() {
    this.creditoPersonal.personaNatural = this.clienteSel;
    this.credito.bienGarantias.push(this.bienHipotecado);
    this.credito.fechaSolicitud = this.credito.fechaAprobacion;
    this.credito.usuario = this.usuario;
    this.credito.creditoPersona = this.creditoPersonal;

    console.log(JSON.stringify(this.credito));
  }

  resetearForm() {
    this.creditoPersonal = new CreditoPersonalModel();
    this.credito = new CreditoModel();
    this.ingresoEgresoFiador = new IngresoEgresoModel();
    this.ingresosEgresosCliente = new IngresoEgresoModel();
    this.garantiaFiador = new GarantiaFiadorModel();
    this.clienteSel = new PersonaNaturalModel();
    this.fiadorSel = new PersonaNaturalModel();
    this.bienHipotecado = new BienGarantiaModel();
    this.duiCliente = 'DUI';
    this.duiFiador = 'DUI';
    this.nombreCliente = 'Nombres';
    this.nombreFiador = 'Nombres';
    this.montoInferior = 0;
    this.montoSuperior = 0;
    this.tiempoInferior = 0;
    this.tiempoSuperior = 0;
    this.activarProyeccion = true;
    this.cuota = '';
    this.interes = '';
    this.capital = '';
    this.tipoTiempo = '';
    this.disTiempo = true;
    this.meses = 0;
    this.valorFinanciado = 0;
    this.validarBoton = true;
    this.codigoBienSel = 'Código';
    this.tipoBienSel = 'Tipo de bien';
  }

  guardarCP(forma: NgForm) {

    if (this.tipoCredito == 'CONSUMO') {
      this.separarModeloConsumo();
    } else {
      this.separarModeloHipoteca();
    }
    this.cargandoPrecredito();
    this.servicesCP.agregarCreditoPersona(this.credito, this.tipoCredito, this.tipoTiempo).subscribe(res => {
      if (res.status == 200) {
        //console.log(res);
        this.showNotification('top', 'right', 'Agregado Correctamente!', 'save', 'success');
        this.resetearForm();
        this.iniciarFecha();
      }
    }, err => {
      this.resetearForm();
      this.iniciarFecha();
      this.showNotification('bottom', 'right', err.error.mensaje, 'cancel', 'danger');
    });
  }

  seleccionoCliente(cliente: PersonaNaturalModel) {
    this.showNotification('top', 'right', 'Cliente seleccionado', 'check', 'info');
    this.clienteSel = cliente;
    this.duiCliente = cliente.dui;
    this.nombreCliente = cliente.nombres + ' ' + cliente.apellidos;
    this.servicesCP.consultarSiPersonaPoseeCredito(cliente.dui).subscribe((res: any) => {
      //console.log(res);
      if (res.status == 200) {
        this.clienteValido = false;
        this.showNotification('top', 'right', res.body.mensaje, 'done_all', 'success');
      }
    }, err => {
      this.clienteValido = true;
      console.log(err);
      this.showNotification('bottom', 'right', err.error.mensaje, 'cancel', 'danger');
    });
  }

  vefirifcarIngresos(value: number){
    if(value>(this.ingresosEgresosCliente.ingresosTotales+this.ingresosEgresosCliente.otrosIngresos)){
      this.showNotification('bottom', 'right', 'Los egresos deben ser menor que los ingresos', 'cancel', 'danger');
    }
  } 

  vefirifcarIngresosFiador(value: number){
    if(value>(this.ingresoEgresoFiador.ingresosTotales+this.ingresoEgresoFiador.otrosIngresos)){
      this.showNotification('bottom', 'right', 'Los egresos deben ser menor que los ingresos', 'cancel', 'danger');
    }
  }
  buscarDUICliente(value: any) {
      this.personaService.buscarPor(value).subscribe((lista: any) => {
        this.listaCliente = lista.body;
        //console.log(this.listaCliente);
      }, err => {
        this.showNotification('bottom', 'right', 'Cliente no encontrado!', 'cancel', 'danger');
      });
  }

  seleccionoFiador(fiador: PersonaNaturalModel) {
    this.showNotification('top', 'right', 'Fiador seleccionado', 'check', 'info');
    this.fiadorSel = fiador;
    this.duiFiador = fiador.dui;
    this.nombreFiador = fiador.nombres + ' ' + fiador.apellidos;
  }

  buscarDUIFiador(value: any) {
      this.personaService.buscarPor(value).subscribe((lista: any) => {
        this.listaFiador = lista.body;
        //console.log(this.listaFiador);
      }, err => {
        this.showNotification('bottom', 'right', 'Fiador no encontrado!', 'cancel', 'danger');
      });
  }

  buscarCodigoBien(value: string) {
    this.listaBien = [];
      this.servicesCP.obtenerBienPorCodigo(value).subscribe((resp: any) => {
        if (resp.status == 200) {
          this.listaBien.push(resp.body.objeto);
          this.showNotification('top', 'right', 'Bien encontrado', 'search', 'success');
        }
      }, err => {
        if (err.error.objeto == null) {
          this.showNotification('bottom', 'right', 'Bien no encontrado', 'cancel', 'danger');
        }
      });
  }

  seleccionarBien(bien: BienGarantiaModel) {
    this.bienHipotecado = bien;
    this.codigoBienSel = bien.codigo;
    this.tipoBienSel = bien.tipoBien;
    this.bienHipotecado = bien;
    this.valorFinanciado = this.bienHipotecado.valoradoEn * 0.90;
    this.listaBien = null;
    this.servicesCP.consultarSiBiengarantiaPoseeCredito(bien.codigo).subscribe((res: any) => {
      //console.log(res);
      if (res.status == 200) {
        this.clienteValido = false;
        this.showNotification('top', 'right', res.body.mensaje, 'done_all', 'success');
      }
    }, err => {
      this.clienteValido = true;
      //console.log(err);
      this.showNotification('bottom', 'right', err.error.mensaje, 'cancel', 'danger');
    });
  }

  comprobarIngresos() {
    if (this.ingresosEgresosCliente != null && this.ingresoEgresoFiador != null) {
      this.servicesCP.comprobarIngresos(this.ingresosEgresosCliente, this.ingresoEgresoFiador).subscribe((res: any) => {
        //console.log(res);
        this.validarBoton = false;
        if (res.status == 200) {
          this.showNotification('top', 'right', res.body.mensaje, 'done_all', 'success');
        }
      }, err => {
        this.validarBoton = true;
        this.showNotification('bottom', 'right', err.error.mensaje, 'cancel', 'danger');
      });
    }
  }

  montoFinanciado(valor: number) {
    if (valor != null) {
      this.valorFinanciado = (Number(valor) * 0.90);

      if (this.credito.monto != null) {
        if (this.credito.monto >= this.valorFinanciado) {
          this.validarBoton = true;
          this.showNotification('bottom', 'right', 'El monto solicitado no puede ser financiado', 'cancel', 'danger');
        } else {
          this.validarBoton = false;
          this.showNotification('top', 'right', 'El monto solicitado si puede ser financiado', 'done_all', 'success');
        }
      }
    }
  }

  llamarContrato() {
    if (this.clienteSel != null && this.fiadorSel != null) {

      window.open("http://localhost:4200/reportes/contrato-credito", "_blank");
    } else {

    }
  }

  openDialogProyecciones() {
    let info = {
      lista: this.listaCuotas,
      monto: this.credito.monto
    }
    const dialogref = this.dialog.open(ProyeccionesComponent, { data: info });
    dialogref.beforeClosed().subscribe(res => { });
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

  cargandoPrecredito() {
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

  seleccionarTipo(tipo: string) {
    this.tipoCredito = tipo;
    if (this.credito.monto != null && this.credito.tiempo != null) {
      ////////////////////////
      let meses;
      if (this.tipoTiempo == 'año') {
        meses = this.meses * 12;
      } else {
        meses = this.credito.tiempo;
      }
      //console.log(meses);
      this.servicesCP.calcularPrecredito(this.credito.monto, meses, this.tipoCredito, this.credito.fechaAprobacion).subscribe((obj: any) => {
        //console.log(obj);
        if (obj.status == 200) {
          this.listaCuotas = obj.body.cuotas;
          //console.log(obj);
          this.cuota = this.listaCuotas[0].interes + this.listaCuotas[0].capitalAmortizado;
          this.interes = obj.body.politica.tasaInteres;
          this.activarProyeccion = false;
          this.showNotification('top', 'right', 'Política seleccionada', 'check', 'success');
        }
      }, err => {
        this.activarProyeccion = true;
        this.showNotification('bottom', 'right', 'Política no encontrada', 'cancel', 'danger');
      });
    }

    if (tipo == 'HIPOTECARIO') {
      this.cambioHipotecario();
    } else if (tipo == 'CONSUMO') {
      this.cambioFiador();
    }
  }

  calcularTiempo(value: number) {
    if (this.tipoCredito != '' && this.credito.monto != null) {
      if (value >= this.tiempoInferior && value <= this.tiempoSuperior) {

        this.meses = value;
        let meses;
        if (this.tipoTiempo == 'año') {
          meses = this.meses * 12;
        } else {
          meses = this.credito.tiempo;
        }
        //console.log(meses);
        this.servicesCP.calcularPrecredito(this.credito.monto, meses, this.tipoCredito, this.credito.fechaAprobacion).subscribe((obj: any) => {
          //console.log(obj);
          if (obj.status == 200) {
            this.listaCuotas = obj.body.cuotas;
            this.cuota = this.listaCuotas[0].interes + this.listaCuotas[0].capitalAmortizado;
            this.interes = obj.body.politica.tasaInteres;
            this.activarProyeccion = false;
            this.showNotification('top', 'right', 'Política seleccionada', 'check', 'success');
          }
        }, err => {
          this.activarProyeccion = true;
          this.showNotification('bottom', 'right', err.error.mensaje, 'cancel', 'danger');
        });
      }
    }
  }

  calcularMonto(value: number) {
    if (this.tipoCredito != '' && this.credito.tiempo != null) {
      if (value >= this.montoInferior && value <= this.montoSuperior) {
        let meses;
        if (this.tipoTiempo == 'año') {
          meses = this.meses * 12;
        } else {
          meses = this.credito.tiempo;
        }
        //console.log(meses);
        this.servicesCP.calcularPrecredito(this.credito.monto, meses, this.tipoCredito, this.credito.fechaAprobacion).subscribe((obj: any) => {
          //console.log(obj);
          if (obj.status == 200) {
            this.listaCuotas = obj.body.cuotas;
            this.cuota = this.listaCuotas[0].interes + this.listaCuotas[0].capitalAmortizado;
            this.interes = obj.body.politica.tasaInteres;
            this.activarProyeccion = false;
            this.showNotification('top', 'right', 'Política seleccionada', 'check', 'success');
          }
        }, err => {
          this.activarProyeccion = true;
          this.showNotification('bottom', 'right', 'Política no encontrada', 'cancel', 'danger');
        });
      }
    }
  }

  openDialogPersona(persona?: PersonaNaturalModel) {
    let dialogref = this.dialog.open(PersonaAddComponent, { data: persona });

    dialogref.afterClosed().subscribe(res => { });
  }

  seleccionarTiempo(value: string) {
    this.disTiempo = false;
    this.tipoTiempo = value;
    if (value == 'año') {
      this.tiempoInferior = 1;
      this.tiempoSuperior = (this.rangos.tiempoSuperior / 12);
      this.credito.tiempo = this.credito.tiempo / 12;
    } else if (value == 'mes') {
      this.tiempoInferior = this.rangos.tiempoInferior;
      this.tiempoSuperior = this.rangos.tiempoSuperior;
      this.credito.tiempo = this.credito.tiempo * 12;
    }

  }

  validarRangos() {
    this.servicesCP.rangoPolitica().subscribe((res: any) => {
      if (res.status == 200) {
        this.rangos = res.body;
        this.montoInferior = res.body.montoInferior;
        this.montoSuperior = res.body.montoSuperior;
      }
    }, err => {

    });
  }
}
