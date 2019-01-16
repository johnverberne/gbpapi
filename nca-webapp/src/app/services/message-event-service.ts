import { Injectable } from '@angular/core';
import { Subject, Observable } from 'rxjs';

@Injectable()
export class MessageEventService {

  private messageSubject: Subject<string | string[]> = new Subject();

  public onMessageSend(): Observable<string | string[]> {
    return this.messageSubject.asObservable();
  }

  public sendMessage(message: string | string[]) {
    this.messageSubject.next(message);
  }
}
