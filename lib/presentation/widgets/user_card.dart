// presentation/widgets/user_card.dart
import 'package:flutter/material.dart';
import 'profile_avatar.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String bio;
  final String email;
  final String? imageUrl;

  const UserCard({
    Key? key,
    required this.name,
    required this.bio,
    required this.email,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ProfileAvatar(
              name: name,
              imageUrl: imageUrl,
              size: 50,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(bio, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 4),
                  Text(email, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
