import 'package:flutter/material.dart';

class IoteeButton extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? labelColor;
  final void Function() onTap;
  final bool enabled;

  const IoteeButton({
    super.key,
    required this.label,
    required this.onTap,
    this.backgroundColor,
    this.enabled = true,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = backgroundColor ?? theme.colorScheme.primary;
    final textColor = labelColor ?? Colors.white;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Material(
        child: InkWell(
          onTap: enabled ? onTap : null,
          splashFactory: InkSplash.splashFactory,
          child: AnimatedContainer(
            height: 50,
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 200),
            color: color.withOpacity(enabled ? 1 : 0.6),
            child: Text(
              label,
              style: TextStyle(
                color: textColor.withOpacity(enabled ? 1 : 0.6),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
