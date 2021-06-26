import 'package:flutter/material.dart';
import 'package:payflow/modules/extract/extract_page.dart';
import 'package:payflow/modules/home/home_controller.dart';
import 'package:payflow/modules/meus_boletos/meus_boletos_page.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/themes/appcolors.dart';

class HomePage extends StatefulWidget {
  final UserModel userModel;
  const HomePage({Key? key, required this.userModel}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  final pages = [
    Container(
      child: MeusBoletosPage(),
    ),
    Container(
      child: ExtractPage(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(152),
        child: Container(
          color: AppColors.primary,
          height: 152,
          child: Center(
            child: ListTile(
              title: Text.rich(
                TextSpan(
                    text: "Olá, ",
                    style: AppTextStyles.titleRegular,
                    children: [
                      TextSpan(
                        text: "${widget.userModel.name}",
                        style: AppTextStyles.titleBoldBackground,
                      )]),
              ),
              subtitle: Text(
                "Mantenha suas contas em dia",
                style: AppTextStyles.captionShape,
              ),
              trailing: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(image: NetworkImage("${widget.userModel.photoUrl}"))
                ),
              ),
            ),
          ),
        ),
      ),
      body: pages[controller.currentPage],
      bottomNavigationBar: Container(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                icon: Icon(Icons.home, color: controller.currentPage == 0 ? AppColors.primary : AppColors.body,),
                onPressed: (){
                  controller.setPage(0);
                  setState(() {

                  });
                }
            ),
            GestureDetector(
              onTap: (){
                //Navigator.pushNamed(context, "/insertboleto");
                Navigator.pushNamed(context, "/barcodescanner");
              },
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(
                  Icons.add_box_outlined,
                ),
              ),
            ),
            IconButton(
                icon: Icon(
                    Icons.description_outlined,
                  color: controller.currentPage == 1 ? AppColors.primary : AppColors.body,
                ),
                onPressed: (){
                  controller.setPage(1);
                  setState(() {

                  });
                }
            ),
          ],
        ),
      ),
    );
  }
}
