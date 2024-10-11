import 'package:flutter/material.dart';
import 'package:flutter_awesome_logger/src/models/http_log.dart';
import 'package:flutter_awesome_logger/src/widgets/http_log_page/detail_http_log_page.dart';
import 'package:flutter_awesome_logger/src/widgets/http_log_page/widgets/log_info.dart';

class HttpLogTile extends StatelessWidget {
  const HttpLogTile({
    super.key,
    required this.log,
  });

  final HttpLogEntry log;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailHttpLogPage(
            log: log,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 24,
            ),
            color: Colors.transparent,
            child: Row(
              children: [
                Expanded(child: LogInfo(log: log)),
                const Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.black.withOpacity(0.2),
            height: 1,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
