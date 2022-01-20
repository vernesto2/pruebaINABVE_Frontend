import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BeneficiosveteranosListComponent } from './beneficiosveteranos-list.component';

describe('BeneficiosveteranosListComponent', () => {
  let component: BeneficiosveteranosListComponent;
  let fixture: ComponentFixture<BeneficiosveteranosListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ BeneficiosveteranosListComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(BeneficiosveteranosListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
