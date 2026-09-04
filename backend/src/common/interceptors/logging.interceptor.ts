import {
  Injectable,
  NestInterceptor,
  ExecutionContext,
  CallHandler,
  Logger,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { tap } from 'rxjs/operators';

@Injectable()
export class LoggingInterceptor implements NestInterceptor {
  private readonly logger = new Logger('HTTP');

  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    const ctx = context.switchToHttp();
    const request = ctx.getRequest();
    const { method, originalUrl } = request;
    const now = Date.now();

    return next.handle().pipe(
      tap({
        next: (data) => {
          const response = ctx.getResponse();
          const delay = Date.now() - now;
          this.logger.log(`[${method}] ${originalUrl} - ${response.statusCode} - ${delay}ms`);
        },
        error: (error) => {
          const status = error.status || 500;
          const delay = Date.now() - now;
          this.logger.error(`[${method}] ${originalUrl} - ${status} - ${delay}ms`);
        },
      }),
    );
  }
}
