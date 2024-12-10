import 'dart:io';
import 'package:vania/vania.dart';
import 'create_customers.dart';
import 'create_orders.dart';
import 'create_orders_items.dart';
import 'create_product_notes.dart';
import 'create_product_table.dart';
import 'create_vendors.dart';

void main(List<String> args) async {
  await MigrationConnection().setup();
  if (args.isNotEmpty && args.first.toLowerCase() == "migrate:fresh") {
    await Migrate().dropTables();
  } else {
    await Migrate().registry();
  }
  await MigrationConnection().closeConnection();
  exit(0);
}

class Migrate {
  registry() async {
		await CreateCustomers().up();
    await CreateOrders().up();
    await CreateProductNotes().up();
    await CreateProductTable().up();
    await CreateVendors().up();
    await CreateOrdersItems().up();
	}

  dropTables() async {
		await CreateOrdersItems().down();
    await CreateVendors().down();
    await CreateProductTable().down();
    await CreateProductNotes().down();
    await CreateOrders().down();
    await CreateCustomers().down();
	}
}
