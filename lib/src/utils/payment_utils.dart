import 'package:expat_assistant/src/models/payment.dart';
import 'package:expat_assistant/src/models/payment_result.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class PaymentUtils {
  static String caculateTotalInYear(List<PaymentView> payments) {
    double total = 0;
    for (PaymentView paymentView in payments) {
      total += paymentView.amount;
    }
    return total.toString();
  }

  static List<FlSpot> getNumberForChart(List<PaymentView> payments) {
    List<TotalPaymentsMonth> result = [];
    List<FlSpot> spot = [];
    for (int i = 1; i <= 12; i++) {
      result.add(TotalPaymentsMonth(month: i, total: 0.0));
    }
    for (PaymentView paymentView in payments) {
      result
          .firstWhere((result) => result.month == paymentView.createDate[1])
          .total += paymentView.amount / 100000;
    }
    for (TotalPaymentsMonth item in result) {
      print("month" + item.month.toString() + " total" + item.total.toString());
      spot.add(FlSpot(item.month.toDouble() - 1, item.total));
    }
    return spot;
  }

  static String getDateTimeForPayment({List<int> startDateTime}) {
    DateTime _date = DateTime(startDateTime[0], startDateTime[1],
        startDateTime[2], startDateTime[3], startDateTime[4]);
    return DateFormat("dd/MM/yyyy HH:mm").format(_date);
  }
}
