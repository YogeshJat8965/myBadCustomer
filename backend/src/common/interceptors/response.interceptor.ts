import {
  Injectable,
  NestInterceptor,
  ExecutionContext,
  CallHandler,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

export interface Response<T> {
  success: boolean;
  statusCode: number;
  message: string;
  data: T;
  timestamp: string;
}

@Injectable()
export class ResponseInterceptor<T> implements NestInterceptor<T, Response<T>> {
  intercept(
    context: ExecutionContext,
    next: CallHandler,
  ): Observable<Response<T>> {
    const ctx = context.switchToHttp();
    const response = ctx.getResponse();
    
    return next.handle().pipe(
      map((data) => ({
        success: true,
        statusCode: response.statusCode,
        message: data?.message || 'Operation successful',
        data: data?.data ?? data, // If data object already has data property, unwrap it, otherwise wrap it
        timestamp: new Date().toISOString(),
      })),
    );
  }
}
