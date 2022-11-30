import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:moneygram/api/google_auth_client.dart';

class GoogleSignInAPI {
  static final _googleSignIn = GoogleSignIn();
  static Future<GoogleSignInAccount?> login() {
    final googleSignIn =
        GoogleSignIn.standard(scopes: [drive.DriveApi.driveScope]);
    return googleSignIn.signIn();
  }

  static Future<void> upload() async {
    final account = await login();
    if (account == null) {
      return;
    }
    final authHeaders = await account.authHeaders;
    final authenticateClient = GoogleAuthClient(authHeaders);
    final driveApi = drive.DriveApi(authenticateClient);
    final Stream<List<int>> mediaStream =
        Future.value([104, 105]).asStream().asBroadcastStream();
    var media = new drive.Media(mediaStream, 2);
    var driveFile = new drive.File();
    driveFile.name = "hello_world.txt";
    final result = await driveApi.files.create(driveFile, uploadMedia: media);
    print("Upload result: $result");
  }
}
