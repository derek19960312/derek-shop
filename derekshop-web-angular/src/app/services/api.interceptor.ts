import { Injectable } from '@angular/core';
import {
  HttpRequest,
  HttpHandler,
  HttpEvent,
  HttpInterceptor,
  HttpClient
} from '@angular/common/http';
import { Observable ,  throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';

@Injectable()
export class ApiInterceptor implements HttpInterceptor {

  constructor(
    private http: HttpClient
  ) {}

  private formatErrors(error: any) {
    return throwError(error.error);
  }

  intercept(req: HttpRequest<any>,
    next: HttpHandler): Observable<HttpEvent<any>> {
      // Let GET getJwtTokenPass
      if(!(req.method === 'GET' && req.url === 'getJwtToken')){
        const idToken = this.http.get('getJwtToken').pipe(catchError(this.formatErrors));

        if (idToken) {
          const cloned = req.clone({
              headers: req.headers.set("Authorization",
                  "Bearer " + idToken)
          });
  
          return next.handle(cloned);
        }
      }
      return next.handle(req);
    }
}
