import 'package:tugas_vania/app/models/customer.dart';
import 'package:vania/vania.dart';

class CustomerController extends Controller {
  // Method untuk membuat customer baru
  Future<Response> create(Request req) async {
    req.validate({
      'cust_id': 'required|String',
      'cust_name': 'required|String',
      'cust_address': 'required|String',
      'cust_city': 'required|String',
      'cust_state': 'required|String',
      'cust_zip': 'required|String',
      'cust_country': 'required|String',
      'cust_telp': 'required|String',
    }, {
      'cust_name.required': 'Nama tidak boleh kosong',
      'cust_address.required': 'Alamat tidak boleh kosong',
      'cust_city.required': 'Kota tidak boleh kosong',
      'cust_state.required': 'Provinsi tidak boleh kosong',
      'cust_zip.required': 'Kode pos tidak boleh kosong',
      'cust_country.required': 'Negara tidak boleh kosong',
      'cust_telp.required': 'Nomor telepon tidak boleh kosong',
    });

    final dataCustomer = req.input();

    final existingCustomer = await Customer().query().where('cust_id', '=', dataCustomer['cust_id']).first();
    if (existingCustomer != null) {
      return Response.json({
        "message": "Customer sudah ada",
      }, 409);
    }

    await Customer().query().insert(dataCustomer);

    return Response.json(
      {
        "message": "Success",
        "data": dataCustomer,
      },
      200,
    );
  }

  // Method untuk mendapatkan semua data customer
  Future<Response> show() async {
    final dataCustomer = await Customer().query().get();
    return Response.json({
      'message': 'Success',
      'data': dataCustomer,
    }, 200);
  }

  // Method untuk memperbarui data customer berdasarkan cust_id
  Future<Response> update(Request req, String custId) async {
    req.validate({
      'cust_name': 'required|String',
      'cust_address': 'required|String',
      'cust_city': 'required|String',
      'cust_state': 'required|String',
      'cust_zip': 'required|String',
      'cust_country': 'required|String',
      'cust_telp': 'required|String',
    }, {
      'cust_name.required': 'Nama tidak boleh kosong',
      'cust_address.required': 'Alamat tidak boleh kosong',
      'cust_city.required': 'Kota tidak boleh kosong',
      'cust_state.required': 'Provinsi tidak boleh kosong',
      'cust_zip.required': 'Kode pos tidak boleh kosong',
      'cust_country.required': 'Negara tidak boleh kosong',
      'cust_telp.required': 'Nomor telepon tidak boleh kosong',
    });

    final dataCustomer = req.input();

    final existingCustomer = await Customer().query().where('cust_id', '=', custId).first();
    if (existingCustomer == null) {
      return Response.json({
        "message": "Customer tidak ditemukan",
      }, 404);
    }

    await Customer().query().where('cust_id', '=', custId).update(dataCustomer);

    return Response.json({
      "message": "Customer berhasil diperbarui",
      "data": dataCustomer,
    }, 200);
  }

  // Method untuk menghapus customer berdasarkan cust_id
  Future<Response> destroy(String custId) async {
    try {
      final customer = await Customer().query().where('cust_id', '=', custId).first();

      if (customer == null) {
        return Response.json({
          'message': 'Customer dengan ID $custId tidak ditemukan',
        }, 404);
      }

      await Customer().query().where('cust_id', '=', custId).delete();
      return Response.json({
        'message': 'Customer berhasil dihapus',
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Terjadi kesalahan saat menghapus customer',
      }, 500);
    }
  }
}

final CustomerController customerController = CustomerController();
