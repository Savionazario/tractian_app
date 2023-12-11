import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:tractian_app/layers/core/assets.dart';
import 'package:tractian_app/layers/core/constants.dart';
import 'package:tractian_app/layers/presentation/cubits/assets_cubit.dart';
import 'package:tractian_app/layers/presentation/cubits/assets_state.dart';
import 'package:tractian_app/layers/presentation/ui/widgets/custom_button.dart';
import 'package:tractian_app/layers/presentation/ui/widgets/tree_widget.dart';

class AssetPage extends StatefulWidget {
  const AssetPage({Key? key}) : super(key: key);

  @override
  _AssetPageState createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> {
  late final AssetsCubit _assetsCubit;
  ValueNotifier<String> currentButton = ValueNotifier<String>("");

  @override
  void initState() {
    _assetsCubit = GetIt.I.get<AssetsCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: AppBar(
            backgroundColor: darkBlue,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              "Assets",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 32,
                        child: TextFormField(
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: textFieldColor,
                            contentPadding:
                                const EdgeInsets.only(bottom: 4.0, left: 8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            prefixIcon: const Icon(Icons.search, color: grey, size: 18),
                            hintText: "Buscar Ativo ou Local",
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: grey,
                            ),
                          ),
                          onChanged: (value) {
                            _assetsCubit.loadFilteredTree( seachText: value);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                          color: blue, borderRadius: BorderRadius.circular(3)),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 22,
                      ),
                      // onPressed: () {},
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 32,
                        width: 166,
                        child: ValueListenableBuilder(
                          valueListenable: currentButton,
                          builder: (context, value, child) {
                            var color = Colors.transparent;
                            var textColor = textButtonColor;
                            switch (value) {
                              case "energy":
                                color = Colors.blue;
                                textColor = Colors.white;
                                break;
                              case "alert":
                                color = Colors.transparent;
                                textColor = textButtonColor;
                                break;
                              default:
                                color = Colors.transparent;
                                textColor = textButtonColor;
                                break;
                            }
                            return CustomButton(
                              title: Text(
                                "Sensor de Energia",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: textColor,
                                  height: 0.8,
                                ),
                              ),
                              color: color,
                              icon: SvgPicture.asset(
                                Assets.rayIcon,
                                colorFilter: ColorFilter.mode(
                                  textColor,
                                  BlendMode.srcATop,
                                ),
                              ),
                              onPressed: () {
                                if(currentButton.value == "energy"){
                                  _assetsCubit.loadFilteredTree(seachText: "");
                                  currentButton.value = "";
                                }else{
                                  _assetsCubit.loadFilteredTree(seachText: "energy");
                                  currentButton.value = "energy";
                                }
                                
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      SizedBox(
                        height: 32,
                        width: 94,
                        child: ValueListenableBuilder(
                          valueListenable: currentButton,
                          builder: (context, value, child) {
                            var color = Colors.transparent;
                            var textColor = textButtonColor;
                            switch (value) {
                              case "energy":
                                color = Colors.transparent;
                                textColor = textButtonColor;
                                break;
                              case "alert":
                                color = Colors.blue;
                                textColor = Colors.white;
                                break;
                              default:
                                color = Colors.transparent;
                                textColor = textButtonColor;
                                break;
                            }
                            return CustomButton(
                              title: Text(
                                "Crítico",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: textColor,
                                  height: 0.8,
                                ),
                              ),
                              color: color,
                              icon: SvgPicture.asset(Assets.exclamationIcon, colorFilter: ColorFilter.mode(
                                  textColor,
                                  BlendMode.srcATop,
                                ),),
                              onPressed: () {
                                if(currentButton.value == "alert"){
                                  _assetsCubit.loadFilteredTree(seachText: "");
                                  currentButton.value = "";
                                }else{
                                  _assetsCubit.loadFilteredTree(seachText: "alert");
                                  currentButton.value = "alert";
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<AssetsCubit, AssetsState>(
                  bloc: _assetsCubit,
                  builder: (context, state) {
                    if (state is AssetsLoadingState) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (state is AssetsErrorState) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Text(state.errorMessage, textAlign: TextAlign.center,),
                      );
                    }
                    if(state is AssetsEmptyListState){
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Text(state.emptyMessage, textAlign: TextAlign.center,),
                        ),
                      );
                    }
                    state = state as AssetsSucessfulState;

                    return TreeWidget(treeNodes: state.treeNodes);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
