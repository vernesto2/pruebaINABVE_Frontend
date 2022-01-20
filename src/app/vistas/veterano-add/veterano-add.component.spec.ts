import { ComponentFixture, TestBed } from '@angular/core/testing';

import { VeteranoAddComponent } from './veterano-add.component';

describe('VeteranoAddComponent', () => {
  let component: VeteranoAddComponent;
  let fixture: ComponentFixture<VeteranoAddComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ VeteranoAddComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(VeteranoAddComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
