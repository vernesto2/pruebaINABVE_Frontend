import { PersonaNaturalModel } from './../../models/personaNatural.model';
import { FormGroup } from '@angular/forms';
import { Component, EventEmitter, Inject, OnInit, Output } from '@angular/core';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { CreditoModel } from 'app/models/credito.model';
import { CreditoPersonalModel } from 'app/models/creditoPersonal.model';

@Component({
  selector: 'app-refinanciar',
  templateUrl: './refinanciar.component.html',
  styleUrls: ['./refinanciar.component.css']
})
export class RefinanciarComponent implements OnInit {
  credito = new CreditoPersonalModel();
  per = new PersonaNaturalModel();

  @Output() onAgregoRefinanciar = new EventEmitter();

  forma: FormGroup;
  constructor(public dialogRef: MatDialogRef<RefinanciarComponent>, 
    public dialog: MatDialog, @Inject(MAT_DIALOG_DATA) public data: CreditoPersonalModel) { 

  }

  ngOnInit(): void {
  }

  guardar() {

  }
  onCancelar() {
    this.dialogRef.close();
  }
}
