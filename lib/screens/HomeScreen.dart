import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd MMM yyyy').format(DateTime.now());
    String userName = 'Admin';
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tailor Managment - $formattedDate',
              style: TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                Text(
                  userName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => _showLogoutDialog(context),
                  icon: Icon(Icons.logout),
                ),
              ],
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 100.0), // Balanced padding
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Keeps buttons centered
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHomeButton(context, 'Customers', LucideIcons.users, Colors.blue, '/customers'),
              const SizedBox(height: 15),
              _buildHomeButton(context, 'Orders', LucideIcons.receipt, Colors.red, '/orders'),
              const SizedBox(height: 15),
              _buildHomeButton(context, 'Products', LucideIcons.box, Colors.orange, '/products'),
              const SizedBox(height: 15),
              _buildHomeButton(context, 'Whatsapp', LucideIcons.messageCircle, Colors.green, '/products'),
              const SizedBox(height: 15),
              _buildHomeButton(context, 'Reports', LucideIcons.chartPie, Colors.purple, '/reports'),
              const SizedBox(height: 15),
              _buildHomeButton(context, 'Settings', LucideIcons.settings, Colors.grey, '/settings'),
            ],
          ),
        ),
      ),

    );
  }

  Widget _buildHomeButton(
      BuildContext context,
      String title,
      IconData icon,
      Color color,
      String route,
      ) {
    return SizedBox(
      width: 300,
      height: 60,
      child: MouseRegion(
        cursor: SystemMouseCursors.click, // Change cursor on hover
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            elevation: 5, // Adds shadow effect
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ).copyWith(
            backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                  (states) {
                if (states.contains(WidgetState.hovered)) {
                  return color.withOpacity(0.8); // Change color on hover
                }
                return color;
              },
            ),
          ),
          onPressed: () => Navigator.pushNamed(context, route),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Better alignment
            children: [
              Icon(icon, size: 30,color: Colors.white,),
              const SizedBox(width: 15),
              Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }


  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {},
              child: Text("Logout", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
