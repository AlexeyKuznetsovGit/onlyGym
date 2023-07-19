// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    DiaryRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const DiaryScreen()),
      );
    },
    ExercisesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const ExercisesScreen()),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const ProfileScreen()),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainScreen(),
      );
    },
    AthletesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const AthletesScreen()),
      );
    },
    ProfileImageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const ProfileImageScreen()),
      );
    },
  };
}

/// generated route for
/// [DiaryScreen]
class DiaryRoute extends PageRouteInfo<void> {
  const DiaryRoute({List<PageRouteInfo>? children})
      : super(
          DiaryRoute.name,
          initialChildren: children,
        );

  static const String name = 'DiaryRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ExercisesScreen]
class ExercisesRoute extends PageRouteInfo<void> {
  const ExercisesRoute({List<PageRouteInfo>? children})
      : super(
          ExercisesRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExercisesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AthletesScreen]
class AthletesRoute extends PageRouteInfo<void> {
  const AthletesRoute({List<PageRouteInfo>? children})
      : super(
          AthletesRoute.name,
          initialChildren: children,
        );

  static const String name = 'AthletesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileImageScreen]
class ProfileImageRoute extends PageRouteInfo<void> {
  const ProfileImageRoute({List<PageRouteInfo>? children})
      : super(
          ProfileImageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileImageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
