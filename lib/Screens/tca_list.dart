import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'tca_detail_page.dart'; // Import the TCA Detail Page

class TCAListPage extends StatelessWidget {
  final List<Map<String, dynamic>> tcaList;

  const TCAListPage({super.key, required this.tcaList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TCA List',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: tcaList.isEmpty
                ? const Center(child: Text('No TCAs created yet'))
                : ListView.builder(
                    itemCount: tcaList.length,
                    itemBuilder: (context, index) {
                      final tca = tcaList[index];
                      return GestureDetector(
                        onTap: () {
                          // Navigate to TCA Detail Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TCADetailPage(tca: tca), // Pass the selected TCA data
                            ),
                          );
                        },
                        child: _buildListItem(context, tca),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by TCA name or ID',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey.shade600),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () {
              // Implement filter functionality
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, Map<String, dynamic> tca) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tca['agentName'] ?? '',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat('dd-MM-yyyy').format(DateTime.parse(tca['date'])),
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(tca['locality'] ?? '', style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('POS ID : ${tca['posId'] ?? '-NA-'}'),
                _buildStatusIndicator(tca['status'] ?? ''),
              ],
            ),
            if (tca['posId'] == '-NA-')
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Implement assign POS functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Assign POS'),
                ),
              ),
          ],
        ),
      ),
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
}
