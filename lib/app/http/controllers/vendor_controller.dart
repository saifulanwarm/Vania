import 'package:tugas_vania/app/models/vendor.dart'; // Ganti dengan model Vendor Anda
import 'package:vania/vania.dart';

class VendorController extends Controller {
  // Membuat data vendor baru
  Future<Response> create(Request req) async {
    req.validate({
      'vend_id': 'required|String',
      'vend_name': 'required|String',
      'address': 'required|String',
      'kota': 'required|String',
      'vend_state': 'required|String',
      'vend_zip': 'required|String',
      'vend_country': 'required|String',
    }, {
      'vend_id.required': 'ID vendor tidak boleh kosong',
      'vend_name.required': 'Nama vendor tidak boleh kosong',
      'vend_name.string': 'Nama vendor harus berupa string',
      'address.required': 'Alamat tidak boleh kosong',
      'kota.required': 'Kota tidak boleh kosong',
      'vend_state.required': 'State tidak boleh kosong',
      'vend_zip.required': 'Kode pos tidak boleh kosong',
      'vend_country.required': 'Negara tidak boleh kosong',
    });

    final dataVendor = req.input();

    // Cek apakah vendor sudah ada
    final existingVendor =
        await Vendor().query().where('vend_id', '=', dataVendor['vend_id']).first();
    if (existingVendor != null) {
      return Response.json({
        "message": "Vendor dengan ID tersebut sudah ada",
      }, 409);
    }

    // Masukkan data vendor baru
    await Vendor().query().insert(dataVendor);

    return Response.json(
      {
        "message": "Vendor berhasil dibuat",
        "data": dataVendor,
      },
      200,
    );
  }

  // Menampilkan semua vendor
  Future<Response> show() async {
    final dataVendor = await Vendor().query().get();
    return Response.json({
      'message': 'Daftar vendor berhasil ditampilkan',
      'data': dataVendor,
    }, 200);
  }

  // Memperbarui data vendor berdasarkan ID
  Future<Response> update(Request req, String id) async {
    req.validate({
      // 'vend_id': 'required|String',
      'vend_name': 'required|String',
      'address': 'required|String',
      'kota': 'required|String',
      'vend_state': 'required|String',
      'vend_zip': 'required|String',
      'vend_country': 'required|String',
    }, {
      // 'vend_id.required': 'ID vendor tidak boleh kosong',
      'vend_name.required': 'Nama vendor tidak boleh kosong',
      'vend_name.string': 'Nama vendor harus berupa string',
      'address.required': 'Alamat tidak boleh kosong',
      'kota.required': 'Kota tidak boleh kosong',
      'vend_state.required': 'State tidak boleh kosong',
      'vend_zip.required': 'Kode pos tidak boleh kosong',
      'vend_country.required': 'Negara tidak boleh kosong',
    });

    final dataVendor = req.input();

    // Cek apakah vendor dengan ID tersebut ada
    final existingVendor =
        await Vendor().query().where('vend_id', '=', id).first();

    if (existingVendor == null) {
      return Response.json({
        "message": "Vendor tidak ditemukan",
      }, 404);
    }

    // Perbarui data vendor
    await Vendor().query().where('vend_id', '=', id).update(dataVendor);

    return Response.json({
      "message": "Vendor berhasil diperbarui",
      "data": dataVendor,
    }, 200);
  }

  // Menghapus vendor berdasarkan ID
  Future<Response> destroy(String id) async {
    try {
      final vendor = await Vendor().query().where('vend_id', '=', id).first();

      if (vendor == null) {
        return Response.json({
          'message': 'Vendor dengan ID $id tidak ditemukan',
        }, 404);
      }

      await Vendor().query().where('vend_id', '=', id).delete();
      return Response.json({
        'message': 'Vendor berhasil dihapus',
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Terjadi kesalahan saat menghapus vendor',
      }, 500);
    }
  }
}

final VendorController vendorController = VendorController();
