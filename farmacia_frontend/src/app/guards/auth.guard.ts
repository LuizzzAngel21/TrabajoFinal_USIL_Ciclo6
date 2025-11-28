import { CanActivateFn } from '@angular/router';

export const authGuard: CanActivateFn = (route, state) => {
  console.log('🚨 GUARD DESACTIVADO: Permitiendo paso a ' + state.url);
  return true; // Dejamos pasar a todos para probar si el botón funciona
};