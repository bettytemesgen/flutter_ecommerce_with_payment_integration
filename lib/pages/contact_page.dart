import 'package:flutter/material.dart';

// Contact Page Widget
class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  // Global key to validate the form
  final _formKey = GlobalKey<FormState>();

  // Text controllers for the input fields
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to free memory
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // Submit button logic
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Show success message in a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Message sent successfully"),
          backgroundColor: Colors.deepPurple,
        ),
      );

      // Clear form fields
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background for contrast
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text("Contact Us"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Page padding
          child: Column(
            children: [
              // 🟣 Header Card with gradient background
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.deepPurple, Colors.purpleAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: const [
                      Icon(Icons.support_agent, size: 60, color: Colors.white),
                      SizedBox(height: 12),
                      Text(
                        "We’d love to hear from you!",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Fill out the form below and we’ll get back to you soon.",
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // 📝 Contact Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Name Field
                    _buildTextField(
                      controller: _nameController,
                      label: "Name",
                      icon: Icons.person,
                      validator: (value) => value == null || value.isEmpty
                          ? "Please enter your name"
                          : null,
                    ),
                    const SizedBox(height: 16),

                    // Email Field
                    _buildTextField(
                      controller: _emailController,
                      label: "Email",
                      icon: Icons.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }
                        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                        if (!emailRegex.hasMatch(value)) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Message Field
                    _buildTextField(
                      controller: _messageController,
                      label: "Message",
                      icon: Icons.message,
                      maxLines: 4,
                      validator: (value) => value == null || value.isEmpty
                          ? "Please enter your message"
                          : null,
                    ),
                    const SizedBox(height: 24),

                    // Send Button
                    ElevatedButton.icon(
                      // icon: const Icon(Icons.send, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 18,
                        ),
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      onPressed: _submitForm,
                      label: const Text(
                        "Send Message",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // 📌 Quick Contact Info Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ListTile(
                    leading: Icon(Icons.phone, color: Colors.deepPurple),
                    title: Text("Phone"),
                    subtitle: Text("+251 910015422"),
                  ),
                  ListTile(
                    leading: Icon(Icons.email, color: Colors.deepPurple),
                    title: Text("Email"),
                    subtitle: Text("support@yourecommerce.com"),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on, color: Colors.deepPurple),
                    title: Text("Address"),
                    subtitle: Text("Addis Ababa, Ethiopia"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable TextField Builder (to reduce duplicate code)
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator,
      maxLines: maxLines,
    );
  }
}
