class CredentialModel {
  final String username;
  final String password;

  CredentialModel.empty()
      : username = '',
        password = '';

  CredentialModel(this.username, this.password);

  CredentialModel.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}
