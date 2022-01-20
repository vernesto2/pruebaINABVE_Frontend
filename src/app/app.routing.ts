import { TicketComponent } from './reportes/ticket/ticket.component';
import { NgModule } from '@angular/core';
import { CommonModule, } from '@angular/common';
import { BrowserModule  } from '@angular/platform-browser';
import { Routes, RouterModule } from '@angular/router';

import { AdminLayoutComponent } from './componentesAntiguos/layouts/admin-layout/admin-layout.component';
import { RazonesComponent } from './reportes/razones/razones.component';
import { LoginComponent } from './vistas/login/login.component';

const routes: Routes = [
  {
    path: '',
    component: AdminLayoutComponent,
    children: [{
      path: '',
      loadChildren: './componentesAntiguos/layouts/admin-layout/admin-layout.module#AdminLayoutModule'
    }]
  }, { path: 'reportes/razones-financieras', component: RazonesComponent },
  { path: 'reportes/ticket', component: TicketComponent },
  { path: 'iniciar-session', component: LoginComponent },

];

@NgModule({
  imports: [
    CommonModule,
    BrowserModule,
    RouterModule.forRoot(routes, {onSameUrlNavigation: 'reload'})
  ],
  exports: [
  ],
})
export class AppRoutingModule { }
