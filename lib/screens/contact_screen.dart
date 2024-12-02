import 'package:flutter/material.dart';
import 'package:webhere/utils/constants/constants.dart';

import '../utils/constants/theme.dart';
import '../widgets/common/app_wrapper.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppWrapper(
      childBuilder: (deviceScreenType, isDarkTheme) {
        return Column(
          children: [
            Expanded(
              child: Center(
                child: Container(
                  width: 500,
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppDetails.contactTitle,
                          style: AppTypography().bodyTextLarge.copyWith(
                                color: isDarkTheme
                                    ? theme.colorScheme.onSurface
                                    : theme.colorScheme.primary,
                              ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: AppDetails.contactName,
                            border: const OutlineInputBorder(),
                            labelStyle: AppTypography().bodyTextSmall,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppDetails.contactNameHint;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: AppDetails.contactEmail,
                            border: const OutlineInputBorder(),
                            labelStyle: AppTypography().bodyTextSmall,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppDetails.contactEmailHint;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _messageController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: AppDetails.contactMessage,
                            border: const OutlineInputBorder(),
                            labelStyle: AppTypography().bodyTextSmall,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppDetails.contactMessageHint;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        OutlinedButton(
                          onPressed: _submitForm,
                          child: Text(
                            AppDetails.contactSubmit,
                            style: AppTypography().buttonTextMedium.copyWith(
                                  color: isDarkTheme
                                      ? theme.colorScheme.onSecondary
                                      : theme.colorScheme.primary,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Here you would typically send the form data to a backend service
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message sent successfully!')),
      );

      // Clear form after submission
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
