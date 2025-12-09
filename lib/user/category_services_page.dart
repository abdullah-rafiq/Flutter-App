import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/models/service.dart';
import 'package:flutter_application_1/services/service_catalog_service.dart';

import 'service_detail_page.dart';

class CategoryServicesPage extends StatelessWidget {
  final CategoryModel category;

  const CategoryServicesPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: StreamBuilder<List<ServiceModel>>(
        stream:
            ServiceCatalogService.instance.watchServicesForCategory(category.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Could not load services.'),
            );
          }

          final services = snapshot.data ?? [];

          if (services.isEmpty) {
            return const Center(
              child: Text('No services available in this category.'),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final s = services[index];
              return ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                tileColor: Colors.white,
                leading: const Icon(Icons.cleaning_services_rounded),
                title: Text(s.name),
                subtitle: Text(
                  s.description ?? 'Starting from PKR ${s.basePrice.toStringAsFixed(0)}',
                ),
                trailing: Text('PKR ${s.basePrice.toStringAsFixed(0)}'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ServiceDetailPage(service: s),
                    ),
                  );
                },
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemCount: services.length,
          );
        },
      ),
      backgroundColor: const Color(0xFFF6FBFF),
    );
  }
}
