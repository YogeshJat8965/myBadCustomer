import { Controller, Get, Patch, Param, Body, UseGuards, Query } from '@nestjs/common';
import { BusinessService } from '../business/business.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { RolesGuard, Roles } from '../auth/guards/roles.guard';
import { Role, VerificationStatus } from '../common/enums/prisma-enums';
import { CurrentUser } from '../auth/decorators/current-user.decorator';

@Controller('admin')
@UseGuards(JwtAuthGuard, RolesGuard)
@Roles(Role.ADMIN)
export class AdminController {
  constructor(private readonly businessService: BusinessService) {}

  @Get('businesses')
  async getAllBusinesses(
    @Query('page') page: string = '1',
    @Query('limit') limit: string = '10',
    @Query('status') status?: VerificationStatus,
  ) {
    return this.businessService.getAllBusinesses(
      parseInt(page),
      parseInt(limit),
      status,
    );
  }

  @Get('businesses/:id')
  async getBusinessById(@Param('id') id: string) {
    return this.businessService.getBusinessById(id);
  }

  @Patch('businesses/:id/verify')
  async verifyBusiness(
    @Param('id') id: string,
    @CurrentUser() admin: any,
    @Body() body: { status: VerificationStatus; rejectionReason?: string },
  ) {
    return this.businessService.verifyBusiness(
      id,
      admin.id,
      body.status,
      body.rejectionReason,
    );
  }
}
