import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'dui'
})
export class DuiPipe implements PipeTransform {

  transform(dui: number): string {
    var aux = dui.toString().substring(0, 8) + '-' + dui.toString().substring(8, 9);
    return aux;
  }

}
