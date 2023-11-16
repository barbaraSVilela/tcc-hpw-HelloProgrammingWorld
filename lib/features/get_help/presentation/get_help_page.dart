import 'package:flutter/material.dart';
import 'package:tcc_hpw_hello_programming_world/config/themes/app_theme.dart';
import 'package:tcc_hpw_hello_programming_world/features/challenge/domain/entity/challenge.dart';

class GetHelpPage extends StatelessWidget {
  const GetHelpPage({
    super.key,
    required this.challenge,
  });

  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colorScheme.surface,
        foregroundColor: AppTheme.colorScheme.onSurface,
        centerTitle: true,
        title: const Text("Precisa de ajuda?"),
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: AppTheme.colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  challenge.prompt,
                  textAlign: TextAlign.center,
                  style: AppTheme.themeData.textTheme.titleLarge!.copyWith(
                    color: AppTheme.colorScheme.primaryContainer,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Dicas de estudo dadas pela comunidade:",
              style: AppTheme.themeData.textTheme.titleSmall!
                  .copyWith(color: AppTheme.colorScheme.secondary),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                          color: AppTheme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            challenge.helpTips[index],
                            textAlign: TextAlign.center,
                            style: AppTheme.themeData.textTheme.titleSmall!
                                .copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                  separatorBuilder: (_, __) => const SizedBox(height: 5),
                  itemCount: challenge.helpTips.length),
            )
          ],
        ),
      ),
    );
  }
}
