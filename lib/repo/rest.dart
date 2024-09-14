import 'package:http/http.dart' as http;

Future<String> getGcpData(
  int pixels,
  int seconds,
  int nonce,
) async {
  final response = await http.get(
    Uri.https('global-mind.org', '/gcpdot/gcpgraph.php', {
      'pixels': pixels.toString(),
      'seconds': seconds.toString(),
      'nonce': nonce.toString(),
    }),
  );
  // final json = jsonDecode(response.body) as Map;
  return response.body;
}
