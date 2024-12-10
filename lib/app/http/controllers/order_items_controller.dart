import 'package:tugas_vania/app/models/orderitem.dart';
import 'package:vania/vania.dart';

class OrderItemsController extends Controller {
  Future<Response> create(Request req) async {
    req.validate({
      'order_item': 'required|integer',
      'quantity': 'required|integer',
      'size': 'required|integer',
      'orders_num': 'required|integer',
      'prod_id': 'required|string',
    }, {
      'order_item.required': 'ID item tidak boleh kosong',
      'quantity.required': 'Jumlah tidak boleh kosong',
      'size.required': 'Ukuran tidak boleh kosong',
      'orders_num.required': 'Nomor pesanan tidak boleh kosong',
      'prod_id.required': 'ID produk tidak boleh kosong',
    });

    final dataOrderItem = req.input();

    final existingOrderItem = await Orderitem()
        .query()
        .where('order_item', '=', dataOrderItem['order_item'])
        .first();

    if (existingOrderItem != null) {
      return Response.json({
        "message": "Item pesanan sudah ada",
      }, 409);
    }

    await Orderitem().query().insert(dataOrderItem);

    return Response.json({
      "message": "Item pesanan berhasil ditambahkan",
      "data": dataOrderItem,
    }, 200);
  }

  Future<Response> show() async {
    final dataOrderItems = await Orderitem().query().get();
    return Response.json({
      'message': 'Success',
      'data': dataOrderItems,
    }, 200);
  }

  Future<Response> update(Request req, int orderItem) async {
    req.validate({
      'quantity': 'required|integer',
      'size': 'required|integer',
      // 'orders_num': 'required|integer',
      // 'prod_id': 'required|string',
    }, {
      'quantity.required': 'Jumlah tidak boleh kosong',
      'size.required': 'Ukuran tidak boleh kosong',
      // 'orders_num.required': 'Nomor pesanan tidak boleh kosong',
      // 'prod_id.required': 'ID produk tidak boleh kosong',
    });

    final dataOrderItem = req.input();

    final existingOrderItem = await Orderitem()
        .query()
        .where('order_item', '=', orderItem)
        .first();

    if (existingOrderItem == null) {
      return Response.json({
        "message": "Item pesanan tidak ditemukan",
      }, 404);
    }

    await Orderitem().query().where('order_item', '=', orderItem).update(dataOrderItem);

    return Response.json({
      "message": "Item pesanan berhasil diperbarui",
      "data": dataOrderItem,
    }, 200);
  }

  Future<Response> destroy(int id) async {
    try {
      final orderItem =
          await Orderitem().query().where('order_item', '=', id).first();

      if (orderItem == null) {
        return Response.json({
          'message': 'Item pesanan dengan ID $id tidak ditemukan',
        }, 404);
      }

      await Orderitem().query().where('order_item', '=', id).delete();

      return Response.json({
        'message': 'Item pesanan berhasil dihapus',
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Terjadi kesalahan saat menghapus item pesanan',
      }, 500);
    }
  }
}

final OrderItemsController orderItemsController = OrderItemsController();
