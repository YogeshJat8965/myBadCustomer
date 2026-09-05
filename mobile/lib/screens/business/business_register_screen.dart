import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/business_provider.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../utils/validators.dart';
import '../../config/theme/app_colors.dart';

class BusinessRegisterScreen extends StatefulWidget {
  const BusinessRegisterScreen({super.key});

  @override
  State<BusinessRegisterScreen> createState() => _BusinessRegisterScreenState();
}

class _BusinessRegisterScreenState extends State<BusinessRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _businessNameController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _gstController = TextEditingController();
  final _panController = TextEditingController();
  final _infoController = TextEditingController();

  String _businessType = 'RETAIL';
  File? _proofFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _businessNameController.dispose();
    _ownerNameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pincodeController.dispose();
    _gstController.dispose();
    _panController.dispose();
    _infoController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _proofFile = File(image.path);
      });
    }
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<BusinessProvider>(context, listen: false);

      final data = {
        'businessName': _businessNameController.text,
        'businessType': _businessType,
        'ownerName': _ownerNameController.text,
        'address': _addressController.text,
        'city': _cityController.text,
        'state': _stateController.text,
        'pincode': _pincodeController.text,
        'gstNumber': _gstController.text.isEmpty ? null : _gstController.text,
        'panNumber': _panController.text.isEmpty ? null : _panController.text,
        'additionalInfo': _infoController.text.isEmpty ? null : _infoController.text,
      };

      final success = await provider.registerBusiness(data, _proofFile);
      if (success && mounted) {
        Navigator.pushReplacementNamed(context, '/verification-pending');
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(provider.error ?? 'Registration failed')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Business'),
      ),
      body: Consumer<BusinessProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Business Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _businessNameController,
                    label: 'Business Name',
                    validator: (v) => Validators.validateRequired(v, 'Business Name'),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _businessType,
                    decoration: const InputDecoration(labelText: 'Business Type'),
                    items: ['RETAIL', 'WHOLESALE', 'SERVICE', 'AGRICULTURE', 'TRADING', 'MANUFACTURING', 'OTHER']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => setState(() => _businessType = v!),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _ownerNameController,
                    label: 'Owner Name',
                    validator: (v) => Validators.validateRequired(v, 'Owner Name'),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Address Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _addressController,
                    label: 'Address',
                    maxLines: 3,
                    validator: (v) => Validators.validateRequired(v, 'Address'),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _cityController,
                    label: 'City',
                    validator: (v) => Validators.validateRequired(v, 'City'),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _stateController,
                    label: 'State',
                    validator: (v) => Validators.validateRequired(v, 'State'),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _pincodeController,
                    label: 'Pincode',
                    keyboardType: TextInputType.number,
                    validator: (v) => Validators.validatePhone(v), // Reuse 6-digit validation if exists or simple check
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Documents (Optional)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _gstController,
                    label: 'GST Number',
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _panController,
                    label: 'PAN Number',
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Business Proof',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('Upload a document (Trade License, GST, etc.)'),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: _pickImage,
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _proofFile == null
                          ? const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.cloud_upload, size: 48, color: Colors.grey),
                                Text('Tap to upload proof'),
                              ],
                            )
                          : Image.file(_proofFile!, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                    text: 'Submit for Verification',
                    isLoading: provider.isLoading,
                    onPressed: _submit,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
