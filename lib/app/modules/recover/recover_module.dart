import 'package:portfolio/app/modules/recover/recover_Page.dart';
import 'package:portfolio/app/modules/recover/recover_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RecoverModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => RecoverStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const RecoverPage()),
  ];
}
