import { Component, OnInit } from '@angular/core';

declare const $: any;
declare interface RouteInfo {
    path: string;
    title: string;
    icon: string;
    class: string;
}
export const ROUTES: RouteInfo[] = [
    { path: '/veteranos', title: 'Listado de Veteranos',  icon: 'supervisor_account', class: '' },
    { path: '/beneficios', title: 'Listado de Beneficios',  icon: 'privacy_tip', class: '' },
];

@Component({
  selector: 'app-sidebar',
  templateUrl: './sidebar.component.html',
  styleUrls: ['./sidebar.component.css']
})
export class SidebarComponent implements OnInit {
  menuItems: any[] = [];

  constructor() { }

  ngOnInit() {
    /* let usuario = {
      tipoUsuario: 'Admin'
    }
    for (let i = 0; i < ROUTES.length; i++) {
      if (usuario.tipoUsuario == "Admin" && (i < 10)) {
        this.menuItems.push(ROUTES[i]);
      }
    } */
    this.menuItems = ROUTES.filter(menuItem => menuItem);
    //console.log(ROUTES.length);
  }
  isMobileMenu() {
      if ($(window).width() > 991) {
          return false;
      }
      return true;
  };
}
