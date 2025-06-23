import 'package:flutter/services.dart';
import 'package:riddhi_clone/resources/toast_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactHandlers {
  static Future<void> makePhoneCall(
    String phoneNumber, {
    required void Function(String) onError,
  }) async {
    if (phoneNumber.isEmpty) {
      onError('Phone number is empty');
      AppToastHelper.showInfo('Phone number is empty');
      return;
    }

    try {
      final phoneUri = Uri(
        scheme: 'tel',
        path: phoneNumber.replaceAll(RegExp(r'[^\d+]'), ''),
      );

      if (!await launchUrl(phoneUri)) {
        onError('Could not launch phone app');
        return;
      }
    } on PlatformException catch (e) {
      onError('Platform error: ${e.message}');
    } catch (e) {
      onError('Error: $e');
    }
  }

  static Future<void> sendEmail(
    String email, {
    required void Function(String) onError,
  }) async {
    if (email.isEmpty) {
      onError('Email is empty');
      AppToastHelper.showInfo('Email is empty');
      return;
    }

    try {
      final emailUri = Uri(
        scheme: 'mailto',
        path: email,
      );

      if (!await launchUrl(emailUri)) {
        onError('Could not launch email app');
        return;
      }
    } on PlatformException catch (e) {
      onError('Platform error: ${e.message}');
    } catch (e) {
      onError('Error: $e');
    }
  }

  static Future<void> openWhatsApp(
    String phoneNumber, {
    required void Function(String) onError,
  }) async {
    if (phoneNumber.isEmpty) {
      onError('Phone number is empty');
      AppToastHelper.showInfo('Phone number is empty');
      return;
    }

    try {
      final cleanPhone = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
      final whatsappUrl = Uri.parse('https://wa.me/$cleanPhone');

      if (!await launchUrl(
        whatsappUrl,
        mode: LaunchMode.externalApplication,
      )) {
        onError('Could not launch WhatsApp');
        return;
      }
    } on PlatformException catch (e) {
      onError('Platform error: ${e.message}');
    } catch (e) {
      onError('Error: $e');
    }
  }

  static Future<void> openMap(
    num latitude,
    num longitude, {
    required void Function(String) onError,
  }) async {
    try {
      if (latitude == 0 || longitude == 0) {
        onError('Latitude or longitude is null');
        AppToastHelper.showInfo('Latitude or longitude is null');
        return;
      }

      final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');

      final canLaunch = await canLaunchUrl(url);

      if (canLaunch) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        onError('Could not launch map');
      }
    } catch (e) {
      onError.call(e.toString());
    }
  }
}
