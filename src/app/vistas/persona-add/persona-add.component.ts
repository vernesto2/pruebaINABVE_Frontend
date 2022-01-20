import { Component, OnInit, Inject, Output, EventEmitter } from '@angular/core';
import { FormBuilder, FormGroup, Validators, FormArray } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog'
import { DireccionModel } from 'app/models/direccion.model';
import { PersonaModel } from 'app/models/persona.model';
import { PersonaNaturalModel } from 'app/models/personaNatural.model';
import { TelModel } from 'app/models/tel.model';
import { TelefonoModel } from 'app/models/telefono.model';
import { TelefonoPKModel } from 'app/models/telefonoPKModel.model';
import { UbicacionModel } from 'app/models/ubicacion.model';
import { PersonaService } from 'app/services/persona.service';
declare var $: any;

@Component({
  selector: 'app-persona-add',
  templateUrl: './persona-add.component.html',
  styleUrls: ['./persona-add.component.css']
})
export class PersonaAddComponent implements OnInit {

  @Output() onAgregado = new EventEmitter(); 

  accion = 'Registro';
  forma: FormGroup;
  persona = new PersonaModel();
  personaNatural = new PersonaNaturalModel();
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

  //agregando la fecha minima y maxima para validar los datepicker
  minDate: Date;
  maxDate: Date;

