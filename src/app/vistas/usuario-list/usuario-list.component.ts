import { Component, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { UsuarioModel } from 'app/models/usuario.model';
import { PersonaService } from 'app/services/persona.service';
import { UsuarioAddComponent } from '../usuario-add/usuario-add.component';

@Component({
  selector: 'app-usuario-list',
  templateUrl: './usuario-list.component.html',
  styleUrls: ['./usuario-list.component.css']
})
export class UsuarioListComponent implements OnInit {

  listaUsuarios: any[];
  cargando = false;
  pageList = 1; //variable que llevara el control de la pagina de la paginacion

  constructor(public dialog: MatDialog, public servicePersona: PersonaService) { }

  ngOnInit(): void {
    this.llenarUsuarios();
  }

  llenarUsuarios() {
    this.cargando = true;
    this.servicePersona.listarUsuario().subscribe((res: any) => {
      this.listaUsuarios = res.body;
      this.cargando = false;
    })
  }

  openDialogUsuarios(usuario?: UsuarioModel) {
    const data = {
      onAgrego: this.onAgrego
    }
    const dialogref = this.dialog.open(UsuarioAddComponent, { data: usuario});
    const sub = dialogref.componentInstance.onAgregado.subscribe(() => {
      this.onAgrego();
    });
    dialogref.beforeClosed().subscribe( res => {});
  }

  onAgrego() {
    this.llenarUsuarios();
  }

}
