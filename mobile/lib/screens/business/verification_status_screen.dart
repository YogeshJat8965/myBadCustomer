import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/business_provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/user_model.dart';
import '../../config/theme/app_colors.dart';
import '../../widgets/common/custom_button.dart';

class VerificationStatusScreen extends StatefulWidget {
  const VerificationStatusScreen({super.key});

  @override
  State<VerificationStatusScreen> createState() => _VerificationStatusScreenState();
}

class _VerificationStatusScreenState extends State<VerificationStatusScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
      Provider.of<BusinessProvider>(context, listen: false).fetchMyBusiness()
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final businessProvider = Provider.of<BusinessProvider>(context);
    final status = authProvider.user?.verificationStatus ?? 'PENDING';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification Status'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              authProvider.checkAuthStatus();
              businessProvider.fetchMyBusiness();
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStatusIcon(status),
              const SizedBox(height: 24),
              Text(
                _getStatusTitle(status),
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                _getStatusDescription(status),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              if (status == 'REJECTED' && businessProvider.business?.rejectionReason != null) ...[
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Reason for Rejection:',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                      const SizedBox(height: 8),
                      Text(businessProvider.business!.rejectionReason!),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 40),
              if (status == 'REJECTED')
                CustomButton(
                  text: 'Update Business Profile',
                  onPressed: () {
                    // Navigate to update screen (can reuse register screen with initial data)
                  },
                ),
              if (status == 'APPROVED')
                CustomButton(
                  text: 'Go to Dashboard',
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                ),
              TextButton(
                onPressed: () => authProvider.logout(),
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon(String status) {
    switch (status) {
      case 'APPROVED':
        return const Icon(Icons.check_circle, size: 80, color: Colors.green);
      case 'REJECTED':
        return const Icon(Icons.error, size: 80, color: Colors.red);
      case 'PENDING':
      case 'UNDER_REVIEW':
      default:
        return const Icon(Icons.hourglass_empty, size: 80, color: Colors.orange);
    }
  }

  String _getStatusTitle(String status) {
    switch (status) {
      case 'APPROVED': return 'Account Verified';
      case 'REJECTED': return 'Verification Failed';
      case 'PENDING': return 'Verification Pending';
      case 'UNDER_REVIEW': return 'Under Review';
      default: return 'Processing';
    }
  }

  String _getStatusDescription(String status) {
    switch (status) {
      case 'APPROVED': return 'Your business profile has been verified. You can now start reporting bad customers.';
      case 'REJECTED': return 'We could not verify your business profile based on the information provided.';
      case 'PENDING': return 'Your business profile is submitted and waiting for review by our team.';
      case 'UNDER_REVIEW': return 'Our team is currently reviewing your business documents. This usually takes 24-48 hours.';
      default: return 'We are processing your application.';
    }
  }
}
