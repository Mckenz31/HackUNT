import 'package:flutter/material.dart';
import 'package:hacktinder/widgets/swipe.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: demo_data.length,
                  controller: _pageController,
                  onPageChanged: (index){
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => OnBoardingContent(
                    image: demo_data[index].image,
                    title: demo_data[index].title,
                    description: demo_data[index].description,
                  ),
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                      demo_data.length,
                      (index) => Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: ActiveStatus(isActive: index == _pageIndex,),
                          )),
                  const Spacer(),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        _pageController.nextPage(
                            duration: const Duration(microseconds: 300),
                            curve: Curves.ease);
                        if(_pageIndex == 2){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Swipe(),
                            ),
                          );
                        }
                      },
                      style:
                          ElevatedButton.styleFrom(shape: const CircleBorder()),
                      child: const Text(">"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActiveStatus extends StatelessWidget {
  const ActiveStatus({
    super.key,
    this.isActive = false,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isActive ? 12 : 4,
      width: 4,
      decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.blue.withOpacity(0.4),
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }
}

class OnBoard {
  final String image, title, description;

  OnBoard(
      {required this.image, required this.title, required this.description});
}

final List<OnBoard> demo_data = [
  OnBoard(
    image: "assets/images/onboard1.jpg",
    title: "Tired of finding partners?",
    description: "You can find colleagues that share that have similar events, and pair up for group work, hackathons, study buddy, or any other academic interest.",
  ),
  OnBoard(
    image: "assets/images/onboard2.jpg",
    title: "Swipe and match",
    description: "Check out various aspects of an individual including their college, major, school year, skillset, description, and more",
  ),
  OnBoard(
    image: "assets/images/onboard3.jpg",
    title: "Succeed together",
    description: "Connect, learn, and excel!",
  ),
];

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent(
      {super.key,
      required this.title,
      required this.image,
      required this.description});

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(
          image,
          height: 250,
        ),
        const Spacer(),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
      ],
    );
  }
}
