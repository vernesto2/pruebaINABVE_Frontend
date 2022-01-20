import { Routes } from '@angular/router';

import { DashboardComponent } from '../../dashboard/dashboard.component';
import { ActivoFijoListComponent } from 'app/vistas/activo-fijo-list/activo-fijo-list.component';
import { PoliticasListComponent } from 'app/vistas/politicas-list/politicas-list.component';
import { PrecreditoAddComponent } from 'app/vistas/precredito-add/precredito-add.component';
import { CreditoEmpresaAddComponent } from 'app/vistas/credito-empresa-add/credito-empresa-add.component';
import { PersonaListComponent } from 'app/vistas/persona-list/persona-list.component';
import { EmpresaListComponent } from 'app/vistas/empresa-list/empresa-list.component';
import { UsuarioListComponent } from 'app/vistas/usuario-list/usuario-list.component';
import { CobroComponent } from 'app/vistas/cobro/cobro.component';
import { InicioComponent } from 'app/vistas/inicio/inicio.component';

export const AdminLayoutRoutes: Routes = [
    { path: '',      redirectTo: 'inicio' }, //por defecto va mostrar esta ruta en caso que la url este vacia
    { path: 'activofijo',  component: ActivoFijoListComponent },
    { path: 'clientes-persona',  component: PersonaListComponent },
    { path: 'clientes-empresa',  component: EmpresaListComponent },
    { path: 'politicas',  component: PoliticasListComponent },
    { path: 'creditopersonal',  component: PrecreditoAddComponent },
    { path: 'creditoempresa',  component: CreditoEmpresaAddComponent },
    { path: 'usuario',  component: UsuarioListComponent },
    { path: 'cobro',  component: CobroComponent},
    { path: 'inicio',  component: InicioComponent},
];
