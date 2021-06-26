import 'package:flutter/material.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_controller.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_status.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/themes/appcolors.dart';
import 'package:payflow/shared/widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({Key? key}) : super(key: key);

  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final controller = BarcodeScannerController();


  @override
  void initState() {
    controller.getAvailableCameras();
    controller.statusNotifier.addListener(() {
      if (controller.status.hasBarcode){
        Navigator.pushReplacementNamed(context, "/insertboleto");
      }
    });
    super.initState();
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Stack(
        children: [
          ValueListenableBuilder<BarcodeScannerStatus>(valueListenable: controller.statusNotifier,
           builder: (_, status, __) {
              if (status.showCamera) {
                return Container(
                  child: controller.cameraController!.buildPreview(),
                );
              } else {
              return Container();
              }
            },
          ),
          RotatedBox(
            quarterTurns: 1,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text("Escaneie o código de barras do boleto", style: AppTextStyles.buttonBackground,),
                leading: BackButton(color: AppColors.background,),
              ),
              body: Column(
                children: [
                  Expanded(child: Container(color: Colors.black,)),
                  Expanded(flex: 2, child: Container(color: Colors.transparent,)),
                  Expanded(child: Container(color: Colors.black,)),
                ],
              ),
              bottomNavigationBar: SetLabelButtons(
                  primaryLabel: "Inserir código do boleto",
                  primaryOnPressed: (){
                    Navigator.pushReplacementNamed(context, "/insertboleto");
                  },
                  secondaryLabel: "Adicionar da galeria",
                  secondaryOnPressed: (){},
                enablePrimaryColor: true,
              ),
            ),
          ),
          ValueListenableBuilder<BarcodeScannerStatus>(valueListenable: controller.statusNotifier,
            builder: (_, status, __) {
              if (status.hasError) {
                return BottomSheetWidget(
                  primaryLabel: "Escanear novamente",
                  primaryOnPressed: (){
                    controller.scanWithCamera();
                  },
                  secondaryLabel: "Digitar código",
                  secondaryOnPressed: (){},
                  title: "Não foi possível identificar o código de barras.",
                  subTitle: "Tente escanear novamente ou digite o código do boleto.",
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
