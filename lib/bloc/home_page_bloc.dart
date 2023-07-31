import 'package:rxdart/rxdart.dart';
import 'package:woocommerce_app/helper/const.dart';

class HomePageBloc {


  final customerCountFetcher = BehaviorSubject<dynamic>();

  final productCountFetcher = BehaviorSubject<dynamic>();

  final orderCountFetcher = BehaviorSubject<dynamic>();

  final averageSalesValueFetcher = BehaviorSubject<dynamic>();

  final netSalesValueFetcher = BehaviorSubject<dynamic>();

  final totalSalesValueFetcher = BehaviorSubject<dynamic>();


  fetchSalesReports() async {

    var response= await Const.wc_api.getAsync('reports/sales?date_min=2016-05-03&date_max=2020-05-04');
    var totalSales = response[0];
    averageSalesValueFetcher.sink.add(totalSales['average_sales']);
    netSalesValueFetcher.sink.add(totalSales['net_sales']);
    totalSalesValueFetcher.sink.add(totalSales['total_sales']);
  }

  fetchPerModuleCount(String value) async {

    var p = await Const.wc_api.getCountAsync(value);
    if (value == 'customers') {
      customerCountFetcher.sink.add(p['count']);
    } else if (value == 'products') {
      productCountFetcher.sink.add(p['count']);
    } else if (value == 'orders') {
      orderCountFetcher.sink.add(p['count']);
    }
  }
}
