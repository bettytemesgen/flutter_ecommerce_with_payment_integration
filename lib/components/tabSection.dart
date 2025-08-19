import 'package:flutter/material.dart';

class Tabsection extends StatefulWidget {
  const Tabsection({super.key});

  @override
  State<Tabsection> createState() => _TabsectionState();
}

// Add SingleTickerProviderStateMixin to provide 'vsync' for animations like TabController
class _TabsectionState extends State<Tabsection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController; // Controller to manage tab navigation

  @override
  void initState() {
    super.initState(); // Call parent's initState first
    // Initialize TabController with 3 tabs and this state as the vsync provider
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // Dispose the controller to free resources when widget is removed
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // The tabs shown on top
        TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          indicatorColor: Colors.blue,
          tabs: const [
            Tab(text: "Mission"),
            Tab(text: "Vision"),
            Tab(text: "Value"),
          ],
        ),
        // The content below tabs that changes when tab is switched
        SizedBox(
          height: 150,
          child: TabBarView(
            controller: _tabController,
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Our mission is to provide the best e-commerce experience.",
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Our vision is to be the most customer-centric store.",
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Our values are honesty, integrity, and quality."),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
