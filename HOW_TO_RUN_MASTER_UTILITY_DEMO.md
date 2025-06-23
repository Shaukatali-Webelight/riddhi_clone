# How to Run Master Utility Demo

## 🚀 Quick Start

Your app already has Master Utility integrated! Here's how to access the demo:

### Option 1: Run the App Normally

1. **Start the app using your preferred flavor:**
   ```bash
   # For development
   flutter run lib/config/flavours/dev/dev.dart
   
   # OR for production
   flutter run lib/config/flavours/prod/prod.dart
   
   # OR for UAT
   flutter run lib/config/flavours/uat/uat.dart
   ```

2. **Access the demo from splash screen:**
   - When the app starts, you'll see the splash screen
   - After 2 seconds, test buttons will appear
   - Click the **🚀 Master Utility Demo** button
   - This will take you to the interactive demo

### Option 2: Run Standalone Demo

If you want to run just the Master Utility demo:

```bash
flutter run lib/master_utility_setup_guide.dart
```

## 📱 What You'll See in the Demo

The demo includes interactive examples of:

### 1. **Size Helper**
- Responsive containers (80% width, 12% height)
- Responsive font sizes with `.fs` extension
- Responsive padding/margins with `.w` and `.h`

### 2. **Toast Helper**
- Simple toast messages
- Custom styled toasts with colors and positioning
- Double-click prevention

### 3. **Validation Helper**
- Real-time email validation
- Disposable email detection
- Debounced input validation

### 4. **Preferences Helper**
- Encrypted data storage
- Save/load different data types (String, Bool, Int)
- Secure preference management

### 5. **Log Helper**
- Info, Success, Warning, Error logs
- Color-coded console output
- Debug information tracking

### 6. **Read More Text Helper**
- Expandable text with "Show more/less"
- Customizable trim lines
- Interactive text expansion

## 🔧 Features Available

Beyond the demo, Master Utility provides:

- **Navigation Helper** - Easy routing
- **Image Picker Helper** - Camera/gallery selection
- **API Helper** - Network request management
- **Dialog Helper** - Action sheets and alerts
- **Cache Network Image Helper** - Optimized image loading
- **Permission Handler** - Easy permission management
- **Date Time Helper** - Custom formatting
- **Email Dispose Helper** - Spam email detection

## 📋 Testing Checklist

When you run the demo, try:

- [ ] **Size Helper**: Notice how elements resize on different screen sizes
- [ ] **Toast Messages**: Test both simple and custom toasts
- [ ] **Email Validation**: Try valid, invalid, and disposable emails
- [ ] **Preferences**: Save data, close app, reopen, and load data
- [ ] **Logging**: Check console for colored log outputs
- [ ] **Read More**: Expand and collapse the text

## 🎯 Integration Status

✅ **Already Integrated in Your App:**
- Master Utility is imported in your main.dart
- MasterUtilityMaterialApp is being used
- PreferenceHelper is initialized with encryption
- API configuration is set up
- Size helper is initialized in splash screen

## 📝 Next Steps

1. **Test the demo** using the steps above
2. **Explore the code** in `lib/features/master_utility_demo_screen.dart`
3. **Use Master Utility helpers** in your existing features
4. **Remove demo button** from splash screen when ready for production

## 🐛 Troubleshooting

If you encounter issues:

1. **Make sure dependencies are installed:**
   ```bash
   flutter pub get
   ```

2. **Clean and rebuild:**
   ```bash
   flutter clean
   flutter pub get
   flutter run lib/config/flavours/dev/dev.dart
   ```

3. **Check console logs** for any error messages

## 📚 Documentation

For complete Master Utility documentation, visit:
https://pub.dev/packages/master_utility

Enjoy exploring the Master Utility package! 🎉 