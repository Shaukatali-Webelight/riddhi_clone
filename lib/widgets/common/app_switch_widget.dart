import 'package:flutter/material.dart';
import 'package:riddhi_clone/config/assets/colors.gen.dart';
import 'package:riddhi_clone/constants/app_dimensions.dart';

//* Customized app switch
class AppSwitch extends StatefulWidget {
  //* Customized app switch
  const AppSwitch({required this.onToggled, this.toggleValue = false, super.key});

  //* bool function for app switch
  final void Function({required bool isToggled}) onToggled;

  //* toggle value
  final bool toggleValue;

  @override
  State<AppSwitch> createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch> {
  ValueNotifier<bool> isSwitchOn = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    isSwitchOn.value = widget.toggleValue;
    return ValueListenableBuilder(
      valueListenable: isSwitchOn,
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () {
            isSwitchOn.value = !isSwitchOn.value;
            widget.onToggled(isToggled: isSwitchOn.value);
          },
          onPanEnd: (b) {
            isSwitchOn.value = !isSwitchOn.value;
            widget.onToggled(isToggled: isSwitchOn.value);
          },
          child: AnimatedContainer(
            height: AppConst.k22,
            width: AppConst.k40,
            padding: const EdgeInsets.symmetric(horizontal: AppConst.k3, vertical: AppConst.k2),
            alignment: isSwitchOn.value ? Alignment.centerRight : Alignment.centerLeft,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutBack,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConst.k100),
              color: isSwitchOn.value ? AppColors.primary : AppColors.white,
              border: Border.all(
                color: isSwitchOn.value ? AppColors.primary : AppColors.grayMid,
              ),
            ),
            child: Container(
              width: AppConst.k18,
              height: AppConst.k18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSwitchOn.value ? AppColors.white : AppColors.grayMid,
              ),
            ),
          ),
        );
      },
    );
  }
}
