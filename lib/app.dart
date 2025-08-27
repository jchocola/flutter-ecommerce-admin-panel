import 'package:admin_panel/common/responsive/screens/desktop_layout.dart';
import 'package:admin_panel/common/responsive/screens/mobile_layout.dart';
import 'package:admin_panel/common/responsive/screens/tablet_layout.dart';
import 'package:admin_panel/common/widgets/roundend_styles/t_rounded_container.dart';
import 'package:admin_panel/screens/dashboard/dahsboard.dart';
import 'package:admin_panel/screens/layouts/responsive_design.dart';
import 'package:admin_panel/screens/layouts/site_layout.dart';
import 'package:admin_panel/util/constants/sizes.dart';
import 'package:admin_panel/util/constants/text_strings.dart';
import 'package:admin_panel/util/routes/app_routes.dart';
import 'package:admin_panel/util/routes/routes.dart';
import 'package:admin_panel/util/theme/scroll.dart';
import 'package:admin_panel/util/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;
    return GetMaterialApp(
      scrollBehavior: const SmoothScrollBehavior(),
      title: TText.appName,
      themeMode: ThemeMode.dark,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      getPages: TAppRoute.page,
      initialRoute: session != null ? TRoutes.dashboard : TRoutes.login,
      unknownRoute: GetPage(name: '/page-not-found', page: () => const Scaffold(body: Center(child: Text('Page not found'),),)),
    );
  }
}

class ResponsiveDesignScreen extends StatelessWidget {
  const ResponsiveDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(desktop:  DashboardScreen(), tablet:  Tablet(), mobile: Mobile(),);
  }
}

class Desktop extends StatelessWidget {
  const Desktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TRoundedContainer(
        height: 450,
        backgroundColor: Colors.blue.withOpacity(0.2),
        child: const Center(child: Text('BOX 1'),),
      ),
      const SizedBox(width: 20,),
       TRoundedContainer(
        height: 450,
        backgroundColor: Colors.blue.withOpacity(0.2),
        child: const Center(child: Text('BOX 1'),),
      ),
      const SizedBox(width: 20,),
       TRoundedContainer(
        height: 450,
        backgroundColor: Colors.blue.withOpacity(0.2),
        child: const Center(child: Text('BOX 1'),),
      ),
      const SizedBox(width: 20,),
      ],
    );
  }
}

class Tablet extends StatelessWidget {
  const Tablet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TRoundedContainer(
        height: 450,
        backgroundColor: Colors.blue.withOpacity(0.2),
        child: const Center(child: Text('BOX 2'),),
      ),
      const SizedBox(width: 20,),
       TRoundedContainer(
        height: 450,
        backgroundColor: Colors.blue.withOpacity(0.2),
        child: const Center(child: Text('BOX 2'),),
      ),
     
      ],
    );
  }
}

class Mobile extends StatelessWidget {
  const Mobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TRoundedContainer(
        height: 450,
        backgroundColor: Colors.blue.withOpacity(0.2),
        child: const Center(child: Text('BOX 3'),),
      ),
   
      ],
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Screen'), centerTitle: true),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Simple Navigwation',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).pushNamed('/second-screen', arguments: 'AFRAS');
              },
              child: const Text('Defualt Nav'),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed:
                  () => Get.toNamed('/second-screen', arguments: 'afras'),
              child: const Text('GetX Navigation'),
            ),
          ),

          const SizedBox(height: 15),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () => Get.toNamed('/second-screen'),
              child: const Text('Pass Data'),
            ),
          ),
        ],
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Screen'), centerTitle: true),
      body: Column(children: [Text(Get.arguments ?? '')]),
    );
  }
}
