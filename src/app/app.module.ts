import { CommonModule } from '@angular/common';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule } from '@angular/common/http';
import { RouterModule } from '@angular/router';
import { AppRoutingModule } from './app.routing';
import { ComponentsModule } from './components/components.module';

import { AppComponent } from './app.component';

//Componente Principal
import { AdminLayoutComponent } from './componentesAntiguos/layouts/admin-layout/admin-layout.component';

//imports del modulo de imports de AngularMaterial
import { MaterialModule } from './material/material.module';

//imports de terceros
import { NgxMaskModule, IConfig } from 'ngx-mask'

const maskConfig: Partial<IConfig> = {
  validation: false,
};
import {NgxPaginationModule} from 'ngx-pagination';
import { TelefonoPipe } from './pipes/telefono.pipe';
import { EdadPipe } from './pipes/edad.pipe';
import { DuiPipe } from './pipes/dui.pipe';
import { NitPipe } from './pipes/nit.pipe';
import { RazonesComponent } from './reportes/razones/razones.component';
import { TicketComponent } from './reportes/ticket/ticket.component';
import { VeteranoAddComponent } from './vistas/veterano-add/veterano-add.component';
import { VeteranoListComponent } from './vistas/veterano-list/veterano-list.component';
import { BeneficioAddComponent } from './vistas/beneficio-add/beneficio-add.component';
import { BeneficioListComponent } from './vistas/beneficio-list/beneficio-list.component';
import { BeneficiosveteranosListComponent } from './vistas/beneficiosveteranos-list/beneficiosveteranos-list.component';
import { BeneficiosveteranosAddComponent } from './vistas/beneficiosveteranos-add/beneficiosveteranos-add.component';

@NgModule({
  imports: [
    BrowserModule,
    BrowserAnimationsModule,
    FormsModule,
    ReactiveFormsModule,
    HttpClientModule,
    ComponentsModule,
    RouterModule,
    AppRoutingModule,
    MaterialModule,
    NgxPaginationModule,
    NgxMaskModule.forRoot(maskConfig),
  ],
  exports: [
    MaterialModule
  ],
  declarations: [
    AppComponent,
    AdminLayoutComponent,
    TelefonoPipe,
    NitPipe,
    EdadPipe,
    DuiPipe,
    RazonesComponent,
    TicketComponent,
    VeteranoAddComponent,
    VeteranoListComponent,
    BeneficioAddComponent,
    BeneficioListComponent,
    BeneficiosveteranosListComponent,
    BeneficiosveteranosAddComponent,
  ],
  entryComponents: [
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }

