import { EmpresaModel } from 'app/models/empresa.model';
import { CreditoEmpresaModel } from './../../models/creditoEmpresa.model';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, NgForm, Validators } from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';
import { RazonesModel } from 'app/models/razones.model';
import { Observable } from 'rxjs';
import { RazonesFinancierasComponent } from '../razones-financieras/razones-financieras.component';
import { CreditoModel } from 'app/models/credito.model';
import { CreditosService } from 'app/services/creditos.service';
import { BienGarantiaModel } from 'app/models/bienGarantia.model';
import { IngresoEgresoModel } from 'app/models/ingresoEgreso.model';
import { UsuarioModel } from 'app/models/usuario.model';
import { ProyeccionesComponent } from '../proyecciones/proyecciones.component';
import { PersonaService } from 'app/services/persona.service';
import { EmpresaAddComponent } from '../empresa-add/empresa-add.component';
import { PersonaAddComponent } from '../persona-add/persona-add.component';

declare var $: any;

@Component({
  selector: 'app-credito-empresa-add',
  templateUrl: './credito-empresa-add.component.html',
  styleUrls: ['./credito-empresa-add.component.css']
})
export class CreditoEmpresaAddComponent implements OnInit {
  
  creditoEmpresa = new CreditoEmpresaModel();
  credito = new CreditoModel();
  tipoCredito = 'HIPOTECARIO';

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
  validarBoton = true;
  clienteValido = true;
  codigoBienSel = 'Código';
  tipoBienSel = 'Tipo de bien';

  //Para seleccionar Cliente y Fiador
  listaCliente: any[] = [];
  clienteSel = new EmpresaModel();
  duiCliente = 'NIT';
  nombreCliente = 'Nombre';
  fecha: Date;
  //variables de validacion
  montoInferior = 0;
  montoSuperior = 0;
  tiempoInferior = 0;
  tiempoSuperior = 0;
  rangos: any;

  //ingresosEgresos
  ingresosEgresosCliente = new IngresoEgresoModel();

  //hipotecario
  valorFinanciado = 0;
  bienHipotecado = new BienGarantiaModel();
  mensajeHipotecario = '';
  listaBien: any[] = [];

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

  separarModeloHipoteca() {
    this.creditoEmpresa.empresa = this.clienteSel;
    this.credito.bienGarantias.push(this.bienHipotecado);
    this.credito.fechaSolicitud = this.credito.fechaAprobacion;
    this.credito.usuario = this.usuario;
    this.credito.creditoEmpresa = this.creditoEmpresa;
  }

  openDialogRazones(razones?: RazonesModel) {
    let dialogref = this.dialog.open(RazonesFinancierasComponent, { });
  }

  resetearForm() {
    this.creditoEmpresa = new CreditoEmpresaModel();
    this.credito = new CreditoModel();
    this.ingresosEgresosCliente = new IngresoEgresoModel();
    this.clienteSel = new EmpresaModel();
    this.bienHipotecado = new BienGarantiaModel();
    this.duiCliente = 'NIT';
    this.nombreCliente = 'Nombre';
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
    this.validarBoton = true;
    this.mensajeHipotecario = '';
    this.valorFinanciado = 0;
    this.codigoBienSel = 'Código';
    this.tipoBienSel = 'Tipo de bien';
  }

  guardarCP(forma: NgForm) {
    this.separarModeloHipoteca();
    this.cargandoCredito();
    console.log(JSON.stringify(this.credito));
    this.servicesCP.agregarCreditoEmpresa(this.credito, this.tipoCredito, this.tipoTiempo).subscribe(res => {
      if (res.status == 200) {
        console.log(res);
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

  seleccionoCliente(cliente: EmpresaModel) {
    this.showNotification('top', 'right', 'Cliente seleccionado', 'check', 'info');
    this.clienteSel = cliente;
    this.duiCliente = cliente.nit;
    this.nombreCliente = cliente.nombre;
    this.servicesCP.consultarSiEmpresaPoseeCredito(cliente.nit).subscribe((res: any) => {
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

  buscarNitoNombre(value?: string) {
    this.servicesCP.buscarNitNombreEmpresa(value).subscribe((lista: any) => {
      console.log(lista);
      this.listaCliente = lista.body;
      this.showNotification('top', 'right', 'Empresa encontrada', 'search', 'success');
    }, err => {
      this.showNotification('bottom', 'right', err.error.mensaje, 'cancel', 'danger');
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

  vefirifcarIngresos(value: number){
    if(value>(this.ingresosEgresosCliente.ingresosTotales+this.ingresosEgresosCliente.otrosIngresos)){
      this.showNotification('bottom', 'right', 'Los egresos deben ser menor que los ingresos', 'cancel', 'danger');
    }
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

  montoFinanciado(valor: number) {
    if (valor != null) {
      //console.log(valor);
      this.valorFinanciado = (Number(valor) * 0.90);

      if (this.credito.monto != null) {
        if ((this.credito.monto >= this.valorFinanciado)) {
          this.validarBoton = true;
          this.showNotification('bottom', 'right', 'El monto solicitado no puede ser financiado', 'cancel', 'danger');
        } else {
          this.validarBoton = false;
          this.showNotification('top', 'right', 'El monto solicitado si puede ser financiado', 'done_all', 'success');
        }
      } else {
        this.showNotification('bottom', 'right', 'No se ingreso un monto a solicitar', 'cancel', 'danger');
      }
    }
  }

  llamarContrato() {
    if (this.clienteSel != null) {
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

  openDialogEmpresa() {
    const dialogref = this.dialog.open(EmpresaAddComponent, {});
    dialogref.beforeClosed().subscribe(res => { });
  }

  openDialogPersona() {
    const dialogref = this.dialog.open(PersonaAddComponent, {});
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

  seleccionarTipo(tipo: string) {
    this.tipoCredito = tipo;
    if (this.credito.monto != null && this.credito.tiempo != null) {
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
    if (this.tipoCredito !== '' && this.credito.tiempo != null) {
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

    if (this.valorFinanciado !== 0) {
      if (this.credito.monto != null) {
        if (this.credito.monto >= this.valorFinanciado) {
          this.validarBoton = true;
          this.showNotification('bottom', 'right', 'El monto solicitado no puede ser financiado', 'cancel', 'danger');
        } else {
          this.validarBoton = false;
          this.showNotification('top', 'right', 'El monto solicitado si puede ser financiado', 'done_all', 'success');
        }
      } else {
        this.showNotification('bottom', 'right', 'No se ingreso un monto a solicitar', 'cancel', 'danger');
      }
    }

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
