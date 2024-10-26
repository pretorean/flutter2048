import 'package:flutter/material.dart';
import 'package:flutter2048/core/composition_root.dart';
import 'package:flutter2048/core/dependency/dependencies_container.dart';
import 'package:flutter2048/core/dependency/dependencies_scope.dart';
import 'package:flutter2048/core/material_context.dart';
import 'package:flutter2048/core/window_size.dart';

class App extends StatelessWidget {
  final CompositionResult _compositionResult;

  const App({
    required CompositionResult compositionResult,
    super.key,
  }) : _compositionResult = compositionResult;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DependenciesScope(
      dependencies: DependenciesContainer(
        gameBloc: _compositionResult.dependencies.gameBloc,
      ),
      child: const WindowSizeScope(
        child: MaterialContext(),
      ),
    );
  }
}
