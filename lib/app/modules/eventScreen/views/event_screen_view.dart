import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:luxe_desires/app/constants/app_color.dart';
import 'package:luxe_desires/app/constants/contants.dart';
import 'package:luxe_desires/app/constants/theme_controller.dart';
import 'package:luxe_desires/app/data/models/events.dart';
import 'package:luxe_desires/app/pages/event_details_screen.dart';
import '../controllers/event_screen_controller.dart';

class EventScreenView extends StatelessWidget {
  const EventScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(EventScreenController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('Events'),
          centerTitle: true,
          backgroundColor: DarkThemeColor.primary,
        ),
        body: Obx(() => controller.isLoading.value
            ? loader
            : GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                    mainAxisExtent: 270.h),
                itemCount: controller.events.length,
                itemBuilder: (context, index) {
                  return EventCard(event: controller.events[index]);
                },
              )));
  }
}

class EventCard extends StatelessWidget {
  EventCard({
    super.key,
    required this.event,
  });

  final Event event;
  var stars = "4.9";

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final isDark = themeController.isDark.value;
    return Bounce(
      duration: const Duration(milliseconds: 300),
      onPressed: () {},
      child: Container(
        padding: EdgeInsets.all(8.h),
        decoration: BoxDecoration(
            color: !isDark
                ? LightThemeColor.secondaryBackground
                : DarkThemeColor.secondaryBackground,
            borderRadius: BorderRadius.circular(12.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                event.imageUrl,
                height: 150.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              event.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  Icons.star_rounded,
                  color: !isDark
                      ? LightThemeColor.primary
                      : DarkThemeColor.primary,
                  size: 24,
                ),
                Text(
                  '$stars Stars',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EventDetailsScreen(
                                event.imageUrl, event.title, stars)));
                  },
                  child: Text(
                    'View Now',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                const Icon(
                  Icons.navigate_next,
                  color: Colors.black,
                  size: 24,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
