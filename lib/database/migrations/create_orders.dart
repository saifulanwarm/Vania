import 'package:vania/vania.dart';

class CreateOrders extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('orders', () {
      integer('orders_num', length: 11); // Primary key
      primary('orders_num');
      date('order_date');
      char('cust_id', length: 5); 
      foreign('cust_id', 'customers', 'cust_id');
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('orders');
  }
}
