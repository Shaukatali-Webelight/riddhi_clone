import 'package:flutter/material.dart';
import 'package:master_utility/master_utility.dart';
import 'package:riddhi_clone/features/health_calculator/views/health_calculator_screen.dart';

class MasterUtilityDemoScreen extends StatefulWidget {
  const MasterUtilityDemoScreen({super.key});

  @override
  State<MasterUtilityDemoScreen> createState() => _MasterUtilityDemoScreenState();
}

class _MasterUtilityDemoScreenState extends State<MasterUtilityDemoScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final DebouncerHelper _debouncer = DebouncerHelper();

  @override
  Widget build(BuildContext context) {
    // Initialize size helper
    SizeHelper.setMediaQuerySize(context: context);

    return Scaffold(
      appBar: AppBar(
        title: AutoText(
          text: 'Master Utility Demo',
          style: TextStyle(fontSize: 6.fs),
          maxLines: 1,
        ),
        leading: const IconButton(
          onPressed: NavigationHelper.navigatePop,
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(0.05.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHealthCalculatorSection(),
            SizedBox(height: 0.03.h),
            _buildSizeHelperSection(),
            SizedBox(height: 0.03.h),
            _buildToastSection(),
            SizedBox(height: 0.03.h),
            _buildValidationSection(),
            SizedBox(height: 0.03.h),
            _buildPreferencesSection(),
            SizedBox(height: 0.03.h),
            _buildLoggingSection(),
            SizedBox(height: 0.03.h),
            _buildReadMoreSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthCalculatorSection() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(0.04.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Health Calculator Demo',
              style: TextStyle(
                fontSize: 5.fs,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 0.02.h),
            Text(
              'Based on the awesome-flutter BMI calculator example with modern UI design',
              style: TextStyle(
                fontSize: 3.5.fs,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 0.02.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HealthCalculatorScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.calculate),
                label: const Text('Open Health Calculator'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 0.015.h),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeHelperSection() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(0.04.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Size Helper Demo',
              style: TextStyle(
                fontSize: 5.fs,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 0.02.h),
            Container(
              width: 0.8.w, // 80% of screen width
              height: 0.12.h, // 12% of screen height
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '80% Width x 12% Height',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 4.fs,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Responsive Design',
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

  Widget _buildToastSection() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(0.04.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Toast Helper Demo',
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
                      DoubleClickReduntHelper.handleDoubleClick();
                      ToastHelper.showToast(message: 'Simple Toast Message');
                    },
                    child: const Text('Simple Toast'),
                  ),
                ),
                SizedBox(width: 0.02.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
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

  Widget _buildValidationSection() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(0.04.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Validation Helper Demo',
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

  Widget _buildPreferencesSection() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(0.04.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preferences Helper Demo',
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

  Widget _buildLoggingSection() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(0.04.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Log Helper Demo',
              style: TextStyle(
                fontSize: 5.fs,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 0.02.h),
            ElevatedButton(
              onPressed: () {
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

  Widget _buildReadMoreSection() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(0.04.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Read More Helper Demo',
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
      await PreferenceHelper.setStringPrefValue(
        key: 'demo_email',
        value: _emailController.text,
      );
      await PreferenceHelper.setBoolPrefValue(
        key: 'demo_saved',
        value: true,
      );
      await PreferenceHelper.setIntPrefValue(
        key: 'demo_score',
        value: 100,
      );

      ToastHelper.showCustomToast(
        message: '✅ Data saved successfully!',
        backgroundColor: Colors.green,
      );

      LogHelper.logSuccess('Demo preferences saved successfully');
    } catch (e) {
      LogHelper.logError('Error saving demo preferences: $e');
      ToastHelper.showCustomToast(
        message: '❌ Error saving data',
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> _loadPreferences() async {
    try {
      final email = PreferenceHelper.getStringPrefValue(key: 'demo_email');
      final saved = PreferenceHelper.getBoolPrefValue(key: 'demo_saved');
      final score = PreferenceHelper.getIntPrefValue(key: 'demo_score');

      if (email.isNotEmpty) {
        setState(() {
          _emailController.text = email;
        });

        ToastHelper.showCustomToast(
          message: '✅ Data loaded: Score: $score, Saved: $saved',
          backgroundColor: Colors.blue,
        );

        LogHelper.logInfo('Loaded demo preferences - Email: $email, Score: $score');
      } else {
        ToastHelper.showToast(message: 'No saved data found');
      }
    } catch (e) {
      LogHelper.logError('Error loading demo preferences: $e');
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
