import 'package:tugas_vania/app/models/product.dart';
import 'package:vania/vania.dart';

class ProductController extends Controller {
  Future<Response> create(Request req) async {
    req.validate({
      'prod_id': 'required|String',
      'prod_name': 'required|String',
      'prod_price': 'required',
      'prod_desc': 'required',
      'vend_id': 'required'
    }, {
      'prod_name.required': 'ID tidak boleh kosong',
      'prod_name.string': 'Nama tidak boleh angka',
      'prod_price.required': 'Harga tidak boleh kosong',
      'prod_desc.required': ' Deskripsi tidak boleh kosong',
      'vend_id.required': ' ID vendor tidak boleh kosong',
    });

    final dataProduct = req.input();
    // dataProduct['created_at'] = DateTime.now().toIso8601String();

    final existingProduct =
        await Product().query().where('prod_name', '=', dataProduct['prod_name']).first();
    if (existingProduct != null) {
      return Response.json({
        "message": "Produk sudah ada",
      }, 409);
    }

    await Product().query().insert(dataProduct);

    return Response.json(
      {
        "message": "Success",
        "data": dataProduct,
      },
      200,
    );
  }

  Future<Response> show() async {
    final dataProduct = await Product().query().get();
    return Response.json({
      'message': 'Success',
      'data': dataProduct,
    }, 200);
  }

  Future<Response> update(Request req, String id) async {
    req.validate({
      // 'prod_id': 'required|String',
      'prod_name': 'required|String',
      'prod_price': 'required',
      'prod_desc': 'required',
      'vend_id': 'required'
    }, {
      'prod_name.required': 'ID tidak boleh kosong',
      'prod_name.string': 'Nama tidak boleh angka',
      'prod_price.required': 'Harga tidak boleh kosong',
      'prod_desc.required': ' Deskripsi tidak boleh kosong',
      'vend_id.required': ' ID vendor tidak boleh kosong',
    });

    final dataProduct = req.input();
    // dataProduct['updated_at'] = DateTime.now().toIso8601String();

    final existingProduct =
        await Product().query().where('prod_id', '=', id).first();

    if (existingProduct == null) {
      return Response.json({
        "message": "Produk tidak ditemukan",
      }, 404);
    }

    // Perbarui data produk
    await Product().query().where('prod_id', '=', id).update(dataProduct);

    return Response.json({
      "message": "Produk berhasil diperbarui",
      "data": dataProduct,
    }, 200);
  }

  Future<Response> destroy(String id) async {
    try {
      final product = await Product().query().where('prod_id', '=', id).first();

      if (product == null) {
        return Response.json({
          'message': 'Produk dengan ID $id tidak ditemukan',
        }, 404);
      }

      await Product().query().where('prod_id', '=', id).delete();
      return Response.json({
        'message': 'Produk berhasil dihapus',
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Terjadi kesalahan saat menghapus produk',
      }, 500);
    }
  }
}

final ProductController productController = ProductController();
