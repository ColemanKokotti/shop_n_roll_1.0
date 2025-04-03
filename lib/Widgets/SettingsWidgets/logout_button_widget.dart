import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bloc_Cubit/AuthCubit/auth_cubit.dart';

class LogoutWidgetButton extends StatelessWidget {
  const LogoutWidgetButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Account'.tr(), style: TextStyle(color: theme.primaryColor, fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4.0, offset: Offset(0, 2))]
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                context.read<AuthCubit>().logout(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Logout'.tr(), style: TextStyle(color: theme.primaryColor, fontSize: 16.0, fontWeight: FontWeight.w500)),
                      Icon(Icons.logout, color: theme.primaryColor),
                    ]
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}