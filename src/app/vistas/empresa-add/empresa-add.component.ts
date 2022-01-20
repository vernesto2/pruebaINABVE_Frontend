import { Component, OnInit, Inject, Output, EventEmitter } from '@angular/core';
import { FormArray, FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog'
import { DireccionModel } from 'app/models/direccion.model';
import { EmpresaModel } from 'app/models/empresa.model';
import { PersonaModel } from 'app/models/persona.model';
import { PersonaNaturalModel } from 'app/models/personaNatural.model';
import { TelModel } from 'app/models/tel.model';
import { TelefonoModel } from 'app/models/telefono.model';
import { TelefonoPKModel } from 'app/models/telefonoPKModel.model';
import { UbicacionModel } from 'app/models/ubicacion.model';
import { PersonaService } from 'app/services/persona.service';
declare var $: any;

@Component({
  selector: 'app-empresa-add',
  templateUrl: './empresa-add.component.html',
  styleUrls: ['./empresa-add.component.css']
})
export class EmpresaAddComponent implements OnInit {

  @Output() onAgregado1 = new EventEmitter();

  forma: FormGroup;
  persona = new PersonaModel();
  personaNatural = new PersonaNaturalModel();
  empresa = new EmpresaModel();
  direccion = new DireccionModel();
  ubicacion = new UbicacionModel();
  listaDepartamento: any[];
  listaMunicipio: any[];
  valido = true;
  listaTelefonos: Array<TelModel> = [];
  listaTel: Array<TelefonoModel> = [];
  deptoSel: any = [];
  muniSel: any = [];
  editarCampos = false;
  editar = false;
  busqueda = '';
  accion = 'Registro';

  //filtramos los representantes
  repre = new PersonaNaturalModel();
  listaRepresentante: any[];
  duiRepre = 'DUI'
  nombreRepre = 'Nombre de representante';
  //filtro y paginacion del representante

  constructor(public dialogRef: MatDialogRef<EmpresaAddComponent>, @Inject(MAT_DIALOG_DATA) public data: EmpresaModel,
    private fb: FormBuilder, public personaService: PersonaService) {
    this.crearFormulario(); 

    if (data != null) {
      this.cargandoEmpresa();
      this.personaService.buscarEmpresaNit(data.nit).subscribe((empresa: any) => {
        this.accion = 'Edición';
        this.empresa = empresa.body;
        this.repre = empresa.body.personaNatural;
        this.duiRepre = this.repre.dui;
        this.nombreRepre = this.repre.nombres + ' ' + this.repre.apellidos;
        //console.log(persona);
        this.muniSel = this.empresa.persona.direccion.ubicacion;
        this.editar = true;
        this.valido = false;
        this.editarCampos = true;

        //saco los 2 numeros del codigo para determinar el depto
        this.personaService.deptoPorCodigo(this.empresa.persona.direccion.ubicacion.codigo.toString().substring(0, 2)).subscribe((depto: any) => {
          this.deptoSeleccionado(depto.body);
          this.deptoSel = depto.body;
          //console.log(this.deptoSel);
          this.llenarFormulario();
        });
        this.listaTel = this.empresa.persona.telefonos;
        for (let i = 0; i < this.listaTel.length; i++) {
          let tel = new TelModel();
          tel.telefono = this.listaTel[i].id.telefono;
          tel.tipoContacto = this.listaTel[i].tipoContacto;
          this.listaTelefonos.push(tel);
        }
        this.editarCampos = false;
        this.showNotification('top', 'right', 'Datos encontrados', 'done_all', 'success');
      });
    }
  }

  ngOnInit(): void {
    this.listarDepartamentos();
  }

  //Con estas funciones comparamos y seteamos un valor a un SELECT
  compararDeptos(o1: any, o2: any): boolean {
    return o1.codigo === o2.codigo;
  }

  compararMuni(o1: any, o2: any): boolean {
    return o1.codigo === o2.codigo;
  }

  llenarFormulario() {
    // si usamos el .setValue tenemos que mandar el caparazon del obj completo en cambio si usamos
    // .reset no importa sino va completa la estructura del obj
    this.forma = this.fb.group({
      nit: [{ value: this.empresa.nit, disabled: true }, [Validators.required, Validators.minLength(14), Validators.maxLength(14)]],

      direccion: [{ value: this.empresa.persona.direccion.direccion, disabled: true }, [Validators.required]],
      ubicacion: [{ value: this.empresa.persona.direccion.ubicacion, disabled: true }, [Validators.required]],

      nombre: [{ value: this.empresa.nombre, disabled: true }, [Validators.required]],

      telefonos: this.fb.array([]),
    }, {
      validators: []
    });

    for (let i = 0; i < this.listaTelefonos.length; i++) {
      this.telefonos.push(this.fb.group({
        'tipoContacto': this.listaTelefonos[i].tipoContacto,
        'telefono': this.listaTelefonos[i].telefono
      }));
    }
  }

  crearFormulario() {
    this.forma = this.fb.group({
      nit: ['', [Validators.required, Validators.minLength(14), Validators.maxLength(14)]],

      direccion: ['', [Validators.required]],
      ubicacion: ['', [Validators.required]],

      nombre: ['', [Validators.required, Validators.minLength(3)]],
      telefonos: this.fb.array([
        this.fb.group({
          tipoContacto: ['',],
          telefono: ['', [Validators.minLength(8), Validators.maxLength(8)]]
        })
      ]),
    }, {
      validators: []
    });
  }

  separarModelos() {
    //Direccion
    this.direccion.direccion = this.forma.get('direccion').value;
    //Ubicacion
    this.ubicacion = this.forma.get('ubicacion').value;
    this.direccion.ubicacion = this.ubicacion;

    //Persona
    this.persona.nit = this.forma.get('nit').value;
    this.persona.tipoPersona = 'EMPRESA';
    this.persona.direccion = this.direccion;

    //Telefonos
    let listaCelular: Array<TelModel> = [];
    let listaCel: Array<TelefonoModel> = [];
    listaCelular = this.telefonos.value;
    if (listaCelular.length > 0) {
      for (let i = 0; i < listaCelular.length; i++) {
        let tel = new TelefonoModel();
        let telPk = new TelefonoPKModel();
        telPk.nit = this.persona.nit;
        telPk.telefono = listaCelular[i].telefono;
        tel.id = telPk;
        tel.tipoContacto = listaCelular[i].tipoContacto;
        //console.log(tel);
        listaCel.push(tel);
      }
      this.persona.telefonos = listaCel;
      console.log(listaCel);

      //empresa
      this.empresa.nit = this.forma.get('nit').value;
      this.empresa.personaNatural = this.repre;
      this.empresa.nombre = this.forma.get('nombre').value;
      this.empresa.persona = this.persona;
      //console.log(this.listaTel);
    }
    //console.log(this.personaNatural);
  }

  llenarRepresentantes() {
    this.personaService.listarPersonas().subscribe((lista: any) => {
      this.listaRepresentante = lista.body;
    });
  }

  seleccionoRepresentante(repre: PersonaNaturalModel) {
    this.duiRepre = repre.dui;
    this.nombreRepre = repre.nombres + ' ' + repre.apellidos;
    this.repre = repre;
    this.showNotification('top', 'right', 'Representante seleccionado', 'check', 'info');

  }

  buscarPorDUI(value: any) {
    //console.log(value.length);
    if (value.length > 5) {
      //aqui tiene q ir en EndPoint de buscar por DUI
      this.personaService.buscarPor(value).subscribe((lista: any) => {
        this.listaRepresentante = lista.body;
        //console.log(this.listaCliente);
      }, err => {
        this.showNotification('bottom', 'right', 'Cliente no encontrado!', 'cancel', 'danger');
      });
    }
  }

  guardar() {
    if (this.forma.invalid) {
      this.showNotification('bottom', 'right', 'Registro cancelado!', 'cancel', 'warning');
    } else {
      //console.log(this.personaNatural);
      if (this.editar) { //si es verdadero EDITAMOS
        this.separarModelos();
        this.personaService.editarEmpresa(this.empresa).subscribe((res: any) => {
          if (res.status == 200) {
            //console.log(res);
            this.showNotification('top', 'right', 'Modificado Correctamente.!', 'sync', 'success');
            this.onAgregado1.emit();
          } else {
            //console.log('else ', res);
            this.showNotification('bottom', 'right', 'Ocurrio un problema.!', 'cancel', 'danger');
          }
        }, err => {
          this.showNotification('bottom', 'right', err.error.mensaje, 'cancel', 'danger');
        });
      } else { //Si es falso AGREGAMOS
        this.separarModelos();
        this.personaService.agregarEmpresa(this.empresa).subscribe((res: any) => {
          if (res.status == 200) {
            //console.log(res);
            this.showNotification('top', 'right', 'Agregado Correctamente.!', 'save', 'success');
            this.onAgregado1.emit();
          } else {
            //console.log('else ', res);
            this.showNotification('bottom', 'right', 'Ocurrio un problema.!', 'cancel', 'danger');
          }
        }, err => {
          console.log(err);
          this.showNotification('bottom', 'right', err.error.mensaje, 'cancel', 'danger');
        });
      }
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

  listarDepartamentos() {
    this.personaService.listarDepartamento().subscribe((lista: any) => {
      this.listaDepartamento = lista.body;
    });
  }

  cargandoEmpresa() {
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

  deptoSeleccionado(depto) {
    this.personaService.listarMunicipioPorDepto(depto.codigo).subscribe((lista: any) => {
      this.listaMunicipio = lista.body;

      if (this.listaMunicipio.length > 0) {
        this.valido = false;
      } else {
        this.valido = true;
      }
    });
  }

  agregarTelefonos() {
    this.telefonos.push(
      this.fb.group({
        tipoContacto: ['', []],
        telefono: ['', [Validators.minLength(8), Validators.maxLength(8)]]
      })
    );
  }

  eliminarTelefonos(i: number) {
    this.telefonos.removeAt(i);
  }

  onCancelar() {
    this.dialogRef.close();
  }

  // Validaciones del formulario
  get telefonos() {
    return this.forma.get('telefonos') as FormArray;
  }

}
