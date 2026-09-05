import { Injectable, ConflictException, UnauthorizedException, ForbiddenException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { PrismaService } from '../prisma/prisma.service';
import { RegisterDto } from './dto/register.dto';
import { LoginDto } from './dto/login.dto';
import { RefreshTokenDto } from './dto/refresh-token.dto';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwtService: JwtService,
  ) {}

  async register(registerDto: RegisterDto) {
    const { fullName, email, phone, password, confirmPassword } = registerDto;

    if (password !== confirmPassword) {
      throw new ConflictException('Passwords do not match');
    }

    const existingEmail = await this.prisma.user.findUnique({ where: { email } });
    if (existingEmail) {
      throw new ConflictException('Email already exists');
    }

    const existingPhone = await this.prisma.user.findUnique({ where: { phone } });
    if (existingPhone) {
      throw new ConflictException('Phone number already exists');
    }

    const hashedPassword = await bcrypt.hash(password, 12);

    const user = await this.prisma.user.create({
      data: {
        fullName,
        email,
        phone,
        password: hashedPassword,
      },
    });

    const tokens = await this.generateTokens(user.id, user.email, user.role);
    await this.updateRefreshToken(user.id, tokens.refreshToken);

    // Remove sensitive data before returning
    const { password: _, refreshToken: __, ...userResponse } = user;
    return {
      user: userResponse,
      ...tokens,
    };
  }

  async login(loginDto: LoginDto) {
    const { emailOrPhone, password } = loginDto;

    const user = await this.prisma.user.findFirst({
      where: {
        OR: [
          { email: emailOrPhone },
          { phone: emailOrPhone },
        ],
      },
    });

    if (!user) {
      throw new UnauthorizedException('Invalid credentials');
    }

    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
      throw new UnauthorizedException('Invalid credentials');
    }

    if (!user.isActive) {
      throw new ForbiddenException('Your account is deactivated');
    }

    const tokens = await this.generateTokens(user.id, user.email, user.role);
    await this.updateRefreshToken(user.id, tokens.refreshToken);

    // Update lastLoginAt
    await this.prisma.user.update({
      where: { id: user.id },
      data: { lastLoginAt: new Date() },
    });

    const { password: _, refreshToken: __, ...userResponse } = user;
    return {
      user: userResponse,
      ...tokens,
    };
  }

  async refreshToken(refreshTokenDto: RefreshTokenDto) {
    const { refreshToken } = refreshTokenDto;

    try {
      const payload = this.jwtService.verify(refreshToken, {
        secret: process.env.JWT_REFRESH_SECRET,
      });

      const user = await this.prisma.user.findUnique({ where: { id: payload.sub } });
      if (!user || !user.refreshToken) {
        throw new UnauthorizedException('Invalid refresh token');
      }

      const isRefreshTokenMatching = await bcrypt.compare(refreshToken, user.refreshToken);
      if (!isRefreshTokenMatching) {
        throw new UnauthorizedException('Invalid refresh token');
      }

      // Generate new access token
      const accessToken = this.jwtService.sign(
        { sub: user.id, email: user.email, role: user.role },
        { secret: process.env.JWT_ACCESS_SECRET as string, expiresIn: process.env.JWT_ACCESS_EXPIRATION as any },
      );

      return { accessToken };
    } catch (error) {
      throw new UnauthorizedException('Invalid refresh token');
    }
  }

  async logout(userId: string) {
    await this.prisma.user.update({
      where: { id: userId },
      data: { refreshToken: null },
    });

    return { message: 'Logged out successfully' };
  }

  async getProfile(userId: string) {
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
      include: { business: true },
    });

    if (!user) {
      throw new UnauthorizedException('User not found');
    }

    const { password: _, refreshToken: __, ...userResponse } = user;
    return userResponse;
  }

  // --- Helper Methods ---

  private async generateTokens(userId: string, email: string, role: string) {
    const payload = { sub: userId, email, role };

    const accessToken = this.jwtService.sign(payload, {
      secret: process.env.JWT_ACCESS_SECRET as string,
      expiresIn: process.env.JWT_ACCESS_EXPIRATION as any,
    });

    const refreshToken = this.jwtService.sign(payload, {
      secret: process.env.JWT_REFRESH_SECRET as string,
      expiresIn: process.env.JWT_REFRESH_EXPIRATION as any,
    });

    return {
      accessToken,
      refreshToken,
    };
  }

  private async updateRefreshToken(userId: string, refreshToken: string) {
    const hashedRefreshToken = await bcrypt.hash(refreshToken, 10);
    await this.prisma.user.update({
      where: { id: userId },
      data: { refreshToken: hashedRefreshToken },
    });
  }
}
