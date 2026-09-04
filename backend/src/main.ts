import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';
import helmet from 'helmet';
import compression from 'compression';
import rateLimit from 'express-rate-limit';
import { HttpExceptionFilter } from './common/filters/http-exception.filter';
import { ResponseInterceptor } from './common/interceptors/response.interceptor';
import { LoggingInterceptor } from './common/interceptors/logging.interceptor';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // API Prefix
  app.setGlobalPrefix(process.env.API_PREFIX || 'api/v1');

  // Global Validation Pipe
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true, // strip unknown properties
      forbidNonWhitelisted: true, // throw error on unknown properties
      transform: true, // auto-transform payloads to DTO instances
    }),
  );

  // Global Error Filter
  app.useGlobalFilters(new HttpExceptionFilter());

  // Global Interceptors (Response Formatting & Logging)
  app.useGlobalInterceptors(
    new LoggingInterceptor(),
    new ResponseInterceptor()
  );

  // Security Headers
  app.use(helmet());

  // Gzip Compression
  app.use(compression());

  // CORS Configuration
  app.enableCors({
    origin: ['http://localhost:3001', 'http://localhost:3002'], // Add your frontend/admin panel URLs here
    credentials: true,
  });

  // Rate Limiting
  app.use(
    rateLimit({
      windowMs: 15 * 60 * 1000, // 15 minutes
      max: 100, // limit each IP to 100 requests per windowMs
      message: 'Too many requests from this IP, please try again later.',
    }),
  );

  const port = process.env.PORT || 3000;
  await app.listen(port);
  console.log(`🚀 Application is running on: http://localhost:${port}/${process.env.API_PREFIX || 'api/v1'}`);
}
bootstrap();
