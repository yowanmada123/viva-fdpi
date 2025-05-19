import 'package:flutter/material.dart';

class RequestDetailList extends StatelessWidget {
  final List<String> details;

  const RequestDetailList({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(0),
      separatorBuilder: (context, index) => SizedBox(height: 0),
      itemCount: details.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(Icons.check_circle, size: 18, color: Colors.blue),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(details[index], style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        );
      },
    );
  }
}
