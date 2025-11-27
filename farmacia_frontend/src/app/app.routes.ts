import { Routes } from '@angular/router';
import { RequerimientosComponent } from './components/requerimientos/requerimientos.component';
import { AlmacenComponent } from './components/almacen/almacen.component';

import { ComprasComponent } from './components/compras/compras.component';

export const routes: Routes = [
    { path: 'requerimientos', component: RequerimientosComponent },
    { path: 'almacen', component: AlmacenComponent },
    { path: 'compras', component: ComprasComponent },
    { path: '', redirectTo: 'requerimientos', pathMatch: 'full' }
];
