import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
    required this.fullName,
    required this.email,
    required this.location,
  });

  final String fullName;
  final String email;
  final String location;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  static const Color _bg = Color(0xFFF5F5F5);
  static const Color _card = Color(0xFF0D0D0D);
  static const Color _border = Color(0xFF444444);
  static const Color _label = Color(0xFF9E9E9E);
  static const Color _accent = Color(0xFF2CB9C8); // teal/blue accent

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _locationController;

  String _userType = 'Renter';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.fullName);
    _emailController = TextEditingController(text: widget.email);
    _phoneController = TextEditingController();
    _locationController = TextEditingController(text: widget.location);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  InputDecoration _decoration({required String label, Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: _label),
      filled: false,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _border, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _accent, width: 1),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _border, width: 1),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      suffixIcon: suffixIcon,
    );
  }

  void _save() {
    FocusManager.instance.primaryFocus?.unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Saved (demo)'),
        duration: Duration(seconds: 1),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black87),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          tooltip: 'Back',
        ),
        actions: [
          TextButton(
            onPressed: _save,
            child: const Text(
              'Save',
              style: TextStyle(
                color: _accent,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Dark form card
              Padding(
                padding: const EdgeInsets.only(top: 34),
                child: Container(
                  decoration: BoxDecoration(
                    color: _card,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 52, 16, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: _nameController,
                        style: const TextStyle(color: Colors.white, fontSize: 15),
                        cursorColor: _accent,
                        decoration: _decoration(label: 'Your Full Name'),
                      ),
                      const SizedBox(height: 18),

                      TextField(
                        controller: _emailController,
                        enabled: false,
                        style: const TextStyle(color: Colors.white70, fontSize: 15),
                        decoration: _decoration(label: 'Email'),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'You can edit your email from our website using a desktop or laptop computer',
                        style: TextStyle(color: _label, fontSize: 12, height: 1.3),
                      ),
                      const SizedBox(height: 18),

                      SizedBox(
                        height: 46,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: _accent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Change Password (demo)'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          child: const Text(
                            'Change Password',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),

                      TextField(
                        controller: _phoneController,
                        style: const TextStyle(color: Colors.white, fontSize: 15),
                        cursorColor: _accent,
                        keyboardType: TextInputType.phone,
                        decoration: _decoration(label: 'Your Phone Number'),
                      ),
                      const SizedBox(height: 18),

                      DropdownButtonFormField<String>(
                        initialValue: _userType,
                        dropdownColor: const Color(0xFF1A1A1A),
                        icon: const Icon(Icons.keyboard_arrow_down, color: _label),
                        decoration: _decoration(label: 'User Type'),
                        style: const TextStyle(color: Colors.white, fontSize: 15),
                        items: const [
                          DropdownMenuItem(value: 'Renter', child: Text('Renter')),
                          DropdownMenuItem(value: 'Landlord', child: Text('Landlord')),
                          DropdownMenuItem(value: 'Agent', child: Text('Agent')),
                        ],
                        onChanged: (v) {
                          if (v == null) return;
                          setState(() => _userType = v);
                        },
                      ),
                      const SizedBox(height: 18),

                      TextField(
                        controller: _locationController,
                        style: const TextStyle(color: Colors.white, fontSize: 15),
                        cursorColor: _accent,
                        decoration: _decoration(label: 'Your Location'),
                      ),
                    ],
                  ),
                ),
              ),

              // Floating avatar
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Center(
                  child: Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E0E0),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      color: Colors.black54,
                      size: 34,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

