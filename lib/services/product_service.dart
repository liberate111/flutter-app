import 'package:http/http.dart' as http;

class ProductService {
  Future<http.Response> getProduct() async {
    var url = Uri.parse('https://api.codingthailand.com/api/course');
    var response = await http.get(url);
    return response;
  }
}
