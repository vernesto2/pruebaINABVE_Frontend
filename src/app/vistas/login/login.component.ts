import { Component, OnInit } from '@angular/core';
import { FormGroup } from '@angular/forms';
import { UsuarioModel } from 'app/models/usuario.model';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  usuario = new UsuarioModel();
  hide = true;

  constructor() { }

  ngOnInit(): void {
  }

  iniciarSession(forma: FormGroup) {

  }

  cancelar() {

  }

}
