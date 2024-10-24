import 'package:flutter/material.dart';
import 'package:flutter2048/core/app_theme.dart';
import 'package:flutter2048/core/localization/localization.dart';
import 'package:flutter2048/widget/menu/menu_screen_widget.dart';

/// {@template material_context}
/// [MaterialContext] is an entry point to the material context.
///
/// This widget sets locales, themes and routing.
/// {@endtemplate}
class MaterialContext extends StatelessWidget {
  /// {@macro material_context}
  const MaterialContext({super.key});

  // This global key is needed for [MaterialApp]
  // to work properly when Widgets Inspector is enabled.
  static final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return MaterialApp(
      theme: AppTheme.defaultTheme.lightTheme,
      darkTheme: AppTheme.defaultTheme.darkTheme,
      localizationsDelegates: Localization.localizationDelegates,
      supportedLocales: Localization.supportedLocales,
      title: '2048',
      home: const MenuScreen(),
      builder: (context, child) => MediaQuery(
        key: _globalKey,
        data: mediaQueryData.copyWith(textScaler: TextScaler.linear(mediaQueryData.textScaler.scale(1))),
        child: child!,
      ),
    );
  }
}
