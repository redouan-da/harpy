import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harpy/components/application/bloc/application_bloc.dart';
import 'package:harpy/components/authentication/bloc/authentication_bloc.dart';
import 'package:harpy/components/settings/theme_selection/bloc/theme_bloc.dart';
import 'package:harpy/components/timeline/home_timeline/bloc/home_timeline_bloc.dart';

/// The [GlobalBlocProvider] is built above the root [MaterialApp] to provide
/// every descendant with globally available blocs.
///
/// These blocs will only be created once.
class GlobalBlocProvider extends StatelessWidget {
  const GlobalBlocProvider({
    @required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<Bloc<dynamic, dynamic>>>[
        // theme
        BlocProvider<ThemeBloc>(create: (_) => ThemeBloc()),

        // authentication
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) => AuthenticationBloc(
            themeBloc: context.read<ThemeBloc>(),
          ),
        ),

        // application
        // can't be lazy since initialization starts upon bloc creation
        BlocProvider<ApplicationBloc>(
          lazy: false,
          create: (BuildContext context) => ApplicationBloc(
            authenticationBloc: context.read<AuthenticationBloc>(),
            themeBloc: context.read<ThemeBloc>(),
          ),
        ),

        // home timeline
        BlocProvider<HomeTimelineBloc>(create: (_) => HomeTimelineBloc()),
      ],
      child: child,
    );
  }
}
