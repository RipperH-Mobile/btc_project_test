
import 'package:btc_project/network/restclient.dart';

abstract class NetworkService {
  RestClient rest;
  NetworkService(this.rest);
}
