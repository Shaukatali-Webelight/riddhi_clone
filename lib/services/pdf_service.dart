// // ignore_for_file: avoid_slow_async_io

// import 'dart:io';

// import 'package:dartz/dartz.dart';
// import 'package:http/http.dart' as http;
// import 'package:master_utility/master_utility.dart';
// import 'package:open_file/open_file.dart' as open_file;
// import 'package:path_provider/path_provider.dart';
// import 'package:riddhi_clone/constants/api_endpoints.dart';
// import 'package:riddhi_clone/constants/pref_keys.dart';
// import 'package:riddhi_clone/constants/type_defs.dart';
// import 'package:riddhi_clone/features/common/models/failure_model.dart';
// import 'package:riddhi_clone/resources/toast_helper.dart';

// class PDFService {
//   PDFService._();
//   static final PDFService instance = PDFService._();

//   /// Gets the Downloads directory path
//   Future<Directory> getDownloadsDirectory() async {
//     return getApplicationCacheDirectory();
//     /*if (Platform.isAndroid) {
//       // Try different paths for Downloads folder on Android
//       final possiblePaths = [
//         '/storage/emulated/0/Download',
//         '/storage/emulated/0/Downloads',
//         '/sdcard/Download',
//         '/sdcard/Downloads',
//       ];

//       for (final path in possiblePaths) {
//         final dir = Directory(path);
//         if (await dir.exists()) {
//           return dir;
//         }
//       }

//       // If none of the standard paths work, try external storage
//       final externalDir = await getExternalStorageDirectory();
//       if (externalDir != null) {
//         final downloadsDir = Directory('${externalDir.path}/Downloads');
//         await downloadsDir.create(recursive: true);
//         return downloadsDir;
//       }
//     } else if (Platform.isIOS) {
//       // On iOS, use Documents directory as Downloads folder concept doesn't exist
//       return getApplicationDocumentsDirectory();
//     }

//     // Fallback to documents directory
//     return getApplicationDocumentsDirectory();*/
//   }

//   /// Checks if PDF already exists in Downloads folder
//   Future<bool> isPDFExists({
//     required String customerId,
//     required String year,
//   }) async {
//     try {
//       final downloadsDir = await getDownloadsDirectory();
//       final fileName = 'ledger_${customerId}_$year.pdf';
//       final filePath = '${downloadsDir.path}/$fileName';
//       final file = File(filePath);

//       LogHelper.logInfo('Checking PDF existence at: $filePath');
//       final exists = await file.exists();
//       LogHelper.logInfo('PDF exists: $exists');

//       return exists;
//     } catch (e) {
//       LogHelper.logError('Error checking PDF existence: $e');
//       return false;
//     }
//   }

//   /// Downloads PDF to Downloads folder
//   FutureEither<String> downloadPDF({
//     required String customerId,
//     required String year,
//   }) async {
//     final accessToken = PreferenceHelper.getStringPrefValue(
//       key: PreferenceKeys.accessToken,
//     );

//     try {
//       final downloadsDir = await getApplicationCacheDirectory(); // Use cache directory as fallback
//       final fileName = 'ledger_${customerId}_$year.pdf';
//       final filePath = '${downloadsDir.path}/$fileName';

//       LogHelper.logInfo('Attempting to download PDF to Downloads folder: $filePath');

//       // Check if PDF already exists
//       final exist = await isPDFExists(
//         customerId: customerId,
//         year: year,
//       );

//       if (exist) {
//         LogHelper.logInfo('PDF already exists for customer $customerId year $year, opening existing file');
//         final openResult = await openPDF(customerId: customerId, year: year);
//         return openResult.fold(
//           left,
//           (success) => right(filePath),
//         );
//       }

//       final headers = {
//         'Authorization': 'Bearer $accessToken',
//         'Content-Type': 'application/json',
//         'Accept': 'application/pdf',
//       };

//       final uri = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.getLedgerPdf(customerId))
//           .replace(queryParameters: {'year': year});

//       LogHelper.logInfo('Making request to: $uri');

//       final response = await http.get(
//         uri,
//         headers: headers,
//       );

//       LogHelper.logInfo('Response status code: ${response.statusCode}');
//       LogHelper.logInfo('Response content length: ${response.bodyBytes.length}');

//       if (response.statusCode == 200) {
//         // Verify we actually received PDF content
//         if (response.bodyBytes.isEmpty) {
//           LogHelper.logError('Received empty response body');
//           AppToastHelper.showError('Received empty PDF file');
//           return left(const Failure(message: 'Received empty PDF file'));
//         }

//         final file = File(filePath);

//         // Ensure directory exists
//         await file.parent.create(recursive: true);

//         await file.writeAsBytes(response.bodyBytes);

//         // Verify file was written successfully
//         final fileExists = await file.exists();
//         final fileSize = await file.length();

