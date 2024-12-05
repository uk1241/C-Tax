import 'package:flutter/material.dart';
import 'pos_machine_details_page.dart';

// POS Model
class POS {
  final String number;
  String name;
  final String id;
  final String date;
  String status;
  final String availability;
  bool isVerified;

  POS({
    required this.number,
    required this.name,
    required this.id,
    required this.date,
    this.status = 'Not Verified',
    required this.availability,
    this.isVerified = false,
  });
}

class AllPOSDetailsPage extends StatefulWidget {
  const AllPOSDetailsPage({super.key});

  @override
  _AllPOSDetailsPageState createState() => _AllPOSDetailsPageState();
}

class _AllPOSDetailsPageState extends State<AllPOSDetailsPage> {
  // Sample POS Data
  List<POS> posData = [
    POS(
        number: 'POS 1',
        name: 'John Doe',
        id: '-NA-',
        date: '05-12-2019',
        availability: 'Not available'),
    POS(
        number: 'POS 2',
        name: 'Emily Williams',
        id: '712547893632544785',
        date: '05-12-2019',
        availability: 'Online'),
    POS(
        number: 'POS 3',
        name: 'Adam Peter',
        id: '321144578996523415',
        date: '05-12-2019',
        availability: 'Offline'),
    POS(
        number: 'POS 4',
        name: 'Sam Peterson',
        id: '647101200400510900',
        date: '05-12-2019',
        availability: 'Online',
        status: 'Verified',
        isVerified: true),
  ];

  // List of names for the dropdown
  List<String> names = [
    'John Doe',
    'Emily Williams',
    'Adam Peter',
    'Sam Peterson',
  ];

  // Search functionality
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Filtered POS Data based on search query
    final filteredPOSData = posData.where((pos) {
      return pos.number.toLowerCase().contains(searchQuery.toLowerCase()) ||
          pos.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          pos.id.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All POS Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        // backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search POS...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          // ListView.builder for displaying POS data
          Expanded(
            child: ListView.builder(
              itemCount: filteredPOSData.length,
              itemBuilder: (context, index) {
                final pos = filteredPOSData[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: InkWell(
                    onTap: () async {
                      bool? wasVerified = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => POSMachineDetailsPage(
                            posId: pos.number,
                            isInitiallyVerified: pos.isVerified,
                            availability: pos.availability,
                            name: pos.name,
                          ),
                        ),
                      );

                      if (wasVerified == true) {
                        setState(() {
                          pos.isVerified = true;
                          pos.status = 'Verified';
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                pos.number,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                pos.date,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(pos.name),
                          const SizedBox(height: 4),
                          Text(pos.id),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Image Button for Assign POS
                              InkWell(
                                onTap: () {
                                  _showAssignPOSDialog(pos);
                                },
                                child: SizedBox(
                                  width: 66, // Adjust width as needed
                                  height: 25, // Adjust height as needed
                                  child: Center(
                                    child: Image.asset(
                                      'assets/buttons/assignButton.png', // Replace with your image path
                                      fit: BoxFit.fill
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  // Verification Status with Image
                                  InkWell(
                                    onTap: () {
                                      // You can handle tapping the verification button here
                                    },
                                    child: Image.asset(
                                      pos.isVerified
                                          ? 'assets/buttons/verifiedverifiedButton.png' // Replace with verified image
                                          : 'assets/buttons/notVerifiedButton.png', // Replace with not verified image
                                      width: 60,
                                      height: 50,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Availability Status with Image
                                  InkWell(
                                    onTap: () {
                                      // Handle availability status change here
                                    },
                                    child: Image.asset(
                                      pos.availability == 'Online'
                                          ? 'assets/buttons/online.png' // Replace with online image
                                          : 'assets/buttons/offlineButton.png', // Replace with offline image
                                      width: 60,
                                      height: 50,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAssignPOSDialog(POS pos) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? selectedName = pos.name; // Initial value

        return AlertDialog(
          title: const Text('Assign POS'),
          content: DropdownButton<String>(
            value: selectedName,
            items: names.map((name) {
              return DropdownMenuItem<String>(
                value: name,
                child: Text(name),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedName = value;
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  pos.name = selectedName ?? pos.name;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Assign'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
