import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/settings/settings.viewmodel.dart';

class BackgroundCover extends StatelessWidget {
  const BackgroundCover({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(
      builder: (_, settingsVieWModel, __) {
        return SizedBox.expand(
          child: Image.asset(
            settingsVieWModel.settings.imgBackground,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
