import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BeneficioAddComponent } from './beneficio-add.component';

describe('BeneficioAddComponent', () => {
  let component: BeneficioAddComponent;
  let fixture: ComponentFixture<BeneficioAddComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ BeneficioAddComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(BeneficioAddComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
