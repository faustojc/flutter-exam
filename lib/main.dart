import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exam/presentation/blocs/person_bloc/person_cubit.dart';
import 'package:flutter_exam/presentation/pages/home_page.dart';
import 'package:flutter_exam/repository/person_repository.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FastCachedImageConfig.init(
    subDir: (await getApplicationDocumentsDirectory()).path,
    clearCacheAfter: const Duration(days: 2),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => PersonRepository(),
      child: BlocProvider(
        create: (blocContext) {
          return PersonCubit(RepositoryProvider.of<PersonRepository>(blocContext))..onInitialize();
        },

        child: MaterialApp(
          title: 'Flutter Exam',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent)),
          home: const HomePage(),
        ),
      ),
    );
  }
}
