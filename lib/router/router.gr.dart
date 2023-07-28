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
    MyTargetRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const MyTargetScreen()),
      );
    },
    ProfileImageRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileImageRouteArgs>(
          orElse: () => const ProfileImageRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: ProfileImageScreen(
          key: args.key,
          isRegistration: args.isRegistration,
        )),
      );
    },
    CreateNewAthleteRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CreateNewAthleteScreen()),
      );
    },
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
    RecoverPasswordRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const RecoverPasswordScreen()),
      );
    },
    ProfileRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileRouteArgs>(
          orElse: () => const ProfileRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: ProfileScreen(
          key: args.key,
          athleteId: args.athleteId,
        )),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const MainScreen()),
      );
    },
    AuthRoute.name: (routeData) {
      final args =
          routeData.argsAs<AuthRouteArgs>(orElse: () => const AuthRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: AuthScreen(key: args.key)),
      );
    },
    RegistrationRoute.name: (routeData) {
      final args = routeData.argsAs<RegistrationRouteArgs>(
          orElse: () => const RegistrationRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: RegistrationScreen(key: args.key)),
      );
    },
    MyParamsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const MyParamsScreen()),
      );
    },
    BirthdayRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const BirthdayScreen()),
      );
    },
    IdConfirmationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const IdConfirmationScreen()),
      );
    },
    AthletesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const AthletesScreen()),
      );
    },
  };
}

/// generated route for
/// [MyTargetScreen]
class MyTargetRoute extends PageRouteInfo<void> {
  const MyTargetRoute({List<PageRouteInfo>? children})
      : super(
          MyTargetRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyTargetRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileImageScreen]
class ProfileImageRoute extends PageRouteInfo<ProfileImageRouteArgs> {
  ProfileImageRoute({
    Key? key,
    bool isRegistration = false,
    List<PageRouteInfo>? children,
  }) : super(
          ProfileImageRoute.name,
          args: ProfileImageRouteArgs(
            key: key,
            isRegistration: isRegistration,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfileImageRoute';

  static const PageInfo<ProfileImageRouteArgs> page =
      PageInfo<ProfileImageRouteArgs>(name);
}

class ProfileImageRouteArgs {
  const ProfileImageRouteArgs({
    this.key,
    this.isRegistration = false,
  });

  final Key? key;

  final bool isRegistration;

  @override
  String toString() {
    return 'ProfileImageRouteArgs{key: $key, isRegistration: $isRegistration}';
  }
}

/// generated route for
/// [CreateNewAthleteScreen]
class CreateNewAthleteRoute extends PageRouteInfo<void> {
  const CreateNewAthleteRoute({List<PageRouteInfo>? children})
      : super(
          CreateNewAthleteRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateNewAthleteRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
/// [RecoverPasswordScreen]
class RecoverPasswordRoute extends PageRouteInfo<void> {
  const RecoverPasswordRoute({List<PageRouteInfo>? children})
      : super(
          RecoverPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'RecoverPasswordRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    Key? key,
    int? athleteId,
    List<PageRouteInfo>? children,
  }) : super(
          ProfileRoute.name,
          args: ProfileRouteArgs(
            key: key,
            athleteId: athleteId,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<ProfileRouteArgs> page =
      PageInfo<ProfileRouteArgs>(name);
}

class ProfileRouteArgs {
  const ProfileRouteArgs({
    this.key,
    this.athleteId,
  });

  final Key? key;

  final int? athleteId;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key, athleteId: $athleteId}';
  }
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
/// [AuthScreen]
class AuthRoute extends PageRouteInfo<AuthRouteArgs> {
  AuthRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          AuthRoute.name,
          args: AuthRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const PageInfo<AuthRouteArgs> page = PageInfo<AuthRouteArgs>(name);
}

class AuthRouteArgs {
  const AuthRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'AuthRouteArgs{key: $key}';
  }
}

/// generated route for
/// [RegistrationScreen]
class RegistrationRoute extends PageRouteInfo<RegistrationRouteArgs> {
  RegistrationRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          RegistrationRoute.name,
          args: RegistrationRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'RegistrationRoute';

  static const PageInfo<RegistrationRouteArgs> page =
      PageInfo<RegistrationRouteArgs>(name);
}

class RegistrationRouteArgs {
  const RegistrationRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'RegistrationRouteArgs{key: $key}';
  }
}

/// generated route for
/// [MyParamsScreen]
class MyParamsRoute extends PageRouteInfo<void> {
  const MyParamsRoute({List<PageRouteInfo>? children})
      : super(
          MyParamsRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyParamsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BirthdayScreen]
class BirthdayRoute extends PageRouteInfo<void> {
  const BirthdayRoute({List<PageRouteInfo>? children})
      : super(
          BirthdayRoute.name,
          initialChildren: children,
        );

  static const String name = 'BirthdayRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [IdConfirmationScreen]
class IdConfirmationRoute extends PageRouteInfo<void> {
  const IdConfirmationRoute({List<PageRouteInfo>? children})
      : super(
          IdConfirmationRoute.name,
          initialChildren: children,
        );

  static const String name = 'IdConfirmationRoute';

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
