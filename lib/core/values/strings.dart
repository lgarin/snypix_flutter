abstract class ErrorMessage {
  static const unknownError = 'Unknown error';
  static const badCredentials = 'Bad credentials';
  static const loginFailed = 'Login failed';
  static const unexpectedError = 'Unexpected error';
  static const somethingWrong = 'Something went wrong';
  static const noConnection = 'Cannot connect to server';
}

abstract class ButtonText {
  static const dismiss = 'Dismiss';
  static const confirm = 'Confirm';
  static const cancel = 'Cancel';
}

abstract class AppText {
  static const title = 'Snypix';
}

abstract class MediaCategory {
  static const labels = [
    'News',
    'People',
    'Travel',
    'Fun',
    'Nature',
    'Sport',
    'Awesome',
    'Selfie'
  ];
  static const tokens = labels;
}

abstract class ExtendedMediaCategory {
  static const labels = ['All', ...MediaCategory.labels];
  static const tokens = <String?>[null, ...MediaCategory.tokens];
}
