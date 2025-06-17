import 'package:flutter/cupertino.dart';

class PolicyDetailRow extends StatelessWidget {

  final String rowName;
  final String rowValue;

  const PolicyDetailRow({super.key, required this.rowName, required this.rowValue});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Text(rowName),
        Spacer(),
        Text(rowValue)
      ],
    );
  }

}