import 'package:clucker_client/navigation/main_navigation_bar.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {

  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clucker Test Screen')
      ),
      body: Center(
        child: Column(
          children: const [
            Text('Test Text')
          ],
        ),
      ),
      bottomNavigationBar: const MainNavigationBar(),
      floatingActionButton: FloatingActionButton(onPressed: () => {}, child: const Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

}
