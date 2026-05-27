import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/src/models/product.dart';

class ProductService {
  final String _baseUrl = 'https://fakestoreapi.com';

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Falha ao carregar produtos');
      }
    } catch (e) {
      throw Exception('Erro de conexão: \$e');
    }
  }

  Future<List<String>> getCategories() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products/categories'));

      if (response.statusCode == 200) {
        return List<String>.from(jsonDecode(response.body));
      } else {
        throw Exception('Falha ao carregar categorias');
      }
    } catch (e) {
      throw Exception('Erro de conexão: \$e');
    }
  }

  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products/category/\$category'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Falha ao carregar produtos da categoria');
      }
    } catch (e) {
      throw Exception('Erro de conexão: \$e');
    }
  }
}
