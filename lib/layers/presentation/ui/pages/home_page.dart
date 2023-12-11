import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:tractian_app/layers/core/assets.dart';
import 'package:tractian_app/layers/core/constants.dart';
import 'package:tractian_app/layers/presentation/cubits/assets_cubit.dart';
import 'package:tractian_app/layers/presentation/ui/pages/asset_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AssetsCubit _assetsCubit;

  @override
  void initState() {
    _assetsCubit = GetIt.I.get<AssetsCubit>();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: AppBar(
            backgroundColor: darkBlue,
            title: SvgPicture.asset(Assets.logoTractian,),
            centerTitle: true,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
                child: SizedBox(
                  height: 76,
                  width: size.width,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: SvgPicture.asset(Assets.iconButtonHome),
                        ),
                        const Text(
                          "Jaguar Unit",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      _assetsCubit.loadTreeData(buttonId: "jaguar_unit");
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AssetPage(),));
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  height: 76,
                  width: size.width,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: SvgPicture.asset(Assets.iconButtonHome),
                        ),
                        const Text(
                          "Tobias Unit",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      _assetsCubit.loadTreeData(buttonId: "tobias_unit");
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AssetPage(),));
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  height: 76,
                  width: size.width,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: SvgPicture.asset(Assets.iconButtonHome),
                        ),
                        const Text(
                          "Apex Unit",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      _assetsCubit.loadTreeData(buttonId: "apex_unit");
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AssetPage(),));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
