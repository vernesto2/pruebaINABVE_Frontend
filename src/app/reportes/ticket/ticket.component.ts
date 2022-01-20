import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-ticket',
  templateUrl: './ticket.component.html',
  styleUrls: ['./ticket.component.css']
})
export class TicketComponent implements OnInit {

  fecha = '';
  numCuota = 0;
  capital = 0;
  interes =  0;
  cuota =  0;
  capitalRestante =  0;
  montoEntregado =  0;
  cambio =  0;
  fechaSig = '';
  saldoMora = 0;
  total = 0;

  constructor() { }

  ngOnInit(): void {
    this.fecha = localStorage.getItem('fechaSimulada');

    this.llenarTicket();
  }

  llenarTicket() {
    this.fechaSig = localStorage.getItem('fechaCorrespondiente');
    
    this.numCuota = Number(localStorage.getItem('numCuota'));
    this.capital = Number(localStorage.getItem('capitalCancelado'));
    this.interes = Number(localStorage.getItem('interesCancelado'));
    this.cuota = Number(localStorage.getItem('cuotaCancelada'));
    this.saldoMora = Number(localStorage.getItem('saldoMora'));
    this.capitalRestante = Number(localStorage.getItem('capitalRestante'));
    this.montoEntregado = Number(localStorage.getItem('montoEntregado'));
    this.cambio = Number(localStorage.getItem('cambio'));
    this.total = this.cuota + this.saldoMora;
    
  }

}
