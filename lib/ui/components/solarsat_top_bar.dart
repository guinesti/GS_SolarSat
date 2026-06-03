import 'package:flutter/material.dart';
import 'app_logo.dart';

class SolarSatTopBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;

  const SolarSatTopBar({super.key, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      title: const AppLogo(),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
