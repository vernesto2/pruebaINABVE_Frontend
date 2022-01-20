import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'nit'
})
export class NitPipe implements PipeTransform {

  transform(nit: number): string {
    var aux = nit.toString().substring(0, 4) + '-' + nit.toString().substring(4, 10) + '-'
    + nit.toString().substring(10, 13) + '-' + nit.toString().substring(13, 14);
    return aux;
  }

}
