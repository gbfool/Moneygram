import 'dart:convert';
import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:moneygram/api/google_auth_client.dart';
import 'package:moneygram/transactions/models/transaction.dart';
import 'package:moneygram/utils/utils.dart';
import 'package:path_provider/path_provider.dart';

class GoogleSignInAPI {
  static final _googleSignIn = GoogleSignIn();
  static Future<GoogleSignInAccount?> login() {
    final googleSignIn =
        GoogleSignIn.standard(scopes: [drive.DriveApi.driveAppdataScope]);
    return googleSignIn.signInSilently();
  }

  static Future<void> upload() async {
    final account = await login();
    print("User account: $account");
    if (account == null) {
      return;
    }
    final authHeaders = await account.authHeaders;
    final authenticateClient = GoogleAuthClient(authHeaders);
    final driveApi = drive.DriveApi(authenticateClient);
    // drive.File file = drive.File.fromJson({"transaction": Utils.getDummyTransaction().toJson()});
    // file.id = "jsonFileName";
    final filename = 'file.txt';
    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // String path = documentsDirectory.path + "/" + filename;
    // var file = await File(path)
    //     .writeAsString(Utils.getDummyTransaction().toJson().toString());

    var transaction = Utils.getDummyTransaction();
    var jsonEncoded = json.encode(transaction.toJson());
    var content = utf8.encode(jsonEncoded);

    // final Stream<List<Transaction>> mediaStream =
    //     Future.value([]).asStream().asBroadcastStream();
    // var media = new drive.Media(mediaStream, 2);
    var media = drive.Media(Stream.value(content), content.length);
    var driveFile = new drive.File(name: filename, parents: ['appDataFolder']);
    var resumableUploadOptions = drive.ResumableUploadOptions();
    final result = await driveApi.files.create(driveFile,
        uploadMedia: media, uploadOptions: resumableUploadOptions);
    print("Upload result: $result");
  }

  static Future<void> readFiles() async {
    print("reading file\n");
    final account = await login();
    if (account == null) {
      return;
    }
    final authHeaders = await account.authHeaders;
    final authenticateClient = GoogleAuthClient(authHeaders);
    final driveApi = drive.DriveApi(authenticateClient);
    var fileList = await driveApi.files.list(spaces: 'appDataFolder');
    var files = fileList.files ?? [];
    for (var file in files) {
      print(file.name);
      await getFileContent(file.id!);
      // await deleteFile(file.name!, file.id!);
      // print(file.)
    }
  }

  static Future<void> deleteFiles() async {
    print("deleting file\n");
    final account = await login();
    if (account == null) {
      return;
    }
    final authHeaders = await account.authHeaders;
    final authenticateClient = GoogleAuthClient(authHeaders);
    final driveApi = drive.DriveApi(authenticateClient);
    var fileList = await driveApi.files.list(spaces: 'appDataFolder');
    var files = fileList.files ?? [];
    for (var file in files) {
      print(file.name);
      await deleteFile(file.name!, file.id!);
      // print(file.)
    }
  }

  static Future<String> getFileContent(String fileId) async {
    final account = await login();
    if (account == null) {
      return "";
    }
    final authHeaders = await account.authHeaders;
    final authenticateClient = GoogleAuthClient(authHeaders);
    final driveApi = drive.DriveApi(authenticateClient);
    var response = await driveApi.files.get(fileId,
        downloadOptions: drive.DownloadOptions.fullMedia,
        $fields: 'items/quotaBytesUsed');
    if (response is! drive.Media) throw Exception("invalid response");
    var decodeString = await utf8.decodeStream(response.stream);
    print("\n-----------------\n");
    print(decodeString);
    print('\n-----------------\n');
    return decodeString;
  }

  static Future<void> deleteFile(String name, String fileId) async {
    final account = await login();
    if (account == null) {
      return;
    }
    final authHeaders = await account.authHeaders;
    final authenticateClient = GoogleAuthClient(authHeaders);
    final driveApi = drive.DriveApi(authenticateClient);
    await driveApi.files.delete(fileId);
    print("\n ${name} deleted -----------------\n");
  }
}
