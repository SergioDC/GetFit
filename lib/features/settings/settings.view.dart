import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getfit/common/extensions/context_extensions.dart';
import 'package:provider/provider.dart';

import '../../common/config/configuration.dart';
import '../../common/widgets/chip.custom.dart';
import '../../common/widgets/column_card.dart';
import '../../common/widgets/image_carousel_modal.dart';
import '../../common/widgets/page_section_header.dart';
import '../../common/widgets/states/widget_state_switch_thumb.dart';
import '../log/log.service.dart';
import '../log/log.view.dart';
import 'settings.viewmodel.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  void _showImageCarousel(BuildContext context, SettingsViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return ImageCarouselModal(
          images: Configuration.backgrounds,
          initialIndex: Configuration.backgrounds
              .indexOf(viewModel.settings.imgBackground),
          onImageSelected: (selectedImage) {
            viewModel.updateSettings(imgBackground: selectedImage);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(
      builder: (context, viewModel, child) {
        final settings = viewModel.settings;
        return Container(
          color: Theme.of(context)
              .colorScheme
              .surface
              .withValues(alpha: Configuration.uiMidTransparency),
          child: ListView(
            children: [
              if (viewModel.versionLabel != null)
                PageSectionHeader(
                    label: viewModel.versionLabel!, centerRow: true),
              // UI Settings
              const PageSectionHeader(label: 'UI'),
              SizedBox(height: 10.h),
              ColumnCard(
                children: [
                  FilledButton(
                    onPressed: () => _showImageCarousel(context, viewModel),
                    child: ShaderMask(
                      shaderCallback: (bounds) {
                        return const LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.white,
                            Colors.white,
                            Colors.transparent,
                          ],
                          stops: [
                            0.0,
                            0.3,
                            0.7,
                            1.0,
                          ],
                        ).createShader(bounds);
                      },
                      child: Container(
                        height: kToolbarHeight.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(settings.imgBackground),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // ListTile(
                  //   title: Text(
                  //     'Novel title lines',
                  //     style: context.text.bodySmall!.copyWith(
                  //       color: context.color.onSurface,
                  //     ),
                  //   ),
                  //   subtitle: Slider(
                  //     value: settings.appNovelCardTitleMaxLines.toDouble(),
                  //     min: Configuration.libraryMinTitlesLines.toDouble(),
                  //     max: Configuration.libraryMaxTitleLines.toDouble(),
                  //     divisions: Configuration.libraryMaxTitleLines -
                  //         Configuration.libraryMinTitlesLines,
                  //     label: settings.appNovelCardTitleMaxLines.toString(),
                  //     onChanged: (value) {
                  //       viewModel.updateSettings(
                  //           appNovelCardTitleMaxLines: value.toInt());
                  //     },
                  //   ),
                  //   trailing: ChipCustom(
                  //       size: 20.spMax,
                  //       label: '${settings.appNovelCardTitleMaxLines}  '),
                  // ),
                  // Show pending chapters
                  // SwitchListTile(
                  //   thumbIcon: getThumbIcon(context),
                  //   title: Text(
                  //     'Show pending chapters',
                  //     style: context.text.bodySmall!.copyWith(
                  //       color: context.color.onSurface,
                  //     ),
                  //   ),
                  //   value: settings.showUnreadChapters,
                  //   onChanged: (value) {
                  //     viewModel.updateSettings(showUnreadChapters: value);
                  //   },
                  // ),
                  // Dark Theme Switch
                  SwitchListTile(
                    thumbIcon: getThumbIcon(context),
                    title: Text(
                      'Dark theme',
                      style: context.text.bodySmall!.copyWith(
                        color: context.color.onSurface,
                      ),
                    ),
                    value: settings.isDarkTheme,
                    onChanged: (value) {
                      viewModel.updateSettings(isDarkTheme: value);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Debug Settings
              const PageSectionHeader(label: 'Debug'),
              const SizedBox(height: 10),
              ColumnCard(
                children: [
                  // Enable Developer Options Switch
                  SwitchListTile(
                    thumbIcon: getThumbIcon(context),
                    title: Text(
                      'Debug options',
                      style: context.text.bodySmall!.copyWith(
                        color: context.color.onSurface,
                      ),
                    ),
                    value: settings.devEnableDeveloperOptions,
                    onChanged: (value) {
                      viewModel.updateSettings(
                          devEnableDeveloperOptions: value);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Log max lines',
                      style: context.text.bodySmall!.copyWith(
                        color: context.color.onSurface,
                      ),
                    ),
                    subtitle: Slider(
                      value: settings.logMaxLinesThreshold.toDouble(),
                      min: Configuration.logMinThresholdLines.toDouble(),
                      max: Configuration.logMaxThresholdLines.toDouble(),
                      divisions: (Configuration.logMaxThresholdLines -
                              Configuration.logMinThresholdLines) ~/
                          500,
                      label: settings.logMaxLinesThreshold.toString(),
                      onChanged: settings.devEnableDeveloperOptions
                          ? (value) {
                              viewModel.updateSettings(
                                  logMaxLinesThreshold: value.toInt());
                            }
                          : null,
                    ),
                    trailing: ChipCustom(
                        size: 20.spMax,
                        label: '${settings.logMaxLinesThreshold}  '),
                  ),
                  ListTile(
                    title: Text(
                      'Log recovery lines',
                      style: context.text.bodySmall!.copyWith(
                        color: context.color.onSurface,
                      ),
                    ),
                    subtitle: Slider(
                      value: settings.logMaxLinesRecovery.toDouble(),
                      min: Configuration.logMinRecoveryLines.toDouble(),
                      max: Configuration.logMaxRecoveryLines.toDouble(),
                      divisions: (Configuration.logMaxRecoveryLines -
                              Configuration.logMinRecoveryLines) ~/
                          100,
                      label: settings.logMaxLinesRecovery.toString(),
                      onChanged: settings.devEnableDeveloperOptions
                          ? (value) {
                              viewModel.updateSettings(
                                  logMaxLinesRecovery: value.toInt());
                            }
                          : null,
                    ),
                    trailing: ChipCustom(
                        size: 20.spMax,
                        label: '${settings.logMaxLinesRecovery}  '),
                  ),
                  ListTile(
                    title: Text(
                      'Log level',
                      style: context.text.bodySmall!.copyWith(
                        color: context.color.onSurface,
                      ),
                    ),
                    trailing: DropdownButton<LogLevel>(
                      value: settings.logLevel,
                      items: LogLevel.values.map(
                        (level) {
                          var style = LogView.getLogStyle(level);
                          return DropdownMenuItem(
                            value: level,
                            child: Row(
                              children: [
                                Icon(style.$2, color: style.$1),
                                SizedBox(width: 10.spMax),
                                Text(level.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface)),
                              ],
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: settings.devEnableDeveloperOptions
                          ? (value) {
                              if (value != null) {
                                viewModel.updateSettings(logLevel: value);
                              }
                            }
                          : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
