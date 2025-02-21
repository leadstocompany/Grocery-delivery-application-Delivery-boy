import 'package:delivery_app/src/core/network_services/dio_client.dart';
import 'package:delivery_app/src/logic/repo/auth_repo.dart';
import 'package:delivery_app/src/logic/repo/order_repo.dart';
import 'package:delivery_app/src/logic/services/auth_service_locator.dart';
import 'package:delivery_app/src/logic/services/orderSirvice.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';


GetIt getIt = GetIt.instance;

class ServiceLocator {
  static void setup() {
    // dio client
    getIt.registerSingleton(Dio());
    getIt.registerSingleton(DioClient(getIt<Dio>()));
    getIt.registerSingleton(AuthServices());
    // getIt.registerSingleton(ProductService());
     getIt.registerSingleton(OrderService());
    //     getIt.registerSingleton(HomeService());

    // Repos
    getIt.registerSingleton(AuthRepo(getIt<AuthServices>()));
    // getIt.registerSingleton(ProductRepo(getIt<ProductService>()));
     getIt.registerSingleton(OrderRepo(getIt<OrderService>()));
// getIt.registerSingleton(HomeRepo(getIt<HomeService>()));
  }
}
