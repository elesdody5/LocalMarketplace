import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';


final domainGetIt = GetIt.instance;

/// Initializes Domain layer dependency injection
@InjectableInit(
  initializerName: 'initDomainGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
void configureDomainDependencies() => initDomainGetIt(domainGetIt);

