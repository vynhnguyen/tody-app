import 'package:flutter/material.dart';

class MyProfileScreen extends StatelessWidget {
  // Sample user data (this could come from a user model or API)
  final String profileImageUrl = 'https://via.placeholder.com/150';
  final String name = 'John Doe';
  final String email = 'john.doe@example.com';
  final String bio =
      'Flutter developer with a passion for creating beautiful and functional user experiences.';

  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile picture
            // CircleAvatar(
            //   radius: 60,
            //   backgroundImage: NetworkImage(profileImageUrl),
            // ),
            ClipRRect(
              borderRadius: BorderRadius.circular(128),
              child: Image.asset(
                'assets/img/avatar-1.png',
                width: 128,
                height: 128,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            // Name
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Email
            Text(
              email,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),

            // Bio
            Text(
              bio,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 24),

            // Edit Profile Button
            TextButton(
              onPressed: () {
                // Handle edit profile button press
              },
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
