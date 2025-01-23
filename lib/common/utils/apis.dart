import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {
  static String? basuUrl = dotenv.env['BASE_URL'];

  static final String refreshUrl = '$basuUrl/auth/refresh-token';

  static final String login = '$basuUrl/auth/local';
  static final String register = '$basuUrl/auth/local/register';
  static final String products = '$basuUrl/products';
}
