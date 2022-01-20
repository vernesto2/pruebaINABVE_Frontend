import { Component, OnInit } from '@angular/core';
import { PersonaService } from 'app/services/persona.service';
declare var $: any;

@Component({
  selector: 'app-inicio',
  templateUrl: './inicio.component.html',
  styleUrls: ['./inicio.component.css']
})
export class InicioComponent implements OnInit {

  fechaSimulada = new Date();
  simulada = true;

  constructor(public personaService: PersonaService) { }

  ngOnInit(): void {
  }

  actualizarFecha() {
    if (this.fechaSimulada !== null) {
      let fecha = new Date(this.fechaSimulada);
      const dia = fecha.getDate();
      const mes = fecha.getMonth() + 1;
      const anio = fecha.getFullYear();
      const f = anio + "-" + mes + "-" + dia;
      localStorage.setItem('fechaSimulada', f);
      this.personaService.simularFecha(f).subscribe((res: any) => {
        //console.log(res);
        this.showNotificationFecha('bottom', 'left', 'Fecha establecida: ' + res.fecha + ', es necesario recargar para efectuar cambios', 'sync', 'info');
      });
    }

  }

  seleccionarFecha(value: any) {
    this.fechaSimulada = value;
    this.simulada = false;
  }

  showNotificationFecha(from, align, message, icon, type) {
    $.notify({
      icon: icon,
      message: message

    }, {
      type: type,
      timer: 600000,
      placement: {
        from: from,
        align: align
      },
      template: '<div data-notify="container" class="col-xl-3 col-lg-3 col-11 col-sm-3 col-md-3 alert alert-{0} alert-with-icon" role="alert">' +
        '<button mat-button  type="button" aria-hidden="true" class="close mat-button" data-notify="dismiss">  <i class="material-icons">close</i></button>' +
        '<i class="material-icons" data-notify="icon">' + icon + '</i> ' +
        '<span data-notify="title">{1}</span> ' +
        '<span data-notify="message">{2}</span>'
    });
  }
}
