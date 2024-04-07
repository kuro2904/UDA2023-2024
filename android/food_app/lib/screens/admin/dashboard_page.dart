import 'package:flutter/material.dart';
import 'package:food_app/screens/admin/category_management/category_management_page.dart';
import 'package:food_app/screens/admin/delivery_men_management/delivery_men_management_page.dart';
import 'package:food_app/screens/admin/discount_management/discount_management_page.dart';
import 'package:food_app/screens/admin/product_management/product_management_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Admin Page',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            _buildDashboardItem(
              context,
              Icons.category,
              'Category',
              const CategoryPage(),
            ),
            _buildDashboardItem(
              context,
              Icons.set_meal,
              'Product',
              const ProductPage(),
            ),
            _buildDashboardItem(
              context,
              Icons.person,
              'Delivery Men',
              const DeliveryMenPage(),
            ),
            _buildDashboardItem(
              context,
              Icons.discount,
              'Discount',
              const DiscountPage(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardItem(
    BuildContext context,
    IconData icon,
    String label,
    Widget destination,
  ) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orangeAccent,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40.0,
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
