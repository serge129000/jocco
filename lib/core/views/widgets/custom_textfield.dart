import 'package:flutter/material.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class CustomTextfield extends StatelessWidget {
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool hasGreenColor;
  const CustomTextfield(
      {super.key,
      this.onChanged,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.onSaved,
      this.validator,
      this.keyboardType,
      this.focusNode,
      this.hintText, this.hasGreenColor = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: KeyboardActions(
        config: KeyboardActionsConfig(
            keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
            actions: [
              KeyboardActionsItem(
                focusNode: focusNode ?? FocusNode(),
                toolbarButtons: [
                  (node) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () => node.unfocus(),
                        child: Text(
                          "fait",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    );
                  }
                ],
              ),
            ]),
        child: TextFormField(
          keyboardType: keyboardType,
          onChanged: onChanged,
          focusNode: focusNode,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
          onSaved: onSaved,
          validator: validator,
          decoration: InputDecoration(
            filled: hasGreenColor? true: null,
            fillColor: hasGreenColor? filledSelectedBorder: null,
            enabledBorder: hasGreenColor? OutlineInputBorder(
              borderSide: BorderSide(
                color: filledSelectedBorder
              )
            ): null,
              hintText: hintText,
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: inDeepGreenGrey),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 5)),
          cursorColor: hasGreenColor? inDeepGreenGrey: PrimaryColors.first,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: inDeepGreenGrey
          ),
        ),
      ),
    );
  }
}
