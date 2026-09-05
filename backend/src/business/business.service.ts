import { Injectable, ConflictException, NotFoundException, ForbiddenException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CloudinaryService } from '../cloudinary/cloudinary.service';
import { CreateBusinessDto } from './dto/create-business.dto';
import { UpdateBusinessDto } from './dto/update-business.dto';
import { VerificationStatus } from '../common/enums/prisma-enums';

@Injectable()
export class BusinessService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly cloudinaryService: CloudinaryService,
  ) {}

  async createBusiness(userId: string, dto: CreateBusinessDto, proofFile?: Express.Multer.File) {
    // 1. Check if user already has a business
    const existingBusiness = await this.prisma.business.findUnique({
      where: { userId },
    });

    if (existingBusiness) {
      throw new ConflictException('User already has a business profile');
    }

    let businessProofUrl = null;
    let businessProofPublicId = null;

    // 2. Upload proof file if provided
    if (proofFile) {
      const uploadResult = await this.cloudinaryService.uploadFile(proofFile, 'business-proofs');
      businessProofUrl = uploadResult.secure_url;
      businessProofPublicId = uploadResult.public_id;
    }

    // 3. Create business record
    const business = await this.prisma.business.create({
      data: {
        ...dto,
        userId,
        businessProofUrl,
        businessProofPublicId,
      },
    });

    // 4. Update user verification status to PENDING
    await this.prisma.user.update({
      where: { id: userId },
      data: { verificationStatus: VerificationStatus.PENDING },
    });

    return business;
  }

  async getMyBusiness(userId: string) {
    const business = await this.prisma.business.findUnique({
      where: { userId },
      include: { user: true },
    });

    if (!business) {
      throw new NotFoundException('Business profile not found');
    }

    return business;
  }

  async updateBusiness(userId: string, dto: UpdateBusinessDto) {
    const business = await this.prisma.business.findUnique({
      where: { userId },
    });

    if (!business) {
      throw new NotFoundException('Business profile not found');
    }

    if (business.verifiedAt) {
      throw new ForbiddenException('Cannot modify a verified business. Please contact support.');
    }

    const updatedBusiness = await this.prisma.business.update({
      where: { userId },
      data: {
        ...dto,
        // Reset verification status if they update info
      },
    });

    await this.prisma.user.update({
      where: { id: userId },
      data: { verificationStatus: VerificationStatus.PENDING },
    });

    return updatedBusiness;
  }

  async uploadProof(userId: string, file: Express.Multer.File) {
    const business = await this.prisma.business.findUnique({
      where: { userId },
    });

    if (!business) {
      throw new NotFoundException('Business profile not found');
    }

    // Delete old proof if it exists
    if (business.businessProofPublicId) {
      await this.cloudinaryService.deleteFile(business.businessProofPublicId);
    }

    const uploadResult = await this.cloudinaryService.uploadFile(file, 'business-proofs');

    const updatedBusiness = await this.prisma.business.update({
      where: { userId },
      data: {
        businessProofUrl: uploadResult.secure_url,
        businessProofPublicId: uploadResult.public_id,
      },
    });

    await this.prisma.user.update({
      where: { id: userId },
      data: { verificationStatus: VerificationStatus.PENDING },
    });

    return updatedBusiness;
  }

  // Admin methods
  async getAllBusinesses(page = 1, limit = 10, status?: VerificationStatus) {
    const skip = (page - 1) * limit;

    const where = status ? { user: { verificationStatus: status } } : {};

    const [data, total] = await Promise.all([
      this.prisma.business.findMany({
        where,
        skip,
        take: limit,
        include: { user: true },
        orderBy: { createdAt: 'desc' },
      }),
      this.prisma.business.count({ where }),
    ]);

    return {
      data,
      meta: {
        total,
        page,
        limit,
        totalPages: Math.ceil(total / limit),
      },
    };
  }

  async getBusinessById(id: string) {
    const business = await this.prisma.business.findUnique({
      where: { id },
      include: { user: true },
    });

    if (!business) {
      throw new NotFoundException('Business not found');
    }

    return business;
  }

  async verifyBusiness(id: string, adminId: string, status: VerificationStatus, rejectionReason?: string) {
    const business = await this.prisma.business.findUnique({
      where: { id },
    });

    if (!business) {
      throw new NotFoundException('Business not found');
    }

    const updatedBusiness = await this.prisma.business.update({
      where: { id },
      data: {
        rejectionReason: status === VerificationStatus.REJECTED ? rejectionReason : null,
        verifiedAt: status === VerificationStatus.APPROVED ? new Date() : null,
        verifiedBy: adminId,
      },
    });

    await this.prisma.user.update({
      where: { id: business.userId },
      data: { verificationStatus: status },
    });

    return updatedBusiness;
  }
}
