import 'package:vania/vania.dart';

class CreateProductNotes extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('productnotes', () {
      char('note_id', length: 5); // Primary key
      primary('note_id');
      char('prod_id', length: 10); // Tambahkan kolom ini
      date('note_date');
      text('note_text');
      foreign('prod_id', 'products', 'prod_id');
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('product_notes');
  }
}
