import 'package:flutter/material.dart';
import 'package:flutter2048/bloc/game/game_bloc.dart';
import 'package:flutter2048/core/dependency/dependencies_container.dart';
import 'package:flutter2048/core/dependency/dependencies_scope.dart';
import 'package:flutter2048/core/material_context.dart';
import 'package:flutter2048/core/window_size.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DependenciesScope(
      dependencies: DependenciesContainer(
        gameBloc: GameBloc(),
      ),
      child: const WindowSizeScope(
        child: MaterialContext(),
      ),
    );
  }
}
