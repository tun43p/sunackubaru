class GitHubService {
  // final HttpClient _httpClient = HttpClient(
  //   context: SecurityContext.defaultContext,
  // );

  // void getIssuesFromGitHub() {
  //   final Uri uri = Uri.https(
  //     'api.github.com',
  //     '/repos/flutter/flutter/issues',
  //     <String, String>{
  //       'state': 'open',
  //       'sort': 'created',
  //       'direction': 'desc',
  //     },
  //   );

  //   return _httpClient.getUrl(uri).then((HttpClientRequest request) {
  //     request.headers.add(
  //       'Authorization',
  //       'token ${SettingsProvider().gitHubToken}',
  //     );

  //     return request.close();
  //   }).then((HttpClientResponse response) {
  //     return response.transform(utf8.decoder).join();
  //   }).then((String responseBody) {
  //     final List<dynamic> issues = jsonDecode(responseBody);

  //     return issues.map((dynamic issue) {
  //       return Task(
  //         id: issue['id'],
  //         title: issue['title'],
  //         url: issue['html_url'],
  //         createdAt: DateTime.parse(issue['created_at']),
  //         updatedAt: DateTime.parse(issue['updated_at']),
  //       );
  //     }).toList();
  //   });
  // }
}
