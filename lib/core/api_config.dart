import 'package:flutter_dotenv/flutter_dotenv.dart';

final ipAddress = dotenv.env['IP_ADDRESS'];
final hostUrl = 'http://$ipAddress:3000';
