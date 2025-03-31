import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Configuration {
  // Device
  static const double deviceViewportWidth = 412;
  static const double deviceViewportHeight = 906;
  static const Size deviceViewportSize =
      Size(deviceViewportWidth, deviceViewportHeight);

  // Logs
  static const String logFolderName = 'logs';
  static const String logFileName = 'app_logs.txt';
  static const bool logAlsoWriteToConsole = true;
  static const int logMinThresholdLines = 1000;
  static const int logMaxThresholdLines = 3500;
  static const int logMinRecoveryLines = 100;
  static const int logMaxRecoveryLines = 500;

  // Dev options
  static const bool devDeleteAllDataAtStart = false;
  static const double devDeveloperDrawerDragWidth = 75;

  // Animations
  static const double animLoadingStopThreshold = 0.7;
  static const int animLoadingFirstSectionDurationMs = 1500;
  static const int animLoadingSecondSectionDurationMs = 1000;
  static const int animBarSlideDelayMs = 500;
  static const int animBarSlideDurationMs = 300;
  static const int animDelayStartAfterContentReadyMs = 50;
  static const int animContentSlideInDurationMs = 200;
  static const int animItemSlideInDurationMs = 10;
  static const int animContentSectionDelayMs = 75;

  // UI
  static const double uiMinTransparency = 0.9;
  static const double uiVeryLowTransparency = 0.8;
  static const double uiLowTransparency = 0.65;
  static const double uiMidTransparency = 0.5;
  static const double uiHighTransparency = 0.3;
  static const double uiMaxTransparency = 0.15;
  static const Color specialColor = Colors.amber;
  static double listHeaderHeight = 40.h;

  // Assets
  static const String defaultBackground = 'assets/backgrounds/library01.png';
  static const String noCoverImage = 'assets/images/no_cover.png';
  static const List<String> backgrounds = [
    'assets/backgrounds/library01.png',
    'assets/backgrounds/library02.png',
    'assets/backgrounds/library03.png',
    'assets/backgrounds/library04.png',
    'assets/backgrounds/library05.png',
    'assets/backgrounds/library06.png',
    'assets/backgrounds/library07.png',
    'assets/backgrounds/library08.png',
    'assets/backgrounds/library09.png',
    'assets/backgrounds/library10.png',
  ];
    
  // Font
  static const String defaultFont = 'Roboto';
  static const int defaultFontSize = 20;
  static const List<String> availableFontList = [
    "Abril Fatface",
    "Aclonica",
    "Alegreya Sans",
    "Architects Daughter",
    "Archivo",
    "Archivo Narrow",
    "Bebas Neue",
    "Bitter",
    "Bree Serif",
    "Bungee",
    "Cabin",
    "Cairo",
    "Coda",
    "Comfortaa",
    "Comic Neue",
    "Comic Sans",
    "Cousine",
    "Crimson Text",
    "Croissant One",
    "DM Serif Text",
    "Faster One",
    "Forum",
    "Great Vibes",
    "Heebo",
    "Inconsolata",
    "Inter",
    "Josefin Slab",
    "Lato",
    "Lexend",
    "Libre Baskerville",
    "Lobster",
    "Lora",
    "Merriweather",
    "Montserrat",
    "Mukta",
    "Noto Sans",
    "Noto Serif",
    "Nunito",
    "Offside",
    "Open Sans",
    "Oswald",
    "Overlock",
    "Pacifico",
    "Playfair Display",
    "Poppins",
    "PT Serif",
    "Raleway",
    "Roboto",
    "Roboto Mono",
    "Roboto Slab",
    "Source Sans 3",
    "Source Serif 4",
    "Space Mono",
    "Spicy Rice",
    "Squada One",
    "Sue Ellen Francisco",
    "Trade Winds",
    "Ubuntu",
    "Varela",
    "Vollkorn",
    "Work Sans",
    "Zilla Slab",
  ];
}
