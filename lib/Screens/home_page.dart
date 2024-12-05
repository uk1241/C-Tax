// import 'package:flutter/material.dart';

// class HomePage extends StatelessWidget {
//   void _viewPosDetails(BuildContext context) {
//     Navigator.pushNamed(context, '/posDetails');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 // Implement logic for the first button or leave as a placeholder
//               },
//               child: const Text('Create TCA'),
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 15.0),
//                 backgroundColor: const Color.fromARGB(255, 201, 201, 212),
//                 textStyle: const TextStyle(fontSize: 18),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: () => _viewPosDetails(context),
//               child: const Text('View Pos Details'),
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 15.0),
//                 backgroundColor: const Color.fromARGB(255, 193, 195, 223),
//                 textStyle: const TextStyle(fontSize: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PosDetailsPage extends StatelessWidget {
//   // Dummy data for the list of POS details
//   final List<Map<String, String>> posDetails = [
//     {
//       'posId': 'POS001',
//       'agentName': 'Agent A',
//       'location': 'Location A',
//       'status': 'machine is active',
//     },
//     {
//       'posId': 'POS002',
//       'agentName': 'Agent B',
//       'location': 'Location B',
//       'status': 'machine is inactive',
//     },
//     {
//       'posId': 'POS003',
//       'agentName': 'Agent C',
//       'location': 'Location C',
//       'status': 'machine is active',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('POS Details'),
//       ),
//       body: ListView.builder(
//         padding: EdgeInsets.all(20.0),
//         itemCount: posDetails.length,
//         itemBuilder: (context, index) {
//           final pos = posDetails[index];
//           return Card(
//             margin: EdgeInsets.only(bottom: 20.0),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             elevation: 4,
//             child: Padding(
//               padding: EdgeInsets.all(15.0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Icon(
//                     Icons.credit_card,
//                     size: 50.0,
//                     color: Colors.grey,
//                   ),
//                   SizedBox(width: 20.0),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           pos['posId']!,
//                           style: TextStyle(
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blue,
//                           ),
//                         ),
//                         SizedBox(height: 10.0),
//                         Text(
//                           '${pos['agentName']}',
//                           style: TextStyle(fontSize: 16.0),
//                         ),
//                         Text(
//                           '${pos['location']}',
//                           style: TextStyle(fontSize: 16.0),
//                         ),
//                         SizedBox(height: 10.0),
//                         Row(
//                           children: <Widget>[
//                             Icon(
//                               pos['status'] == 'machine is active'
//                                   ? Icons.check_circle
//                                   : Icons.error,
//                               color: pos['status'] == 'machine is active'
//                                   ? Colors.green
//                                   : Colors.red,
//                             ),
//                             SizedBox(width: 10.0),
//                             Text(
//                               pos['status']!,
//                               style: TextStyle(
//                                 fontSize: 16.0,
//                                 color: pos['status'] == 'machine is active'
//                                     ? Colors.green
//                                     : Colors.red,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
