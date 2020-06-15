import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WidgetTitle extends StatelessWidget {
  final String strToday;

  WidgetTitle(this.strToday);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'TOYkam DailyTok\n',
                style: Theme.of(context).textTheme.title.merge(
                      TextStyle(
                        color: Color(0xFF325384),
                      ),
                    ),
              ),
              TextSpan(
                text: strToday,
                style: Theme.of(context).textTheme.caption.merge(
                      TextStyle(
                        color: Color(0xFF325384).withOpacity(0.8),
                        fontSize: 10.0,
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String getStrToday() {
  var today = DateFormat().add_yMMMMd().format(DateTime.now());
  var strDay = today.split(" ")[1].replaceFirst(',', '');
  if (strDay == '1') {
    strDay = strDay + "st";
  } else if (strDay == '2') {
    strDay = strDay + "nd";
  } else if (strDay == '3') {
    strDay = strDay + "rd";
  } else {
    strDay = strDay + "th";
  }
  var strMonth = today.split(" ")[0];
  var strYear = today.split(" ")[2];
  return "$strDay $strMonth $strYear";
}
