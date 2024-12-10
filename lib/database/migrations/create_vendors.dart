import 'package:vania/vania.dart';

class CreateVendors extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('vendors', () {
      char('vend_id', length: 5); // Primary key
      primary('vend_id');
      string('vend_name', length: 50);
      text('address');
      text('kota');
      string('vend_state', length: 5);
      string('vend_zip', length: 7);
      string('vend_country', length: 25);
      // timeStamps();
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('vendors');
  }
}
