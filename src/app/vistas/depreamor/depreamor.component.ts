import { Component, Inject, OnInit } from '@angular/core';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';
import { CalculoModel } from 'app/models/calculo.model';

@Component({
  selector: 'app-depreamor',
  templateUrl: './depreamor.component.html',
  styleUrls: ['./depreamor.component.css']
})
export class DepreamorComponent implements OnInit {
  cal="";
  titulo:string;
  listaA=new CalculoModel();
  listaM:any;
  listaDia:any;
  codigo:string;
  activo:string;
  tipo:string;
  departamento:string;
  unidad:string;
  listaTabla: Array<CalculoModel>=[]
  fecha:Date;
  fech:Date;
  fec:Date;
  constructor(@Inject(MAT_DIALOG_DATA) public data: CalculoModel) { 
    this.listaA=data;
    if(this.listaA.calc==="DEPRECIA"){
      this.titulo="depreciacion";
    }else{
      this.titulo="amortizacion";
    }
    this.cal=this.listaA.ver;
    this.fecha=new Date(this.listaA.fecha);
    if(this.listaA.ver=="año"){
      console.log(data.vidaUtil/12);
      this.llenarTable(this.listaA.vidaUtil/12,this.listaA);
    }
    if(this.listaA.ver=="dia"){
      console.log(this.listaA.vidaUtil*30);
      this.llenarTable(this.listaA.vidaUtil*30,this.listaA);
    }
    if(this.listaA.ver=="mes"){
      console.log(this.listaA.vidaUtil);
      this.llenarTable(this.listaA.vidaUtil,this.listaA);
    }
    
  }
llenarTable(n:number,list:any){
  let cal=new CalculoModel();
  if(this.cal==="año"){
    cal.fecha=new Date(this.fecha.setFullYear(this.fecha.getFullYear()+1));
  }
  if(this.cal==="mes"){
    cal.fecha=new Date(this.fecha.setMonth(this.fecha.getMonth()+1));
  }
  if(this.cal==="dia"){
    cal.fecha=new Date(this.fecha.setDate(this.fecha.getDate()+1));
  }
  cal.monto=null;
  cal.acumulada=null;
  cal.valor=list.valor;
  this.listaTabla.push(cal);
  var monto=Number((list.valor/n).toFixed(6));
  var inc=0;
  for (let i = 1; i <=n; i++) {
    let calc=new CalculoModel();
    if(this.cal==="año"){
      calc.fecha=new Date(this.fecha.setFullYear(this.fecha.getFullYear()+1));
    }
    if(this.cal==="mes"){
      calc.fecha=new Date(this.fecha.setMonth(this.fecha.getMonth()+1));
    }
    if(this.cal==="dia"){
      calc.fecha=new Date(this.fecha.setDate(this.fecha.getDate()+1));
    }
    calc.monto=monto;
    inc=inc+monto;
    calc.acumulada=inc;
    list.valor=list.valor-monto;
    calc.valor=list.valor;
    this.listaTabla.push(calc);
  }
  console.log(this.listaTabla);
}
  ngOnInit(): void {
    this.llenarcampos();
  }

  llenarcampos(){
    this.codigo=this.listaA.codigo;
    this.tipo=this.listaA.tipo;
    this.activo=this.listaA.activo;
    this.departamento=this.listaA.departamento;
    this.unidad=this.listaA.unidad;
  }

}
/*caracteristicas de escritorio

Tipo
Escritorios
Requiere sistema de anclaje
No
Hecho en
Brasil
Dificultad de armado
Medio
Requiere armado
Sí
Política de devolución
Falabella
Información adicional
Ármalo como gustes y úsalo en 2 posiciones distintas.
Temporada
Toda temporada
Disponible en
Blanco y Café
Instrucciones de armado
Sí


software 
elaborado en angular con gestor de base de datos postgresql


calcular valor actual de los activos
primero calculamos la depreciacion diaria
depreciacion diaria= preciounitario/(vida util * 30)
valoractual= preciounitario-deppreciacion diaria * dias
dias = fecha actual - fecha de adquisicion */