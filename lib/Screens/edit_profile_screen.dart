import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import '../FireBase/account_service.dart';
import '../Bloc_Cubit/AuthCubit/auth_cubit.dart';

class EditProfileScreen extends StatefulWidget {
  final String initialUsername;

  const EditProfileScreen({
    super.key,
    required this.initialUsername,
  });

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String _selectedAvatarPath = 'assets/profile_icon/default_avatar.png';
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  String? _errorMessage;

  final AccountService _accountService = AccountService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<String> _avatarPaths = [];

  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.initialUsername;

    // Load available avatar paths
    _loadAvatarPaths();

    // Get user's current avatar path if available
    _loadCurrentAvatarPath();
  }

  void _loadAvatarPaths() {
    // In a real app, you might want to dynamically load these from a directory
    // For now, we'll hardcode some example paths
    _avatarPaths = [
      'assets/profile_icon/default_avatar.png',
      'assets/profile_icon/avatar1.png',
      'assets/profile_icon/avatar2.png',
      'assets/profile_icon/avatar3.png',
      'assets/profile_icon/avatar4.png',
      'assets/profile_icon/avatar5.png',
      'assets/profile_icon/avatar6.png',
      'assets/profile_icon/avatar7.png',
      'assets/profile_icon/avatar8.png',
      'assets/profile_icon/avatar9.png',
      'assets/profile_icon/avatar10.png',
    ];
  }

  Future<void> _loadCurrentAvatarPath() async {
    final User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      try {
        String? avatarPath = await _accountService.getUserAvatarPath(currentUser.uid);
        if (avatarPath != null && avatarPath.isNotEmpty) {
          setState(() {
            _selectedAvatarPath = avatarPath;
          });
        }
      } catch (e) {
        print('Error loading avatar path: $e');
      }
    }
  }

  Future<void> _saveChanges() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'User not authenticated';
      });
      return;
    }

    try {
      // Handle username update
      final String newUsername = _usernameController.text.trim();
      if (newUsername.isNotEmpty && newUsername != widget.initialUsername) {
        await _accountService.updateUsername(currentUser.uid, newUsername);
      }

      // Handle password update
      final String newPassword = _passwordController.text;
      final String confirmPassword = _confirmPasswordController.text;

      if (newPassword.isNotEmpty) {
        if (newPassword != confirmPassword) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Passwords do not match'.tr();
          });
          return;
        }

        if (newPassword.length < 6) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Password must be at least 6 characters'.tr();
          });
          return;
        }

        await currentUser.updatePassword(newPassword);
      }

      // Update avatar path
      await _accountService.updateUserAvatarPath(currentUser.uid, _selectedAvatarPath);

      // Update AuthCubit to reflect changes
      final authCubit = context.read<AuthCubit>();
      authCubit.checkAuthStatus(context);

      setState(() {
        _isLoading = false;
      });

      // Show success and go back
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully'.tr())),
      );
      Navigator.of(context).pop();

    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error updating profile: ${e.toString()}';
      });
      print('Error updating profile: $e');
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
        elevation: 0,
        title: Text(
          'Edit Profile'.tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatarSection(theme),
              SizedBox(height: 24),
              _buildUsernameSection(theme),
              SizedBox(height: 24),
              _buildPasswordSection(theme),
              SizedBox(height: 24),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Save Changes'.tr(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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

  Widget _buildAvatarSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profile Picture'.tr(),
          style: TextStyle(
            color: theme.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Center(
          child: CircleAvatar(
            backgroundColor: theme.primaryColor.withOpacity(0.1),
            radius: 50,
            backgroundImage: AssetImage(_selectedAvatarPath),
          ),
        ),
        SizedBox(height: 16),
        Container(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _avatarPaths.length,
            itemBuilder: (context, index) {
              final path = _avatarPaths[index];
              final isSelected = path == _selectedAvatarPath;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedAvatarPath = path;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: isSelected
                        ? Border.all(color: theme.primaryColor, width: 3)
                        : null,
                  ),
                  child: CircleAvatar(
                    backgroundColor: theme.primaryColor.withOpacity(0.1),
                    radius: 36,
                    backgroundImage: AssetImage(path),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUsernameSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Username'.tr(),
          style: TextStyle(
            color: theme.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: _usernameController,
            decoration: InputDecoration(
              hintText: 'Enter username'.tr(),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Change Password'.tr(),
          style: TextStyle(
            color: theme.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Container(
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              hintText: 'New password'.tr(),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                  color: theme.primaryColor,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: _confirmPasswordController,
            obscureText: !_isConfirmPasswordVisible,
            decoration: InputDecoration(
              hintText: 'Confirm password'.tr(),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(
                  _isConfirmPasswordVisible ? Icons.visibility_off : Icons.visibility,
                  color: theme.primaryColor,
                ),
                onPressed: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}