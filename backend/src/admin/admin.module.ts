import { Module } from '@nestjs/common';
import { AdminController } from './admin.controller';
import { BusinessModule } from '../business/business.module';
import { AuthModule } from '../auth/auth.module';

@Module({
  imports: [BusinessModule, AuthModule],
  controllers: [AdminController],
})
export class AdminModule {}
