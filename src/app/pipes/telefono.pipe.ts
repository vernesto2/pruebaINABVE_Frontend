import { Pipe, PipeTransform } from '@angular/core';
import { stringify } from 'querystring';

@Pipe({
  name: 'telefono'
})
export class TelefonoPipe implements PipeTransform {

  transform(telefono: number): string {
    var aux = telefono.toString().substring(0, 3) + '-' + telefono.toString().substring(4, 7);
    return aux;
  }

}
