import 'dart:io'; //provides acess to file and I/O operations
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; //allow picke image fro device

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage; //store the selcted profile image as a file
  final _picker = ImagePicker(); //used to picke image

  Future<void> _pickImage() async {
    //calls when the users tap the profile picture
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    ); //open gallert for the users to select an imae=ge
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(
          pickedFile.path,
        ); //conver the file and updated ppimage using setstate which triggers uI builds
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("My Profile", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Profile Picture
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : const AssetImage("assets/images/pp.png")
                            as ImageProvider,
                  backgroundColor: Colors.grey[300],
                ),
              ),
              const SizedBox(height: 16),
              // User Name
              const Text(
                "John Doe",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              // Email
              const Text(
                "johndoe@example.com",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 20),

              // Cards Section
              _buildProfileCard(
                Icons.location_on,
                "Addresses",
                "Manage your addresses",
              ),
              const SizedBox(height: 12),
              _buildProfileCard(
                Icons.shopping_bag,
                "Orders",
                "View your order history",
              ),
              const SizedBox(height: 12),
              _buildProfileCard(
                Icons.favorite,
                "Wishlist",
                "Your favorite products",
              ),
              const SizedBox(height: 12),
              _buildProfileCard(
                Icons.logout,
                "Logout",
                "Sign out of your account",
                onTap: () {
                  // Add logout functionality
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(
    IconData icon,
    String title,
    String subtitle, {
    VoidCallback? onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap ?? () {},
      ),
    );
  }
}
