import { Routes } from '@angular/router';
import { LoginComponent } from './components/login/login.component';
import { HomeComponent } from './components/home/home.component';
import { RequerimientosComponent } from './components/requerimientos/requerimientos.component';
import { AlmacenComponent } from './components/almacen/almacen.component';
import { ComprasComponent } from './components/compras/compras.component';
import { DistribucionComponent } from './components/distribucion/distribucion.component';
import { authGuard } from './guards/auth.guard';

export const routes: Routes = [
    // 1. La ruta del Login debe ser PÚBLICA (sin canActivate)
    { path: 'login', component: LoginComponent },
    { path: 'home', component: HomeComponent, canActivate: [authGuard] },

    // 2. Rutas Protegidas por Roles
    {
        path: 'requerimientos',
        component: RequerimientosComponent,
        canActivate: [authGuard],
        data: { roles: ['ADMIN', 'SOLICITANTE'] }
    },
    {
        path: 'almacen',
        component: AlmacenComponent,
        canActivate: [authGuard],
        data: { roles: ['ADMIN', 'ALMACEN'] }
    },
    {
        path: 'compras',
        component: ComprasComponent,
        canActivate: [authGuard],
        data: { roles: ['ADMIN', 'COMPRAS'] }
    },
    {
        path: 'distribucion',
        component: DistribucionComponent,
        canActivate: [authGuard],
        data: { roles: ['ADMIN', 'ALMACEN'] }
    },

    // 3. Ruta por defecto (La clave del arreglo)
    { path: '', redirectTo: 'login', pathMatch: 'full' },

    // 4. Cualquier ruta desconocida -> Login
    { path: '**', redirectTo: 'login' }
];