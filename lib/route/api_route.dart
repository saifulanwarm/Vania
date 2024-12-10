import 'package:vania/vania.dart';
import 'package:tugas_vania/app/http/controllers/product_controller.dart';
import 'package:tugas_vania/app/http/controllers/vendor_controller.dart';
import 'package:tugas_vania/app/http/controllers/customer_controller.dart';
import 'package:tugas_vania/app/http/controllers/orders_controller.dart';
import 'package:tugas_vania/app/http/controllers/note_product_controller.dart';
import 'package:tugas_vania/app/http/controllers/order_items_controller.dart';

class ApiRoute implements Route {
  @override
  void register() {
    Router.post('/create-product', productController.create);
    Router.get('/daftar-product', productController.show);
    Router.put('/edit-product/{prod_id}', productController.update);
    Router.delete('/hapus-product/{prod_id}', productController.destroy);
    Router.post('/create-vendor', vendorController.create);
    Router.get('/daftar-vendor', vendorController.show);
    Router.put('/edit-vendor/{vend_id}', vendorController.update);
    Router.delete('/hapus-vendor/{vend_id}', vendorController.destroy);
    Router.post('/create-customer', customerController.create);
    Router.get('/daftar-customer', customerController.show);
    Router.put('/edit-customer/{cust_id}', customerController.update);
    Router.delete('/hapus-customer/{cust_id}', customerController.destroy);
    Router.post('/create-order', ordersController.create);
    Router.get('/daftar-order', ordersController.show);
    Router.put('/edit-order/{orders_num}', ordersController.update);
    Router.delete('/hapus-order/{orders_num}', ordersController.destroy);
    Router.post('/create-note', productNotesController.create);
    Router.get('/daftar-note', productNotesController.show);
    Router.put('/edit-note/{note_id}', productNotesController.update);
    Router.delete('/hapus-note/{note_id}', productNotesController.destroy);
    Router.post('/create-orderitems', orderItemsController.create);
    Router.get('/daftar-orderitems', orderItemsController.show);
    Router.put('/edit-orderitems/{order_item}', orderItemsController.update);
    Router.delete('/hapus-orderitems/{order_item}', orderItemsController.destroy);
  }
}
