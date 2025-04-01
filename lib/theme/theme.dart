import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002d84), // Ana renk (Koyu Mavi)
      surfaceTint: Color(0xff3b5fad), // Hafif açık tonu
      onPrimary: Color(0xffffffff), // Beyaz (Kontrast için)
      primaryContainer: Color(0xff4d6ea0), // Daha açık mavi
      onPrimaryContainer: Color(0xffffffff), // Beyaz

      secondary: Color(0xff8b3d3e), // Bordoya yakın koyu kırmızı
      onSecondary: Color(0xffffffff), // Beyaz
      secondaryContainer: Color(0xffc46f6e), // Açık kırmızı ton
      onSecondaryContainer: Color(0xffffffff), // Beyaz

      tertiary: Color(0xff005870), // Petrol mavisi
      onTertiary: Color(0xffffffff), // Beyaz
      tertiaryContainer: Color(0xff1e8094), // Daha açık mavi-yeşil tonu
      onTertiaryContainer: Color(0xffffffff), // Beyaz

      error: Color(0xff8b2a1c), // Koyu kırmızı
      onError: Color(0xffffffff), // Beyaz
      errorContainer: Color(0xffd68072), // Açık kırmızı tonu
      onErrorContainer: Color(0xffffffff), // Beyaz

      surface: Color(0xfff9f9ff), // scaffold arka
      onSurface: Color(0xff121212), // Koyu gri
      onSurfaceVariant: Color(0xff33363d), // Orta ton gri

      outline: Color(0xffd4d5dc), // Çok açık gri çizgiler
      outlineVariant: Color(0xffe5e6ec), // Neredeyse beyaza yakın soft gri
      // Daha açık ve soft bir gri tonu
      // Daha açık ve soft bir gri tonu
      // Daha açık gri çizgiler

      shadow: Color.fromARGB(255, 4, 1, 1), // Gölge rengi (Siyah)
      scrim: Color(0xff000000), // Karartma rengi (Siyah)

      inverseSurface: Color(0xff2e3035), // Koyu tema arka plan
      inversePrimary: Color(0xffa7c8ff), // Açık mavi (Zıt renk)

      primaryFixed: Color(0xff4d6ea0), // Sabit mavi tonu
      onPrimaryFixed: Color(0xffffffff), // Beyaz
      primaryFixedDim: Color(0xff345586), // Koyu mavi tonu
      onPrimaryFixedVariant: Color(0xffffffff), // Beyaz

      secondaryFixed: Color(0xffc46f6e), // Açık kırmızı tonu
      onSecondaryFixed: Color(0xffffffff), // Beyaz
      secondaryFixedDim: Color(0xff9e4d4d), // Koyu kırmızı tonu
      onSecondaryFixedVariant: Color(0xffffffff), // Beyaz

      tertiaryFixed: Color(0xff1e8094), // Açık petrol mavisi
      onTertiaryFixed: Color(0xffffffff), // Beyaz
      tertiaryFixedDim: Color(0xff005870), // Koyu petrol mavisi
      onTertiaryFixedVariant: Color(0xffffffff), // Beyaz

      surfaceDim: Color(0xffe8e9ef), // Daha açık gri
      surfaceBright: Color(0xfffdfdff), // Beyaza daha yakın
      surfaceContainerLowest: Color(0xffffffff), // Saf beyaz
      surfaceContainerLow: Color(0xfffbfbfe), // Neredeyse beyaz
      surfaceContainer: Color(0xfff5f5fc), // Çok hafif gri
      surfaceContainerHigh: Color(0xffeeeef5), // Açık gri
      surfaceContainerHighest:
          Color(0xfff2f2f9), // Biraz daha koyu ama yine de açık

      // Koyu gri
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff0f3665),
      surfaceTint: Color(0xff3e5f90),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4d6ea0),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff5e2324),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffa15857),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff003c44),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff187884),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff5e241c),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffa1594e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff0f1116),
      onSurfaceVariant: Color(0xff33363d),
      outline: Color(0xff4f525a),
      outlineVariant: Color(0xff6a6d75),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3035),
      inversePrimary: Color(0xffa7c8ff),
      primaryFixed: Color(0xff4d6ea0),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff345586),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xffa15857),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff844140),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff187884),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff005e68),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc5c6cd),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3fa),
      surfaceContainer: Color(0xffe7e8ee),
      surfaceContainerHigh: Color(0xffdcdce3),
      surfaceContainerHighest: Color(0xffd1d1d8),
    );
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffa7c8ff),
      surfaceTint: Color(0xffa7c8ff),
      onPrimary: Color(0xff05305f),
      primaryContainer: Color(0xff244777),
      onPrimaryContainer: Color(0xffd5e3ff),
      secondary: Color(0xffffb3b1),
      onSecondary: Color(0xff571d1f),
      secondaryContainer: Color(0xff733333),
      onSecondaryContainer: Color(0xffffdad8),
      tertiary: Color(0xff82d3e0),
      onTertiary: Color(0xff00363d),
      tertiaryContainer: Color(0xff004f58),
      onTertiaryContainer: Color(0xff9eeffd),
      error: Color(0xffffb4a8),
      onError: Color(0xff561e16),
      errorContainer: Color(0xff73342b),
      onErrorContainer: Color(0xffffdad4),
      surface: Color(0xff111318),
      onSurface: Color(0xffe2e2e9),
      onSurfaceVariant: Color(0xffc4c6cf),
      outline: Color(0xff8e9199),
      outlineVariant: Color(0xff43474e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e9),
      inversePrimary: Color(0xff3e5f90),
      primaryFixed: Color(0xffd5e3ff),
      onPrimaryFixed: Color(0xff001b3c),
      primaryFixedDim: Color(0xffa7c8ff),
      onPrimaryFixedVariant: Color(0xff244777),
      secondaryFixed: Color(0xffffdad8),
      onSecondaryFixed: Color(0xff3b080c),
      secondaryFixedDim: Color(0xffffb3b1),
      onSecondaryFixedVariant: Color(0xff733333),
      tertiaryFixed: Color(0xff9eeffd),
      onTertiaryFixed: Color(0xff001f24),
      tertiaryFixedDim: Color(0xff82d3e0),
      onTertiaryFixedVariant: Color(0xff004f58),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff37393e),
      surfaceContainerLowest: Color(0xff0c0e13),
      surfaceContainerLow: Color(0xff191c20),
      surfaceContainer: Color(0xff1d2024),
      surfaceContainerHigh: Color(0xff282a2f),
      surfaceContainerHighest: Color(0xff33353a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffcbddff),
      surfaceTint: Color(0xffa7c8ff),
      onPrimary: Color(0xff00254e),
      primaryContainer: Color(0xff7292c6),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffffd2d0),
      onSecondary: Color(0xff481315),
      secondaryContainer: Color(0xffcb7a79),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xff98e9f7),
      onTertiary: Color(0xff002a30),
      tertiaryContainer: Color(0xff499ca9),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cb),
      onError: Color(0xff48140d),
      errorContainer: Color(0xffcc7b6f),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff111318),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffdadce5),
      outline: Color(0xffafb2bb),
      outlineVariant: Color(0xff8d9099),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e9),
      inversePrimary: Color(0xff264878),
      primaryFixed: Color(0xffd5e3ff),
      onPrimaryFixed: Color(0xff001129),
      primaryFixedDim: Color(0xffa7c8ff),
      onPrimaryFixedVariant: Color(0xff0f3665),
      secondaryFixed: Color(0xffffdad8),
      onSecondaryFixed: Color(0xff2c0104),
      secondaryFixedDim: Color(0xffffb3b1),
      onSecondaryFixedVariant: Color(0xff5e2324),
      tertiaryFixed: Color(0xff9eeffd),
      onTertiaryFixed: Color(0xff001417),
      tertiaryFixedDim: Color(0xff82d3e0),
      onTertiaryFixedVariant: Color(0xff003c44),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff42444a),
      surfaceContainerLowest: Color(0xff06070c),
      surfaceContainerLow: Color(0xff1b1e22),
      surfaceContainer: Color(0xff26282d),
      surfaceContainerHigh: Color(0xff303238),
      surfaceContainerHighest: Color(0xff3c3e43),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffeaf0ff),
      surfaceTint: Color(0xffa7c8ff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffa3c4fb),
      onPrimaryContainer: Color(0xff000b1f),
      secondary: Color(0xffffecea),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffffadab),
      onSecondaryContainer: Color(0xff220002),
      tertiary: Color(0xffcdf7ff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff7ecfdc),
      onTertiaryContainer: Color(0xff000e10),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea2),
      onErrorContainer: Color(0xff220000),
      surface: Color(0xff111318),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffedf0f9),
      outlineVariant: Color(0xffc0c2cc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e9),
      inversePrimary: Color(0xff264878),
      primaryFixed: Color(0xffd5e3ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffa7c8ff),
      onPrimaryFixedVariant: Color(0xff001129),
      secondaryFixed: Color(0xffffdad8),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffffb3b1),
      onSecondaryFixedVariant: Color(0xff2c0104),
      tertiaryFixed: Color(0xff9eeffd),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xff82d3e0),
      onTertiaryFixedVariant: Color(0xff001417),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff4e5055),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1d2024),
      surfaceContainer: Color(0xff2e3035),
      surfaceContainerHigh: Color(0xff393b41),
      surfaceContainerHighest: Color(0xff45474c),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
