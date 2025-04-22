import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_n_roll/Screens/splash_screen.dart';
import '../Bloc_Cubit/EditProfileCubit/edit_profile_cubit.dart';
import '../Bloc_Cubit/EditProfileCubit/edit_profile_state.dart';
import '../Data/DataAccount/account_repository_implementation.dart';
import '../FireBase/account_service.dart';
import '../Widgets/EditProfileScreenWidgets/avatar_section_widget.dart';
import '../Widgets/EditProfileScreenWidgets/delete_account_dialog_widget.dart';
import '../Widgets/EditProfileScreenWidgets/password_section_widget.dart';
import '../Widgets/EditProfileScreenWidgets/username_section_widget.dart';
import '../Bloc_Cubit/AuthCubit/auth_cubit.dart';


class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(
        AccountRepositoryImpl(AccountService()),
        FirebaseAuth.instance,
      ),
      child: EditProfileView(),
    );
  }
}

class EditProfileView extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileSuccess) {
          final authCubit = context.read<AuthCubit>();
          authCubit.refreshAuthState(context);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile updated successfully'.tr())),
          );
          Navigator.of(context).pop();
        }

        if (state is EditProfileInitial) {
          _usernameController.text = state.username;
        }

        if (state is AccountDeleted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SplashScreen()),
                (route) => false,
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Account deleted successfully'.tr())),
          );
        }
      },
      builder: (context, state) {
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
            child: state is EditProfileLoading
                ? Center(child: CircularProgressIndicator())
                : state is EditProfileInitial
                ? _buildContent(context, state, theme)
                : state is EditProfileError
                ? _buildErrorContent(context, state)
                : Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget _buildContent(
      BuildContext context, EditProfileInitial state, ThemeData theme) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AvatarSection(
            selectedPath: state.avatarPath,
            availableAvatars: state.availableAvatars,
            onSelect: (path) => context.read<EditProfileCubit>().selectAvatar(path),
          ),
          SizedBox(height: 24),
          UsernameSection(
            controller: _usernameController,
            onChanged: (value) => context.read<EditProfileCubit>().updateUsername(value),
          ),
          SizedBox(height: 24),
          PasswordSection(
            passwordController: _passwordController,
            confirmPasswordController: _confirmPasswordController,
            isPasswordVisible: context.read<EditProfileCubit>().isPasswordVisible,
            isConfirmPasswordVisible: context.read<EditProfileCubit>().isConfirmPasswordVisible,
            onTogglePasswordVisibility: () => context.read<EditProfileCubit>().togglePasswordVisibility(),
            onToggleConfirmPasswordVisibility: () => context.read<EditProfileCubit>().toggleConfirmPasswordVisibility(),
            onPasswordChanged: (value) => context.read<EditProfileCubit>().updatePassword(value),
            onConfirmPasswordChanged: (value) => context.read<EditProfileCubit>().updateConfirmPassword(value),
          ),
          SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.read<EditProfileCubit>().saveChanges(),
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
          SizedBox(height: 48),
          Divider(
            color: theme.dividerColor,
            thickness: 1.0,
          ),
          SizedBox(height: 24),
          Text(
            'Danger Zone'.tr(),
            style: TextStyle(
              color: theme.colorScheme.error,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _showDeleteAccountConfirmation(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'Delete Account'.tr(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountConfirmation(BuildContext context) {
    final parentContext = context;
    showDialog(
      context: parentContext,
      builder: (dialogContext) => DeleteAccountDialog(
        onConfirm: () => parentContext.read<EditProfileCubit>().deleteAccount(),
      ),
    );
  }

  Widget _buildErrorContent(BuildContext context, EditProfileError state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.errorMessage,
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<EditProfileCubit>().saveChanges();
              },
              child: Text('Try Again'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}