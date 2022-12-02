import 'dart:convert';
import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:moneygram/account/model/account.dart';
import 'package:moneygram/account/repository/account_repository.dart';
import 'package:moneygram/backup/google_auth_client.dart';
import 'package:moneygram/backup/google_drive_constants.dart';
import 'package:moneygram/category/model/category.dart';
import 'package:moneygram/category/repository/category_repository.dart';
import 'package:moneygram/di/service_locator.dart';
import 'package:moneygram/transactions/models/transaction.dart';
import 'package:moneygram/transactions/repository/transaction_repository.dart';
import 'package:moneygram/utils/utils.dart';
import 'package:path_provider/path_provider.dart';

class GoogleDriveService {
  static GoogleSignInAccount? _account;
  static Future<GoogleSignInAccount?> _getAccount() async {
    if (_account != null) {
      return _account;
    }
    return await _login();
  }

  static Future<GoogleSignInAccount?> _login() {
    final googleSignIn =
        GoogleSignIn.standard(scopes: [drive.DriveApi.driveAppdataScope]);
    return googleSignIn.signInSilently();
  }

  static Future<drive.DriveApi> _getDriveAPI() async {
    final account = await _getAccount();
    print("User account: $account");
    if (account == null) {
      Exception("Account not signin");
    }
    final authHeaders = await account!.authHeaders;
    final authenticateClient = GoogleAuthClient(authHeaders);
    final driveApi = drive.DriveApi(authenticateClient);
    return driveApi;
  }

  static Future<void> upload() async {
    final driveApi = await _getDriveAPI();
    // drive.File file = drive.File.fromJson({"transaction": Utils.getDummyTransaction().toJson()});
    // file.id = "jsonFileName";
    final filename =
        '${GoogleDriveConstants.TRANSACTIONS_FOLDER}/${DateTime.now().millisecondsSinceEpoch}.txt';
    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // String path = documentsDirectory.path + "/" + filename;
    // var file = await File(path)
    //     .writeAsString(Utils.getDummyTransaction().toJson().toString());
    // var transaction = Utils.getDummyTransaction();
    var transactions = await _getPendingTransactions();
    var transactionContent = "";
    for (var t in transactions) {
      transactionContent += json.encode(t.toJson()) + "\n";
    }

    // final Stream<List<Transaction>> mediaStream =
    //     Future.value([]).asStream().asBroadcastStream();
    // var media = new drive.Media(mediaStream, 2);
    await _uploadFile(
        driveApi: driveApi,
        filename: filename,
        textContent: transactionContent);
    for (var t in transactions) {
      t.isSync = true;
      t.save();
    }
  }

  static Future<void> _uploadFile(
      {required String filename,
      required String textContent,
      required drive.DriveApi driveApi}) async {
    var content = utf8.encode(textContent);
    var media = drive.Media(Stream.value(content), content.length);
    var driveFile = drive.File(name: filename, parents: ['appDataFolder']);
    var resumableUploadOptions = drive.ResumableUploadOptions();
    final result = await driveApi.files.create(driveFile,
        uploadMedia: media, uploadOptions: resumableUploadOptions);
  }

  static Future<void> readFiles() async {
    print("reading file\n");
    final driveApi = await _getDriveAPI();
    var fileList = await driveApi.files.list(spaces: 'appDataFolder');
    var files = fileList.files ?? [];
    for (var file in files) {
      print(file.name);
      await getFileContent(file.name!, file.id!);
      // await deleteFile(file.name!, file.id!);
      // print(file.)
    }
  }

  static Future<void> deleteFiles() async {
    print("deleting file\n");
    final driveApi = await _getDriveAPI();
    var fileList = await driveApi.files.list(spaces: 'appDataFolder');
    var files = fileList.files ?? [];
    for (var file in files) {
      print(file.name);
      await deleteFile(file.name!, file.id!);
      // print(file.)
    }
  }

  static Future<String> getFileContent(String name, String fileId) async {
    final driveApi = await _getDriveAPI();
    var response = await driveApi.files.get(fileId,
        downloadOptions: drive.DownloadOptions.fullMedia,
        $fields: 'items/quotaBytesUsed');
    if (response is! drive.Media) throw Exception("invalid response");
    var decodeString = await utf8.decodeStream(response.stream);
    return decodeString;
  }

  static Future<void> deleteFile(String name, String fileId) async {
    final driveApi = await _getDriveAPI();
    await driveApi.files.delete(fileId);
    print("\n ${name} deleted -----------------\n");
  }

  static Future<List<Transaction>> _getPendingTransactions() async {
    List<Transaction> list = [];
    TransactionRepository transactionRepository = locator.get();
    var transactions = await transactionRepository.getAllTransactions(true);
    for (var transaction in transactions) {
      // if it is not synced then only add it to the list for syncing
      if (!transaction.isSync) {
        list.add(transaction);
      }
    }
    return list;
  }

  static Future<List<Category>> _getPendingCategories() async {
    List<Category> list = [];
    CategoryRepository categoryRepository = locator.get();
    var categories = await categoryRepository.categories(isSort: false);
    for (var category in categories) {
      // if it is not synced then only add it to the list for syncing
      if (!category.isSync) {
        list.add(category);
      }
    }
    return list;
  }

  static Future<List<Account>> _getPendingAccounts() async {
    List<Account> list = [];
    AccountRepository accountRepository = locator.get();
    var accounts = await accountRepository.accounts(isSort: false);
    for (var account in accounts) {
      // if it is not synced then only add it to the list for syncing
      if (!account.isSync) {
        list.add(account);
      }
    }
    return list;
  }
}
