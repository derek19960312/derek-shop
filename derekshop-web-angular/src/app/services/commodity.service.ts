import { Injectable } from '@angular/core';
import { ApiService } from './api.service';
import { HttpParams } from '@angular/common/http';

@Injectable()
export class CommodityService {

  constructor(
    private apiService: ApiService
  ) { }

  getAll() {
    return this.apiService.get('/commodities');
  }

}
