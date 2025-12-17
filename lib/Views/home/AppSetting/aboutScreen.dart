import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ✅ Sliver AppBar
          SliverAppBar(
            expandedHeight: 160, // Expanded height
            collapsedHeight: 70, // Height after collapse

            pinned: true, // Stays visible when collapsed
            floating: true, // Appears when scrolling up
            snap: false, // Snaps into view (requires floating)

            stretch: true, // Stretch on overscroll
            elevation: 0,

            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,

            centerTitle: true,

            // 🔹 Leading widget
            leadingWidth: 60,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                child: Icon(Icons.info, color: Colors.black),
              ),
            ),

            // 🔹 Title when collapsed
            title: const Text(
              'About',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),

            // 🔹 Actions
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.black),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.black),
                onPressed: () {},
              ),
            ],

            // 🔹 Flexible / Expanded area
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,

              titlePadding: const EdgeInsets.only(bottom: 16),
              title: const Text(
                "About Screen",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              collapseMode: CollapseMode.parallax, // parallax | pin | none

              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/couponlogo.png',
                    fit: BoxFit.cover,
                  ),

                  // Dark overlay for readability
                  Container(color: Colors.black.withOpacity(0.4)),

                  // Custom content
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 50),
                      child: Text(
                        "Everything you need to know",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 Stretch trigger
            onStretchTrigger: () async {
              debugPrint("Sliver stretched!");
            },
          ),

 
        ],
      ),
    );
  }
}
