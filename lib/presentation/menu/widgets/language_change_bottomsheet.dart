import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verum_agro_trading/presentation/widgets/primary_button.dart';
import 'package:verum_agro_trading/theme/theme.dart';
import 'package:verum_agro_trading/utils/enums.dart';

class LanguageChangeBottomSheet extends StatefulWidget {
  const LanguageChangeBottomSheet({
    Key? key,
    required this.selectedLanguage,
  }) : super(key: key);

  final SupportedLanguage selectedLanguage;

  @override
  State<LanguageChangeBottomSheet> createState() =>
      _LanguageChangeBottomSheetState();
}

class _LanguageChangeBottomSheetState extends State<LanguageChangeBottomSheet> {
  late SupportedLanguage currentLanguage;

  @override
  void initState() {
    super.initState();
    currentLanguage = widget.selectedLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.50,
      decoration: const BoxDecoration(
          color: ThemeColors.secondarySurfaceColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // heading and cancel button
            Stack(
              children: [
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Change the language".tr(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                Positioned(
                  top: -13.0,
                  right: 0.0,
                  child: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(
                      Icons.cancel_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),

            // list of languages
            ..._buildListOfLanguages(context),

            // save button
            const SizedBox(
              height: 10,
            ),
            PrimaryButton(
              height: 60,
              width: double.infinity,
              text: "Save".tr(),
              onTap: () {
                context.setLocale(currentLanguage.toLocale());
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Container> _buildListOfLanguages(BuildContext context) {
    return SupportedLanguage.values
        .map((language) => Container(
              margin: const EdgeInsets.all(8.0),
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: ThemeColors.secondaryColor),
                color: language == currentLanguage
                    ? ThemeColors.secondaryColor
                    : ThemeColors.secondarySurfaceColor,
              ),
              child: Center(
                child: ListTile(
                  onTap: () => setState(() {
                    currentLanguage = language;
                  }),
                  selected: language == currentLanguage,
                  selectedColor: ThemeColors.secondaryColor,
                  dense: true,
                  title: Text(
                    language.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ).tr(),
                  trailing: language == currentLanguage
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
            ))
        .toList();
  }
}
