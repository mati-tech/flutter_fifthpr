

class StorelyApp{
  const StorelyApp({required String arg1});
}
void main(List<String> args) {
  const objapp = StorelyApp(arg1: 'arg');

}

class OrderService {
  var userRepository;
  var paymentService;
  var notificationService;
  var database;
  var config;
  var analytics;

  OrderService(
      this.userRepository,
      this.paymentService,
      this.notificationService,
      this.database,
      this.config,
      this.analytics,
      // ... и еще 10 параметров!
      );
}