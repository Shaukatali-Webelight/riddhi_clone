// Master Utility Package Integration Guide for Flutter
// Package: https://pub.dev/packages/master_utility

/*
STEP 1: Add to pubspec.yaml
dependencies:
  master_utility: ^0.0.16

STEP 2: Import in your main.dart and configure
*/

import 'package:flutter/material.dart';
import 'package:master_utility/master_utility.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Master Utility
  await _initializeMasterUtility();

  runApp(const MyApp());
}

Future<void> _initializeMasterUtility() async {
  // Initialize API configuration (replace with your base URL)
  dioClient.setConfiguration('https://api.example.com');

  // Initialize encrypted shared preferences
  await PreferenceHelper.init(encryptionKey: 'your-32-character-encryption-key');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MasterUtilityMaterialApp instead of MaterialApp
    return MasterUtilityMaterialApp(
      title: 'Master Utility Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MasterUtilityExamplesScreen(),
    );
  }
}

class MasterUtilityExamplesScreen extends StatefulWidget {
  const MasterUtilityExamplesScreen({super.key});

  @override
  State<MasterUtilityExamplesScreen> createState() => _MasterUtilityExamplesScreenState();
}

class _MasterUtilityExamplesScreenState extends State<MasterUtilityExamplesScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final DebouncerHelper _debouncer = DebouncerHelper();

  @override
  Widget build(BuildContext context) {
    // IMPORTANT: Initialize size helper in build method
    SizeHelper.setMediaQuerySize(context: context);

    return Scaffold(
      appBar: AppBar(
        title: AutoText(
          text: 'Master Utility Examples',
          style: TextStyle(fontSize: 6.fs), // Responsive font size
          maxLines: 1,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(0.05.w), // 5% of screen width
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Size Helper Examples
            _buildSizeExamples(),

            SizedBox(height: 0.03.h), // 3% of screen height

            // Toast Examples
            _buildToastExamples(),

            SizedBox(height: 0.03.h),

            // Validation Examples
            _buildValidationExamples(),

            SizedBox(height: 0.03.h),

            // Logging Examples
            _buildLoggingExamples(),

            SizedBox(height: 0.03.h),

            // Preferences Examples
            _buildPreferencesExamples(),

            SizedBox(height: 0.03.h),

            // Read More Text Example
            _buildReadMoreExample(),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeExamples() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(0.04.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Size Helper Examples',
              style: TextStyle(
                fontSize: 5.fs, // Responsive font size
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 0.02.h),

            // Responsive container
            Container(
              width: 0.8.w, // 80% of screen width
              height: 0.15.h, // 15% of screen height
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '80% Width x 15% Height',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 4.fs,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Responsive using SizeHelper',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 3.fs,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToastExamples() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(0.04.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Toast Helper Examples',
              style: TextStyle(
                fontSize: 5.fs,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 0.02.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Prevent double clicks
                      DoubleClickReduntHelper.handleDoubleClick();

                      // Show simple toast
                      ToastHelper.showToast(message: 'Simple Toast Message');
                    },
                    child: const Text('Simple Toast'),
                  ),
                ),
                SizedBox(width: 0.02.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Show custom styled toast
                      ToastHelper.showCustomToast(
                        message: 'Custom Styled Toast',
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16,
                        gravity: ToastGravity.CENTER,
                      );
                    },
                    child: const Text('Custom Toast'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValidationExamples() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(0.04.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Validation Helper Examples',
              style: TextStyle(
                fontSize: 5.fs,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 0.02.h),
            TextFormField(
              controller: _emailController,
              focusNode: _emailFocusNode,
              decoration: InputDecoration(
                labelText: 'Email Address',
                border: const OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 0.04.w,
                  vertical: 0.02.h,
                ),
              ),
              validator: ValidationHelper.validateEmail,
              onChanged: (value) {
                // Debounce email validation
                _debouncer.run(() {
                  _checkEmailDisposable(value);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoggingExamples() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(0.04.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Log Helper Examples',
              style: TextStyle(
                fontSize: 5.fs,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 0.02.h),
            ElevatedButton(
              onPressed: () {
                // Different types of logging
                LogHelper.logInfo('This is an info log');
                LogHelper.logSuccess('This is a success log');
                LogHelper.logWarning('This is a warning log');
                LogHelper.logError('This is an error log');

                ToastHelper.showToast(
                  message: 'Logs printed! Check your console',
                );
              },
              child: const Text('Test All Log Types'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferencesExamples() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(0.04.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preferences Helper Examples',
              style: TextStyle(
                fontSize: 5.fs,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 0.02.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _savePreferences,
                    child: const Text('Save Data'),
                  ),
                ),
                SizedBox(width: 0.02.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _loadPreferences,
                    child: const Text('Load Data'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadMoreExample() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(0.04.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Read More Helper Example',
              style: TextStyle(
                fontSize: 5.fs,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 0.02.h),
            const ReadMoreTextHelper(
              'Master Utility is a comprehensive Flutter package that provides all-in-one utility solutions. It includes Size Helper for responsive design, Navigation Helper for easy routing, Image Picker Helper for media selection, Date Time Helper for formatting, Auto Size Text Helper for responsive text, Toast Helper for notifications, Email Dispose checker, Log Helper for debugging, Dialog Helper for alerts, Cache Network Image Helper, Validation Helper, API Helper for network calls, and Shared Preference Helper for local storage.',
              trimLines: 3,
              colorClickableText: Colors.blue,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
              moreStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkEmailDisposable(String email) async {
    if (email.isNotEmpty && ValidationHelper.validateEmail(email) == null) {
      try {
        final result = await EmailDisposeHelper.emailDisposerChecker(email: email);
        final isDisposable = result?.disposable;
        if (isDisposable == true) {
          ToastHelper.showCustomToast(
            message: '⚠️ Disposable email detected!',
            backgroundColor: Colors.orange,
            textColor: Colors.white,
          );
        } else if (isDisposable == false) {
          ToastHelper.showCustomToast(
            message: '✅ Valid email',
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
        }
      } catch (e) {
        LogHelper.logError('Email validation error: $e');
      }
    }
  }

  Future<void> _savePreferences() async {
    try {
      // Save different types of data
      await PreferenceHelper.setStringPrefValue(
        key: 'user_email',
        value: _emailController.text,
      );
      await PreferenceHelper.setBoolPrefValue(
        key: 'is_logged_in',
        value: true,
      );
      await PreferenceHelper.setIntPrefValue(
        key: 'user_score',
        value: 100,
      );
      await PreferenceHelper.setDoublePrefValue(
        key: 'user_rating',
        value: 4.5,
      );

      ToastHelper.showCustomToast(
        message: '✅ Data saved successfully!',
        backgroundColor: Colors.green,
      );

      LogHelper.logSuccess('Preferences saved successfully');
    } catch (e) {
      LogHelper.logError('Error saving preferences: $e');
      ToastHelper.showCustomToast(
        message: '❌ Error saving data',
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> _loadPreferences() async {
    try {
      // Load different types of data
      final email = PreferenceHelper.getStringPrefValue(key: 'user_email');
      final isLoggedIn = PreferenceHelper.getBoolPrefValue(key: 'is_logged_in');
      final score = PreferenceHelper.getIntPrefValue(key: 'user_score');
      final rating = PreferenceHelper.getDoublePrefValue(key: 'user_rating');

      if (email.isNotEmpty) {
        setState(() {
          _emailController.text = email;
        });

        ToastHelper.showCustomToast(
          message: '✅ Data loaded: Score: $score, Rating: $rating, Logged in: $isLoggedIn',
          backgroundColor: Colors.blue,
        );

        LogHelper.logInfo('Loaded preferences - Email: $email, Score: $score');
      } else {
        ToastHelper.showToast(message: 'No saved data found');
      }
    } catch (e) {
      LogHelper.logError('Error loading preferences: $e');
      ToastHelper.showCustomToast(
        message: '❌ Error loading data',
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }
}

/*
ADDITIONAL FEATURES AVAILABLE:

1. IMAGE PICKER:
final result = await ImagePickerHelper.multiMediaPicker();
final customResult = await ImagePickerHelper.customMediaPicker(
  pickerActionType: PickerActionType.camera
);

2. NAVIGATION:
NavigationHelper.navigatePop();
NavigationHelper.navigatePush(route: NewScreen());
NavigationHelper.navigatePushReplacement(route: NewScreen());

3. API CALLS:
final request = APIRequest(
  url: '/api/endpoint',
  methodType: MethodType.GET,
);
final response = await APIService().GetApiResponse(request);

4. DIALOGS:
final result = await DialogHelper.showActionSheet<String>(
  actions: [
    SheetAction(key: 'option1', label: 'Option 1'),
    SheetAction(key: 'option2', label: 'Option 2'),
  ],
);

5. CACHE NETWORK IMAGE:
AppNetworkImage(
  url: 'https://example.com/image.jpg',
  errorWidget: (context, url, error) => Icon(Icons.error),
)

6. DATE TIME FORMATTING:
DateTime.now().toCustomFormatter(formatter: DateTimeFormatter.HOUR_MINUTE)

7. PERMISSION HANDLING:
PermissionHandlerService.handlePermissions(
  type: PermissionType.PHOTO,
  callBack: () {
    // Handle permission granted
  },
)
*/
