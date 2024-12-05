import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TCADetailPage extends StatefulWidget {
  final Map<String, dynamic> tca;

  const TCADetailPage({super.key, required this.tca});

  @override
  _TCADetailPageState createState() => _TCADetailPageState();
}

class _TCADetailPageState extends State<TCADetailPage> {
  late Map<String, dynamic> tcaData;

  @override
  void initState() {
    super.initState();
    tcaData = widget.tca;  // Initialize tcaData from widget.tca
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildImageSection(String label, List<Uint8List> photos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label:",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          children: photos
              .map((photo) => Image.memory(
                    photo,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildStatusIndicator(String status) {
    Color statusColor;
    if (status == 'Online') {
      statusColor = Colors.green;
    } else if (status == 'Offline') {
      statusColor = Colors.red;
    } else {
      statusColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: statusColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(color: statusColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final photos = tcaData['photos'] ?? <Uint8List>[];
    final documents = tcaData['documents'] ?? <Uint8List>[];

    return Scaffold(
      appBar: AppBar(
        title: Text("Details of ${tcaData['agentName']}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildDetailItem("Agent Name", tcaData['agentName']),
            _buildDetailItem("Phone Number", tcaData['phoneNumber']),
            _buildDetailItem("Locality", tcaData['locality']),
            _buildDetailItem("POS ID", tcaData['posId']),
            _buildDetailItem("Date", DateFormat('dd-MM-yyyy').format(DateTime.parse(tcaData['date']))),
            const SizedBox(height: 16),
            _buildStatusIndicator(tcaData['status']),
            const SizedBox(height: 16),
            if (photos.isNotEmpty) _buildImageSection('Photos', photos),
            const SizedBox(height: 16),
            if (documents.isNotEmpty) _buildImageSection('Documents', documents),
          ],
        ),
      ),
    );
  }
}
