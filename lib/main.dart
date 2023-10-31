import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:keracars_app/app.dart';
import 'package:keracars_app/container.dart';
import 'package:keracars_app/core/util/app_bloc_observer.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      await dotenv.load();

      Bloc.observer = AppBlocObserver();

      await Hive.initFlutter();

      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: kIsWeb ? HydratedStorage.webStorageDirectory : await getApplicationDocumentsDirectory(),
      );

      await initDependencies();

      startApp();
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
