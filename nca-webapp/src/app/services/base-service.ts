import { HttpClient, HttpParams, HttpResponse } from '@angular/common/http';
import * as moment from 'moment';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { environment } from '../../environments/environment';

export class BaseService {

  constructor(protected httpClient: HttpClient) {
  }

  public get<T>(url: string): Observable<T> {
    return this.httpClient.get<T>(this.expandUrl(url)).pipe(map((o: T) => this.transform(o)));
  }

  public getWithParams<T>(url: string, params: HttpParams): Observable<T> {
    return this.httpClient.get<T>(this.expandUrl(url), { params }).pipe(map((o: T) => this.transform(o)));
  }

  public getWithResponse<T>(url: string): Observable<HttpResponse<T>> {
    return this.httpClient.get<T>(this.expandUrl(url), { observe: 'response' })
    .pipe(map((o: HttpResponse<T>) => this.transformResponse(o)));
  }

  public getWithResponseBlob(url: string): Observable<Object> {
    return this.httpClient.get(this.expandUrl(url), { responseType: 'blob' });
  }

  public post(url: string, body: any | null): Observable<Object> {
    return this.httpClient.post(this.expandUrl(url), body);
  }

  public postWithResponseBlob(url: string, body: any | null): Observable<Object> {
    return this.httpClient.post(this.expandUrl(url), body, { responseType: 'blob' });
  }

  public postT<T>(url: string, body: any | null): Observable<T> {
    return this.httpClient.post<T>(this.expandUrl(url), body).pipe(map((o: T) => this.transform(o)));
  }

  public put(url: string, body: any | null): Observable<Object> {
    return this.httpClient.put(this.expandUrl(url), body);
  }

  public putT<T>(url: string, body: any | null): Observable<T> {
    return this.httpClient.put<T>(this.expandUrl(url), body).pipe(map((o: T) => this.transform(o)));
  }

  public delete(url: string): Observable<Object> {
    return this.httpClient.delete(this.expandUrl(url));
  }

  public deleteWithBody(url: string, body: any | null): Observable<Object> {
    return this.httpClient.request('delete', this.expandUrl(url), { body });
  }

  private expandUrl(url: string): string {
    if (url.length === 0 || url[0] !== '/') {
      url = '/' + url;
    }
    return `${environment.ENDPOINT}` + url;
  }

  /**
   * Additional actions done on the domain object.
   * E.g. date fields are returned as strings; make sure they are converted to Date objects.
   */
  private transform(object: any): any {
    if (object !== null) {
      for (const key of Object.keys(object)) {
        const value = object[key];
        if (typeof value === 'string' && this.isIso8601DateString(value)) {
          object[key] = moment(value).toDate();
        }
        if (typeof value === 'object') {
          object[key] = this.transform(value);
        }
      }
    }
    return object;
  }

  private isIso8601DateString(value: string) {
    const REGEX: RegExp = /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z$/;
    return REGEX.test(value);
  }

  private transformResponse<T>(response: HttpResponse<T>): HttpResponse<T> {
    const newBody = this.transform(response.body);
    return response.clone({ body: newBody });
  }
}
