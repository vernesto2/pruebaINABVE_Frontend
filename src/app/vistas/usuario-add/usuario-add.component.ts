import { Component, EventEmitter, Inject, OnInit, Output } from '@angular/core';
import { FormGroup, NgForm } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { PersonaNaturalModel } from 'app/models/personaNatural.model';
import { UsuarioModel } from 'app/models/usuario.model';
import { PersonaService } from 'app/services/persona.service';
declare var $: any;

@Component({
  selector: 'app-usuario-add',
  templateUrl: './usuario-add.component.html',
  styleUrls: ['./usuario-add.component.css']
})
export class UsuarioAddComponent implements OnInit {

  //inicializar el constructor del modal
  usuario = new UsuarioModel();

   //variables de comunicacion con el padre
   @Output() onAgregado = new EventEmitter();

   //variables para validar rangos de fecha
   minDateInicio: Date;
   maxDateInicio: Date;
   minDateFin: Date;
   maxDateFin: Date;
   fecValida = true;
   forma: FormGroup;
   estado = false;
   accion = 'Registro';
   editar = false;
   duiRepre = 'DUI';
   nombreRepre = 'Nombre';
   listaPersona: any[];
   persona = new PersonaNaturalModel();
   pageAdd = 1;
   hide = true;
   hide1 = true;
   valido = false;

  constructor(public dialogRef: MatDialogRef<UsuarioAddComponent>, @Inject(MAT_DIALOG_DATA) public data: UsuarioModel,
  public personaService: PersonaService) {

    // if para mostrar el formulario lleno al
    // presionar el boton del ojito
    if (this.data != null) {
      this.editar = true;
      this.accion = 'Edición';
      this.usuario = data;
      this.estado = true;
    }
  }

  ngOnInit(): void {
    this.llenarPersonas();
  }

  llenarPersonas() {
    this.personaService.listarPersonas().subscribe((lista: any) => {
      this.listaPersona = lista.body;
    });
  }

  guardarusuario(forma: NgForm) {
    if (forma.invalid) {
      return;
    } else {
      if (this.editar) {
        this.personaService.editarUsuario(this.usuario).subscribe(res => {
          console.log(res);
            if (res.status == 200) {
              this.showNotification('top', 'right', 'Modificado Correctamente!', 'save', 'success');
              this.onAgregado.emit();
            } else {
              this.showNotification('bottom', 'right', 'Ocurrio un problema!', 'cancel', 'danger');
            }
          this.onAgregado.emit();
        });
      } else {
        this.usuario.nit = this.persona.nit;
        this.personaService.agregarUsuario(this.usuario).subscribe(res => {
          console.log(res);
            if (res.status == 200) {
              this.showNotification('top', 'right', 'Agregado Correctamente!', 'save', 'success');
              this.onAgregado.emit();
            } else {
              this.showNotification('bottom', 'right', 'Ocurrio un problema!', 'cancel', 'danger');
            }
          this.onAgregado.emit();
        });
      }
    }

  }

  sonIguales(value: string) {
    //console.log(this.forma);
    if (this.usuario.clave != null) {
      if (this.usuario.clave == this.usuario.reClave) {
        //this.valido = true;
      } else {
        //this.valido = false;
      }
    }
  }

  seleccionoPersona(persona: PersonaNaturalModel) {
    this.duiRepre = persona.dui;
    this.nombreRepre = persona.nombres + ' ' + persona.apellidos;
    this.persona = persona;
  }

  buscarPorDUI(value: string) {
    if (value.length >= 5) {
      this.personaService.buscarPor(value).subscribe((lista: any) => {
        this.listaPersona = lista.body;
        console.log(this.listaPersona);
      });
      console.log(value);
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
