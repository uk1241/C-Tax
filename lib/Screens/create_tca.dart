import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateTCAPage extends StatefulWidget {
  final Function(Map<String, String>) onTCACreated;

  const CreateTCAPage({
    super.key,
    required this.onTCACreated,
  });

  @override
  _CreateTCAPageState createState() => _CreateTCAPageState();
}

class _CreateTCAPageState extends State<CreateTCAPage> {
  final TextEditingController _agentNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _localityController = TextEditingController();
  final TextEditingController _posIdController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<Uint8List> photoArray = [];

  @override
  void dispose() {
    _agentNameController.dispose();
    _phoneNumberController.dispose();
    _localityController.dispose();
    _posIdController.dispose();
    super.dispose();
  }

  Future<void> _uploadPhoto() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        Uint8List imageBytes = await File(pickedFile.path).readAsBytes();
        setState(() {
          photoArray.add(imageBytes);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _uploadDocumentPhoto() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        Uint8List imageBytes = await File(pickedFile.path).readAsBytes();
        setState(() {
          photoArray.add(imageBytes);
        });
      }
    } catch (e) {
      print('Error picking document image: $e');
    }
  }

 void _createTCA() {
  final tcaData = {
    'agentName': _agentNameController.text,
    'phoneNumber': _phoneNumberController.text,
    'locality': _localityController.text,
    'posId': _posIdController.text,
    'status': 'Waiting For Approval',
    'date': DateTime.now().toString().split(' ')[0],  // Make sure it's a string
  };

  // Ensure that every value in the map is a string
  final Map<String, String> stringTCAData = tcaData.map((key, value) => MapEntry(key, value.toString()));

  widget.onTCACreated(stringTCAData);  // This now passes Map<String, String>
  
  // Clear the form
  _agentNameController.clear();
  _phoneNumberController.clear();
  _localityController.clear();
  _posIdController.clear();
  setState(() {
    photoArray.clear();
  });

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('TCA created successfully')),
  );
}



  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildButton({required String text, required VoidCallback onPressed}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: const Color(0xFF26A69A),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildTextField(
            controller: _agentNameController,
            label: 'Agent Name',
            icon: Icons.person_outline,
          ),
          _buildTextField(
            controller: _phoneNumberController,
            label: 'Phone Number',
            icon: Icons.phone_outlined,
          ),
          _buildTextField(
            controller: _localityController,
            label: 'Locality',
            icon: Icons.home_outlined,
          ),
          _buildTextField(
            controller: _posIdController,
            label: 'POS ID',
            icon: Icons.credit_card_outlined,
          ),
          const SizedBox(height: 16),
          _buildButton(text: 'Upload Photo', onPressed: _uploadPhoto),
          _buildButton(text: 'Upload Document', onPressed: _uploadDocumentPhoto),
          _buildButton(text: 'Create', onPressed: _createTCA),
        ],
      ),
    );
  }
}