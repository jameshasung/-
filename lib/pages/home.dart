import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management/core/res/color.dart';
import 'package:task_management/core/routes/routes.dart';
import 'package:task_management/pages/community.dart';
import 'package:task_management/widgets/circle_gradient_icon.dart';
import 'package:task_management/widgets/task_group.dart';
import 'mypage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var color = Colors.orange;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Save the world",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CircleGradientIcon(
              onTap: () {
                Navigator.pushNamed(context, Routes.todaysTask);
              },
              icon: Icons.person,
              color: Colors.purple,
              iconSize: 24,
              size: 40,
            ),
          )
        ],
        // leading: Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 10),
        //   child: Container(
        //     width: 50,
        //     height: 50,
        //     decoration: const BoxDecoration(
        //       color: Colors.white,
        //       shape: BoxShape.circle,
        //     ),
        //     child: InkWell(
        //       onTap: () {},
        //       customBorder: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(100),
        //       ),
        //       child: const Icon(
        //         Icons.menu_rounded,
        //       ),
        //     ),
        //   ),
        // ),
      ),
      extendBody: true,
      body: _buildBody(),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.

        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: color[400],
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.4),
                    blurRadius: 10,
                    spreadRadius: 4,
                    offset: const Offset(1, 6),
                  )
                ],
                gradient: AppColors.getDarkLinearGradient(color),
                // borderRadius: BorderRadius.circular(20),
              ),
              child: Text('당신은 환경을 지키는 멋쟁이'),
            ),
            ListTile(
              title: const Text('My page'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MypageScreen()),
                );
              },
            ),
            ListTile(
              title: const Text('Weekly Mission'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Community'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommunityPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Stack _buildBody() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                _taskHeader(),
                const SizedBox(
                  height: 15,
                ),
                buildGrid(),
                const SizedBox(
                  height: 25,
                ),
                _onGoingHeader(),
                const SizedBox(
                  height: 10,
                ),
                const OnGoingTask(),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
        // Positioned(
        //   bottom: 30,
        //   // left: 100.w / 2 - (70 / 2),
        //   right: 30,
        //   child: CircleGradientIcon(
        //     color: Colors.pink,
        //     onTap: () {},
        //     size: 60,
        //     iconSize: 30,
        //     icon: Icons.add,
        //   ),
        // )
      ],
    );
  }

  Row _onGoingHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "다른 사람들 둘러보기 ",
          style: TextStyle(
            color: Colors.purple[300],
            fontWeight: FontWeight.w900,
            fontSize: 29,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CommunityPage()),
            );
          },
          child: Text(
            "더보기",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w900,
            ),
          ),
        )
      ],
    );
  }

  Row _taskHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SelectableText(
          "환경을 지키는 미션",
          style: TextStyle(
            color: Colors.blue[500],
            fontWeight: FontWeight.w900,
            fontSize: 29,
          ),
          toolbarOptions: const ToolbarOptions(
            copy: true,
            selectAll: true,
          ),
        ),
        InkWell(
          onTap: () {},
          child: Text(
            "",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        // IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.add_circle_outline,
        //       color: Colors.blue[400],
        //     ))
      ],
    );
  }

  StaggeredGrid buildGrid() {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      children: const [
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: TaskGroupContainer(
            color: Colors.pink,
            isSmall: true,
            icon: Icons.recycling,
            // taskCount: 10,
            taskGroup: "페트병 라벨 제거",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: TaskGroupContainer(
            color: Colors.orange,
            isSmall: true,
            icon: Icons.recycling_outlined,
            // taskCount: 5,
            taskGroup: "텀블러 사용하기",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: TaskGroupContainer(
            color: Colors.green,
            isSmall: true,
            icon: Icons.nature_people,
            // taskCount: 2,
            taskGroup: "장바구니 사용하기",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: TaskGroupContainer(
            color: Colors.blue,
            isSmall: true,
            icon: Icons.single_bed_sharp,
            // taskCount: 9,
            taskGroup: "배달용기 세척하기",
          ),
        ),
      ],
    );
  }
}

class OnGoingTask extends StatelessWidget {
  const OnGoingTask({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      width: 100.w,
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              color: Colors.blue,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "페트병 라벨 제거",
                style: TextStyle(
                  color: Colors.blue[200],
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "",
                style: TextStyle(
                  color: Colors.blueGrey[900],
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "텀블러 사용",
                style: TextStyle(
                  color: Colors.blue[500],
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "",
                style: TextStyle(
                  color: Colors.blueGrey[900],
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              Text(
                "",
                style: TextStyle(
                  color: Colors.blueGrey[900],
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              Text(
                "장바구니 사용",
                style: TextStyle(
                  color: Colors.blue[700],
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "",
                style: TextStyle(
                  color: Colors.blue[900],
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              Text(
                "",
                style: TextStyle(
                  color: Colors.blueGrey[900],
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              Text(
                "배달용기 세척",
                style: TextStyle(
                  color: Colors.blue[900],
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "",
                style: TextStyle(
                  color: Colors.blueGrey[900],
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BottomNavClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    final firstControlPoint = Offset(size.width * 0.6, 0);
    final firstEndPoint = Offset(size.width * 0.58, 44);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    final secControlPoint = Offset(size.width * 0.55, 50);
    final secEndPoint = Offset(size.width * 0.5, 50);
    path.quadraticBezierTo(
      secControlPoint.dx,
      secControlPoint.dy,
      secEndPoint.dx,
      secEndPoint.dy,
    );

//     path.lineTo(size.width * 0.45, 30);

//     final lastControlPoint = Offset(size.width * 0.45, 20);
//     final lastEndPoint = Offset(size.width * 0.2, 30);
//     path.quadraticBezierTo(
//       lastControlPoint.dx,
//       lastControlPoint.dy,
//       lastEndPoint.dx,
//       lastEndPoint.dy,
//     );

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
