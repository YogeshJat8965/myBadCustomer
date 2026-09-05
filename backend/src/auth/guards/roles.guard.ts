import { Injectable, CanActivate, ExecutionContext, ForbiddenException } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { Role } from '../../common/enums/prisma-enums';

export const ROLES_KEY = 'roles';
export const Roles = (...roles: Role[]) => {
  return (target: any, key?: string | symbol, descriptor?: TypedPropertyDescriptor<any>) => {
    if (key) {
      Reflector.createDecorator<Role[]>()(roles)(target, key, descriptor!);
    } else {
      Reflector.createDecorator<Role[]>()(roles)(target);
    }
  };
};

@Injectable()
export class RolesGuard implements CanActivate {
  constructor(private reflector: Reflector) {}

  canActivate(context: ExecutionContext): boolean {
    // We get the roles from the handler or the class
    const requiredRoles = this.reflector.getAllAndOverride<Role[]>(ROLES_KEY, [
      context.getHandler(),
      context.getClass(),
    ]);
    
    if (!requiredRoles) {
      return true; // No roles restricted
    }
    
    const { user } = context.switchToHttp().getRequest();
    
    if (!user) {
      throw new ForbiddenException('User is not authenticated');
    }
    
    const hasRole = requiredRoles.some((role) => user.role === role);
    
    if (!hasRole) {
      throw new ForbiddenException('You do not have permission (Role) to access this resource');
    }
    
    return true;
  }
}
