import 'package:vania/vania.dart';

class CreateOrdersItems extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('orderitems', () {
      integer('order_item', length: 11); // Primary key
      primary('order_item');
      integer('quantity', length: 11);
      integer('size', length: 11);
      integer('orders_num', length: 11); 
      string('prod_id', length: 10);
      foreign('orders_num', 'orders', 'orders_num');
      foreign('prod_id', 'products', 'prod_id');
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('ordersitems');
  }
}
