import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';
import 'package:gap/gap.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context); // Handle back button functionality
          },
        ),
        title: Text(
          'Terms & Conditions',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: ListView(
          children: [
            _buildSectionTitle('1. General Terms'),
            _buildSectionContent(
              'Welcome to Frontshop Emporium! We’re delighted to have you here. By accessing or using our platform, '
              'we kindly ask that you review and agree to our terms and conditions. These ensure a safe and seamless '
              'experience for everyone. If you have any concerns or do not agree with these terms, we respect your '
              'choice to refrain from using our platform. Thank you for understanding!',
            ),
            _buildSectionTitle('2. User Terms'),
            _buildSubSectionTitle('Eligibility'),
            _buildSectionContent(
              '• Users must provide accurate and complete information during registration.',
            ),
            _buildSubSectionTitle('User Responsibilities'),
            _buildSectionContent(
              '• Ensure your account details are secure. You are responsible for all activities under your account.\n'
              '• Use the platform in compliance with all applicable laws and regulations.\n'
              '• Do not engage in fraudulent, abusive, or harmful activities, including posting inappropriate content '
              'or exploiting platform features.',
            ),
            _buildSubSectionTitle('Order and Payment'),
            _buildSectionContent(
              '• Orders are confirmed only upon payment.\n'
              '• Prices, discounts, and offers are subject to change without notice.',
            ),
            _buildSectionTitle('3. Vendor Terms'),
            _buildSubSectionTitle('Registration and Eligibility'),
            _buildSectionContent(
              '• Vendors must provide valid business details and adhere to local commerce regulations.\n'
              '• Vendors must be legally registered businesses and provide necessary documentation (e.g., business '
              'licenses, tax identification). The Company reserves the right to approve or deny vendor applications.\n'
              '• Both parties agree to keep proprietary information confidential. Vendor information will not be shared '
              'without consent, except as required by law.',
            ),
            _buildSubSectionTitle('Vendor Responsibilities'),
            _buildSectionContent(
              '• Maintain accurate product descriptions, prices, and inventory levels.\n'
              '• Ensure timely dispatch and delivery of products. Resolve user complaints promptly.\n'
              '• Vendors must ensure that all products meet quality and safety standards.',
            ),
            _buildSectionTitle('4. Delivery Partner Terms'),
            _buildSubSectionTitle('Eligibility'),
            _buildSectionContent(
              '• Delivery Partners must provide valid identification. Delivery Partners must be legally registered entities '
              'or individuals with appropriate licenses and follow all traffic rules and regulations.',
            ),
            _buildSectionTitle('5. Privacy Policy'),
            _buildSectionContent(
              'Frontshop Emporium is committed to protecting your privacy.\n'
              '• We do not sell your data to third parties.\n'
              '• Data may be shared with service providers, delivery partners, and legal authorities as necessary.',
            ),
            _buildSectionTitle('6. Refund Policy'),
            _buildSectionContent(
              '• Products are eligible for a refund if they are defective, damaged during delivery, or not as described.\n'
              '• Requests must be initiated within 7 days of receiving the product.',
            ),
            _buildSectionTitle('7. Support Policy'),
            _buildSectionContent(
              '• For assistance, contact our support team via email or live chat available on the platform.\n'
              '• Support hours: Monday to Friday, 9 AM – 6 PM (local time).',
            ),
            SizedBox(height: 20),

            Gap(20.h),

            // Continue Button
            Gap(20.h),
          ],
        ),
      ),
    );
  }
}

Widget _buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}

Widget _buildSubSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Text(
      title,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  );
}

Widget _buildSectionContent(String content) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(
      content,
      style: TextStyle(fontSize: 14, height: 1.5),
    ),
  );
}
