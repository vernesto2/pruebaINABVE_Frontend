import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BeneficiosveteranosAddComponent } from './beneficiosveteranos-add.component';

describe('BeneficiosveteranosAddComponent', () => {
  let component: BeneficiosveteranosAddComponent;
  let fixture: ComponentFixture<BeneficiosveteranosAddComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ BeneficiosveteranosAddComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(BeneficiosveteranosAddComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