//         LogHelper.logSuccess('PDF downloaded to Downloads folder: $filePath');
//         LogHelper.logInfo('File exists after write: $fileExists, Size: $fileSize bytes');

//         if (!fileExists || fileSize == 0) {
//           LogHelper.logError('File was not written properly');
//           AppToastHelper.showError('Failed to save PDF file');
//           return left(const Failure(message: 'Failed to save PDF file'));
//         }

//         // Open the downloaded PDF
//         final openResult = await openPDF(customerId: customerId, year: year);
//         return openResult.fold(
//           (failure) {
//             LogHelper.logWarning('PDF downloaded but failed to open: ${failure.message}');
//             // Still return success since download was successful
//             return right(filePath);
//           },
//           (success) => right(filePath),
//         );
//       } else {
//         LogHelper.logError('Failed to fetch the PDF. Status Code: ${response.statusCode}');
//         LogHelper.logError('Response body: ${response.body}');
//         AppToastHelper.showError('Failed to fetch PDF: ${response.statusCode}');
//         return left(Failure(message: 'Failed to fetch PDF: ${response.statusCode}'));
//       }
//     } catch (e) {
//       LogHelper.logError('Error downloading PDF: $e');
//       AppToastHelper.showError('Error downloading PDF: $e');
//       return left(Failure(message: 'Failed to download PDF: $e'));
//     }
//   }

//   /// Opens PDF file from Downloads folder
//   Future<Either<Failure, bool>> openPDF({
//     required String customerId,
//     required String year,
//   }) async {
//     try {
//       final downloadsDir = await getDownloadsDirectory();
//       final fileName = 'ledger_${customerId}_$year.pdf';
//       final filePath = '${downloadsDir.path}/$fileName';
//       final file = File(filePath);

//       LogHelper.logInfo('Attempting to open PDF at: $filePath');

//       final exists = await file.exists();
//       LogHelper.logInfo('File exists: $exists');

//       if (!exists) {
//         LogHelper.logError('PDF file not found at: $filePath');
//         AppToastHelper.showError('PDF file not found');
//         return left(const Failure(message: 'PDF file not found'));
//       }

//       // Check if file has content
//       final fileSize = await file.length();
//       LogHelper.logInfo('File size: $fileSize bytes');

//       if (fileSize == 0) {
//         LogHelper.logError('PDF file is empty');
//         AppToastHelper.showError('PDF file is empty');
//         return left(const Failure(message: 'PDF file is empty'));
//       }

//       LogHelper.logInfo('Opening PDF file...');
//       final result = await open_file.OpenFile.open(filePath);

//       LogHelper.logInfo('Open file result type: ${result.type}');
//       LogHelper.logInfo('Open file result message: ${result.message}');

//       if (result.type == open_file.ResultType.done) {
//         LogHelper.logSuccess('PDF opened successfully');
//         return right(true);
//       } else {
//         LogHelper.logError('Failed to open PDF: ${result.message}');
//         AppToastHelper.showError('Failed to open PDF: ${result.message}');
//         return left(Failure(message: 'Failed to open PDF: ${result.message}'));
//       }
//     } catch (e) {
//       LogHelper.logError('Error opening PDF: $e');
//       AppToastHelper.showError('Error opening PDF: $e');
//       return left(Failure(message: 'Failed to open PDF: $e'));
//     }
//   }

//   /// Gets the actual file path where PDFs are stored (Downloads folder)
//   Future<String> getDownloadDirectory() async {
//     final downloadsDir = await getDownloadsDirectory();
//     return downloadsDir.path;
//   }

//   /// Shows the directory path where files are stored
//   Future<void> showDownloadLocation() async {
//     try {
//       final path = await getDownloadDirectory();
//       LogHelper.logInfo('PDFs are stored at: $path');
//     } catch (e) {
//       LogHelper.logError('Error getting download location: $e');
//     }
//   }

//   /// Debug method to list all files in Downloads directory
//   Future<void> debugListAllFiles() async {
//     try {
//       final downloadsDir = await getDownloadsDirectory();
//       final directory = Directory(downloadsDir.path);

//       LogHelper.logInfo('=== DEBUG: Files in Downloads folder ${downloadsDir.path} ===');

//       if (!await directory.exists()) {
//         LogHelper.logInfo('Downloads directory does not exist!');
//         return;
//       }

//       final files = await directory.list().toList();
//       LogHelper.logInfo('Total files: ${files.length}');

//       for (final file in files) {
//         final stat = await file.stat();
//         LogHelper.logInfo('${file.path} (${stat.size} bytes, ${stat.type})');
//       }

//       LogHelper.logInfo('=== END DEBUG ===');
//     } catch (e) {
//       LogHelper.logError('Error listing files: $e');
//     }
//   }
// }
