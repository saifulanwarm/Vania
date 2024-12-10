import 'package:tugas_vania/app/models/productnotes.dart';
import 'package:tugas_vania/app/models/product.dart';
import 'package:vania/vania.dart';

class ProductNotesController extends Controller {
  // Create a new product note
  Future<Response> create(Request req) async {
    req.validate({
      'note_id': 'required|String',
      'prod_id': 'required|String',
      'note_date': 'required|Date',
      'note_text': 'required',
    }, {
      'note_id.required': 'Note ID tidak boleh kosong',
      'prod_id.required': 'Product ID tidak boleh kosong',
      'note_date.required': 'Tanggal note tidak boleh kosong',
      'note_text.required': 'Teks catatan tidak boleh kosong',
    });

    final dataNote = req.input();

    // Cek apakah produk dengan prod_id ada
    final productExists =
        await Product().query().where('prod_id', '=', dataNote['prod_id']).first();

    if (productExists == null) {
      return Response.json({
        "message": "Produk dengan ID ${dataNote['prod_id']} tidak ditemukan",
      }, 404);
    }

    // Insert data note ke table productnotes
    await Productnotes().query().insert(dataNote);

    return Response.json({
      "message": "Catatan produk berhasil ditambahkan",
      "data": dataNote,
    }, 200);
  }

  // Get all product notes
  Future<Response> show() async {
    final dataNotes = await Productnotes().query().get();
    return Response.json({
      'message': 'Success',
      'data': dataNotes,
    }, 200);
  }

  // Update product note
  Future<Response> update(Request req, String noteId) async {
    req.validate({
      'note_id': 'required|String',
      'prod_id': 'required|String',
      'note_date': 'required|Date',
      'note_text': 'required',
    }, {
      'note_id.required': 'Note ID tidak boleh kosong',
      'prod_id.required': 'Product ID tidak boleh kosong',
      'note_date.required': 'Tanggal note tidak boleh kosong',
      'note_text.required': 'Teks catatan tidak boleh kosong',
    });

    final dataNote = req.input();

    // Cek apakah note dengan note_id ada
    final existingNote =
        await Productnotes().query().where('note_id', '=', noteId).first();

    if (existingNote == null) {
      return Response.json({
        "message": "Catatan dengan ID $noteId tidak ditemukan",
      }, 404);
    }

    // Update catatan produk
    await Productnotes().query().where('note_id', '=', noteId).update(dataNote);

    return Response.json({
      "message": "Catatan produk berhasil diperbarui",
      "data": dataNote,
    }, 200);
  }

  // Delete product note
  Future<Response> destroy(String noteId) async {
    try {
      final note = await Productnotes().query().where('note_id', '=', noteId).first();

      if (note == null) {
        return Response.json({
          'message': 'Catatan dengan ID $noteId tidak ditemukan',
        }, 404);
      }

      await Productnotes().query().where('note_id', '=', noteId).delete();
      return Response.json({
        'message': 'Catatan produk berhasil dihapus',
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Terjadi kesalahan saat menghapus catatan produk',
      }, 500);
    }
  }
}

final ProductNotesController productNotesController = ProductNotesController();
