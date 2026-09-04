import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/status_badge.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_text_styles.dart';

class VerificationPendingScreen extends StatefulWidget {
  const VerificationPendingScreen({super.key});

  @override
  State<VerificationPendingScreen> createState() => _VerificationPendingScreenState();
}

class _VerificationPendingScreenState extends State<VerificationPendingScreen> {
  Future<void> _refreshStatus() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.checkAuthStatus();
    
    if (!mounted) return;
    
    if (authProvider.user?.verificationStatus == 'APPROVED') {
      context.go('/home');
    }
  }

  Future<void> _logout() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.logout();
    if (!mounted) return;
    context.go('/welcome');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Status'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.error),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          final user = authProvider.user;
          final status = user?.verificationStatus ?? 'PENDING';
          
          String message = 'Your account is under verification. You will be notified once approved.';
          IconData icon = Icons.pending_actions_rounded;
          Color iconColor = AppColors.warning;
          
          if (status == 'REJECTED') {
            message = 'Your verification was rejected. Please contact support to resolve the issue.';
            icon = Icons.cancel_outlined;
            iconColor = AppColors.error;
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  
                  Icon(
                    icon,
                    size: 100,
                    color: iconColor,
                  ),
                  const SizedBox(height: 32),
                  
                  Text(
                    status == 'REJECTED' ? 'Verification Rejected' : 'Verification Pending',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.h2,
                  ),
                  const SizedBox(height: 16),
                  
                  StatusBadge(status: status),
                  
                  const SizedBox(height: 24),
                  
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body1.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  
                  const Spacer(),
                  
                  CustomButton(
                    text: 'Refresh Status',
                    onPressed: _refreshStatus,
                    icon: Icons.refresh,
                  ),
                  const SizedBox(height: 16),
                  
                  TextButton(
                    onPressed: _logout,
                    child: Text(
                      'Logout',
                      style: AppTextStyles.body1.copyWith(
                        color: AppColors.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