  constructor(public dialogRef: MatDialogRef<PersonaAddComponent>, @Inject(MAT_DIALOG_DATA) public data: PersonaNaturalModel,
  private fb: FormBuilder, public personaService: PersonaService) {
    //lleno el formulario cuando selecciono el de editar
    this.crearFormulario();
    this.listarDepartamentos();
    if (data != null) {
      this.accion = 'Edición';
      this.cargandoPersona();
      this.personaService.buscarNIT(data.nit).subscribe((persona: any) => {
        this.personaNatural = persona.body;
        //console.log(persona);
        this.muniSel = this.personaNatural.persona.direccion.ubicacion;
        this.editar = true;
        this.valido = false;
        this.editarCampos = true;

        //saco los 2 numeros del codigo para determinar el depto
        this.personaService.deptoPorCodigo(this.personaNatural.persona.direccion.ubicacion.codigo.toString().substring(0, 2)).subscribe((depto: any) => {
          this.deptoSeleccionado(depto.body);
          this.deptoSel = depto.body;
          //console.log(this.deptoSel);
          this.llenarFormulario();
        });
        this.listaTel = this.personaNatural.persona.telefonos;
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
    //seteando las fechas minimas y maximas
    const currentYear = new Date().getFullYear(); //obtenemos el año actual
    const currentDay = new Date().getDate(); //sacamos los dias actuales
    const currentMonth = new Date().getMonth(); // aqui obtenemos el mes, pero inicia desde 0
    //console.log(currentYear + '-' + currentMonth + '-' + currentDay );
    //                      2021 - 65 = 1956, mes       0,  dia    2  fecha minima que se mostrara
    // -- aqui estamos indicando que la persona tiene que tener al menos 65 años de edad como maximo para hacer un credito
    this.minDate = new Date(currentYear - 65, currentMonth, currentDay);
    //                      2021 - 18 = 2003, mes       0,  dia    2  fecha maxima que se mostrara
    // -- con esto estamos validando que la persona tiene que ser mayor de 18 años
    this.maxDate = new Date(currentYear - 18 , currentMonth, currentDay);
  }

  ngOnInit(): void {
  }

  listarDepartamentos() {
    this.personaService.listarDepartamento().subscribe((lista: any) => {
      this.listaDepartamento = lista.body;
    });
  }

  llenarFormulario() {
    // si usamos el .setValue tenemos que mandar el caparazon del obj completo en cambio si usamos
    // .reset no importa sino va completa la estructura del obj
    this.forma = this.fb.group({
      nit: [{value: this.personaNatural.nit, disabled: true}, [Validators.required, Validators.minLength(14), Validators.maxLength(14)]],

      direccion: [this.personaNatural.persona.direccion.direccion, [Validators.required]],
      ubicacion: [this.personaNatural.persona.direccion.ubicacion, [Validators.required]],

      dui: [{value: this.personaNatural.dui, disabled: true}, [Validators.required, Validators.minLength(9), Validators.maxLength(9)]],
      nombres: [{value: this.personaNatural.nombres, disabled: true}, [Validators.required, Validators.minLength(3)]],
      apellidos: [{value: this.personaNatural.apellidos, disabled: true}, [Validators.required, Validators.minLength(3)]],
      estadoCivil: [this.personaNatural.estadoCivil, [Validators.required]],
      genero: [{value: this.personaNatural.genero, disabled: true}, [Validators.required]],
      fechaNacimiento: [{value: this.personaNatural.fechaNacimiento, disabled: true}, [Validators.required]],

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

  //Con estas funciones comparamos y seteamos un valor a un SELECT
  compararDeptos(o1: any, o2: any): boolean {
    return o1.codigo === o2.codigo;
  }

  compararMuni(o1: any, o2: any): boolean {
    return o1.codigo === o2.codigo;
  }

  crearFormulario() {
    this.forma = this.fb.group({
      nit: ['', [Validators.required, Validators.minLength(14), Validators.maxLength(14)]],

      direccion: ['', [Validators.required]],
      ubicacion: ['', [Validators.required]],

      dui: ['', [Validators.required, Validators.minLength(9), Validators.maxLength(9)]],
      nombres: ['', [Validators.required, Validators.minLength(3)]],
      apellidos: ['', [Validators.required, Validators.minLength(3)]],
      estadoCivil: ['', [Validators.required]],
      genero: ['', [Validators.required]],
      fechaNacimiento: ['', [Validators.required]],

      telefonos: this.fb.array([
          this.fb.group({
            tipoContacto: ['', []],
            telefono: ['', [Validators.minLength(8), Validators.maxLength(8)]]
          })
      ]),
    }, {
      validators: []
    });
  }

  guardar() {
    if (this.forma.invalid) {
      this.showNotification('bottom', 'left', 'Registro cancelado', 'cancel', 'warning');
    } else {
      //console.log(this.personaNatural);
      if (this.editar) { //si es verdadero EDITAMOS
        this.separarModelos();
        this.personaService.editarPersona(this.personaNatural).subscribe((res: any) => {
          if (res.status == 200) {
            this.showNotification('top', 'right', 'Modificado Correctamente.!', 'sync', 'success');
            this.onAgregado.emit();
          } else {
            this.showNotification('bottom', 'right', 'Ocurrio un problema!', 'cancel', 'danger');
          }
        }, err => {
          this.showNotification('bottom', 'right', err.error.mensaje, 'cancel', 'danger');
        });
      } else { //Si es falso AGREGAMOS
        this.separarModelos();
        this.personaService.agregarPersona(this.personaNatural).subscribe((res: any) => {
          if (res.status == 200) {
            this.showNotification('top', 'right', 'Agregado correctamente!', 'save', 'success');
            this.onAgregado.emit();
          } else {
            this.showNotification('bottom', 'right', 'Ocurrio un problema!', 'cancel', 'danger');
          }
        }, err => {
          this.showNotification('bottom', 'right', err.error.mensaje, 'cancel', 'danger');
        });
      }
    }
  }

  cargandoPersona() {
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

  separarModelos() {
    //Direccion
    this.direccion.direccion = this.forma.get('direccion').value;
    //Ubicacion
    this.ubicacion = this.forma.get('ubicacion').value;
    this.direccion.ubicacion = this.ubicacion;

    //Persona
    this.persona.nit = this.forma.get('nit').value;
    this.persona.tipoPersona = 'PERSONA';
    this.persona.direccion = this.direccion;

    //PersonaNatural
    this.personaNatural.nit = this.forma.get('nit').value;
    this.personaNatural.dui = this.forma.get('dui').value;
    this.personaNatural.nombres = this.forma.get('nombres').value;
    this.personaNatural.apellidos = this.forma.get('apellidos').value;
    this.personaNatural.estadoCivil = this.forma.get('estadoCivil').value;
    this.personaNatural.fechaNacimiento = this.forma.get('fechaNacimiento').value;
    this.personaNatural.genero = this.forma.get('genero').value;
    this.personaNatural.persona = this.persona;

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
      //console.log(listaCelular);
    }
    //console.log(this.personaNatural);
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
