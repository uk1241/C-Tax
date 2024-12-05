import 'package:flutter/material.dart';
import 'package:c_tax/Screens/all_pos_details_page.dart';
import 'package:c_tax/Screens/create_tca.dart';
import 'package:c_tax/Screens/tca_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> tcaList = [];

  void _onTCACreated(Map<String, String> newTCA) {
    setState(() {
      tcaList.add(newTCA);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(  // Use SafeArea to prevent overlap with system UI
          child: Column(
            children: [
              // TabBar without AppBar
              const PreferredSize(
                preferredSize: Size.fromHeight(50.0),
                child: TabBar(
                  indicatorColor: Colors.teal,
                  tabs: [
                    Tab(text: 'Create TCA'),
                    Tab(text: 'POS Details'),
                    Tab(text: 'TCA List')
                  ],
                ),
              ),
              // TabBarView content
              Expanded(
                child: TabBarView(
                  children: [
                    // First Tab - Create TCA
                    CreateTCAPage(onTCACreated: _onTCACreated),
                    // Second Tab - POS Details
                    const AllPOSDetailsPage(),
                    // Third Tab - TCA List
                    TCAListPage(tcaList: tcaList),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
