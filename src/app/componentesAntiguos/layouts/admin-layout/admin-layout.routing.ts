import { Routes } from '@angular/router';
import { BeneficioListComponent } from 'app/vistas/beneficio-list/beneficio-list.component';
import { BeneficiosveteranosListComponent } from 'app/vistas/beneficiosveteranos-list/beneficiosveteranos-list.component';
import { VeteranoListComponent } from 'app/vistas/veterano-list/veterano-list.component';

import { DashboardComponent } from '../../dashboard/dashboard.component';

export const AdminLayoutRoutes: Routes = [
    { path: '',      redirectTo: 'inicio' }, //por defecto va mostrar esta ruta en caso que la url este vacia
    { path: 'veteranos',  component: VeteranoListComponent },
    { path: 'beneficios',  component: BeneficioListComponent },
];
