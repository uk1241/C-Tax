import 'package:flutter/material.dart';

class POSMachineDetailsPage extends StatefulWidget {
  final String posId;
  final bool isInitiallyVerified;
  final String availability;
  final String name;

  const POSMachineDetailsPage({
    super.key,
    required this.posId,
    required this.isInitiallyVerified,
    required this.availability,
    required this.name,
  });

  @override
  _POSMachineDetailsPageState createState() => _POSMachineDetailsPageState();
}

class _POSMachineDetailsPageState extends State<POSMachineDetailsPage> {
  late bool isVerified;
  late String availability;
  late String name;
  String amountCollected = '1420';

  @override
  void initState() {
    super.initState();
    isVerified = widget.isInitiallyVerified;
    availability = widget.availability;
    name = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POS Machine Details'),
        shadowColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.posId,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(name),
            const SizedBox(height: 16),
            Row(
              children: [
                // Image for Verified/Not Verified
                Image.asset(
                  isVerified
                      ? 'assets/buttons/verifiedverifiedButton.png' // Path to verified image
                      : 'assets/buttons/notVerifiedButton.png', // Path to not verified image
                  width: 70,
                  height: 50,
                ),
                const SizedBox(width: 5),
                // Image for Availability
                Image.asset(
                  availability == 'Online'
                      ? 'assets/buttons/online.png' // Path to online image
                      : 'assets/buttons/offlineButton.png', // Path to offline image
                  width: 70,
                  height: 50,
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildInfoRow(Icons.person, 'Agent Name', name),
            _buildInfoRow(Icons.perm_identity, 'Agent ID', 'GPR214577456'),
            _buildInfoRow(Icons.calendar_today, 'Assigned Date', '12-12-2023'),
            _buildInfoRow(Icons.location_city, 'Locality', 'Manchester'),
            _buildInfoRow(Icons.phone, 'Agent Phone Number', '08123456888'),
            _buildInfoRow(Icons.attach_money, 'Amount Collected',
                '$amountCollected\$'),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _verifyTaxCollected,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  backgroundColor: isVerified ? Colors.white : Colors.teal,
                  side: BorderSide(
                    color: isVerified ? Colors.lightBlue : Colors.transparent,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  isVerified ? 'Verified' : 'Verify Tax Collected',
                  style: TextStyle(
                    color: isVerified ? Colors.lightBlue : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.grey)),
              Text(value, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }

  void _verifyTaxCollected() {
    setState(() {
      isVerified = true;
      amountCollected =
          (double.parse(amountCollected) * 1.1).toStringAsFixed(2);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tax collection verified and updated')),
    );
    Navigator.pop(context, isVerified);
  }
}
