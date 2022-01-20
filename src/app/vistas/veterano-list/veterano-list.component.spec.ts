import { ComponentFixture, TestBed } from '@angular/core/testing';

import { VeteranoListComponent } from './veterano-list.component';

describe('VeteranoListComponent', () => {
  let component: VeteranoListComponent;
  let fixture: ComponentFixture<VeteranoListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ VeteranoListComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(VeteranoListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
