import 'package:flutter/material.dart';

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    Widget? title,
    Widget? secondary,
    ListTileControlAffinity controlAffinity = ListTileControlAffinity.trailing,
    super.key,
    super.onSaved,
    super.validator,
    super.initialValue,
    super.autovalidateMode,
  }) : super(builder: (FormFieldState<bool> state) {
          final subtitle = state.hasError
              ? Text(state.errorText!,
                  style: TextStyle(
                      color: Theme.of(state.context).colorScheme.error))
              : null;
          return CheckboxListTile(
            dense: true,
            secondary: secondary,
            title: title,
            value: state.value,
            onChanged: state.didChange,
            subtitle: subtitle,
            controlAffinity: controlAffinity,
          );
        });
}
