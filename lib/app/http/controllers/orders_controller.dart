import 'package:tugas_vania/app/models/orders.dart';
import 'package:tugas_vania/app/models/customer.dart';
import 'package:vania/vania.dart';

class OrdersController extends Controller {
  // Fungsi untuk membuat order baru
  Future<Response> create(Request req) async {
    req.validate({
      'orders_num': 'required|Integer',
      'order_date': 'required|Date',
      'cust_id': 'required|String',
    }, {
      'orders_num.required': 'Nomor order tidak boleh kosong',
      'orders_num.integer': 'Nomor order harus berupa angka',
      'order_date.required': 'Tanggal order tidak boleh kosong',
      'order_date.date': 'Tanggal order harus valid',
      'cust_id.required': 'ID customer tidak boleh kosong',
      'cust_id.string': 'ID customer harus berupa string',
    });

    final dataOrder = req.input();

    // Cek apakah customer yang bersangkutan ada di dalam database
    final existingCustomer =
        await Customer().query().where('cust_id', '=', dataOrder['cust_id']).first();

    if (existingCustomer == null) {
      return Response.json({
        "message": "Customer tidak ditemukan",
      }, 404);
    }

    // Insert data order ke dalam tabel orders
    await Orders().query().insert(dataOrder);

    return Response.json({
      "message": "Order berhasil dibuat",
      "data": dataOrder,
    }, 200);
  }

  // Fungsi untuk menampilkan semua order
  Future<Response> show() async {
    final dataOrders = await Orders().query().get();
    return Response.json({
      'message': 'Success',
      'data': dataOrders,
    }, 200);
  }

  // Fungsi untuk memperbarui order berdasarkan orders_num
  Future<Response> update(Request req, int ordersNum) async {
    req.validate({
      // 'orders_num': 'required|Integer',
      'order_date': 'required|Date',
      'cust_id': 'required|String',
    }, {
      // 'orders_num.required': 'Nomor order tidak boleh kosong',
      // 'orders_num.integer': 'Nomor order harus berupa angka',
      'order_date.required': 'Tanggal order tidak boleh kosong',
      'order_date.date': 'Tanggal order harus valid',
      'cust_id.required': 'ID customer tidak boleh kosong',
      'cust_id.string': 'ID customer harus berupa string',
    });

    final dataOrder = req.input();

    final existingOrder =
        await Orders().query().where('orders_num', '=', ordersNum).first();

    if (existingOrder == null) {
      return Response.json({
        "message": "Order tidak ditemukan",
      }, 404);
    }

    // Update data order
    await Orders().query().where('orders_num', '=', ordersNum).update(dataOrder);

    return Response.json({
      "message": "Order berhasil diperbarui",
      "data": dataOrder,
    }, 200);
  }

  // Fungsi untuk menghapus order berdasarkan orders_num
  Future<Response> destroy(int ordersNum) async {
    try {
      final order = await Orders().query().where('orders_num', '=', ordersNum).first();

      if (order == null) {
        return Response.json({
          'message': 'Order dengan nomor $ordersNum tidak ditemukan',
        }, 404);
      }

      await Orders().query().where('orders_num', '=', ordersNum).delete();

      return Response.json({
        'message': 'Order berhasil dihapus',
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Terjadi kesalahan saat menghapus order',
      }, 500);
    }
  }
}

final OrdersController ordersController = OrdersController();
