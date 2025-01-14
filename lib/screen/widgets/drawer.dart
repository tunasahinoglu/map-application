import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  final String currentPlaceName;
  final String currentPlaceDescription;
  final String currentImagePath;
  final VoidCallback onReturnHome;

  const DrawerWidget({
    super.key,
    required this.currentPlaceName,
    required this.currentPlaceDescription,
    required this.currentImagePath,
    required this.onReturnHome,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 500,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 250.0,
            child: Image.asset(
              currentImagePath,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          ListTile(
            title: Text(
              currentPlaceName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(currentPlaceDescription),
          ),
          ListTile(
            title: const Text('Ana görünüme dön'),
            leading: const Icon(Icons.home),
            onTap: onReturnHome,
          ),
        ],
      ),
    );
  }
}
