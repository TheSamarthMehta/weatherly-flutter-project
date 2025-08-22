// lib/views/widgets/persistent_header.dart

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PersistentHeader extends StatelessWidget implements PreferredSizeWidget {
  final String cityName;

  const PersistentHeader({super.key, required this.cityName});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF121212),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Top Row: App Name & Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(PhosphorIcons.cloud(PhosphorIconsStyle.fill), color: const Color(0xFF00C3FF), size: 32),
                      const SizedBox(width: 8),
                      const Text(
                        'Weatherly',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(PhosphorIcons.user(PhosphorIconsStyle.regular),
                              color: Colors.white, size: 28),
                          onPressed: () {}),
                      IconButton(
                          icon: Icon(PhosphorIcons.list(PhosphorIconsStyle.regular),
                              color: Colors.white, size: 28),
                          onPressed: () {}),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Bottom Row: Location Bar
              Container(
                height: 46,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B1B1D),
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(color: Colors.grey[800]!, width: 1),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on_outlined, color: Colors.white70, size: 20),
                    const SizedBox(width: 12),
                    Text(cityName,
                        style: const TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(130);
}