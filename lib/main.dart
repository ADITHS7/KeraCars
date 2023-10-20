import 'dart:developer';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:keracars_app/core/util/app_bloc_observer.dart';
import 'package:keracars_app/app.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      await dotenv.load();

      Bloc.observer = AppBlocObserver();

      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: kIsWeb ? HydratedStorage.webStorageDirectory : await getApplicationDocumentsDirectory(),
      );

      startApp();
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
