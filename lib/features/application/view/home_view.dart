import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauthclean/features/application/bloc/notebloc/note_bloc.dart';
import 'package:firebaseauthclean/features/application/services/colors.dart';
import 'package:firebaseauthclean/features/application/view/note/add_note_view.dart';
import 'package:firebaseauthclean/features/application/view/note/update_note_view.dart';
import 'package:firebaseauthclean/features/application/widgets/home_note_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteBloc(),
      child: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    BlocProvider.of<NoteBloc>(context).add(const GetNoteEvent(uid: '1'));
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser?.email;
    return Scaffold(
      body: Center(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0, end: 1),
                        curve: Curves.easeIn,
                        duration: const Duration(seconds: 1),
                        builder:
                            (BuildContext context, double val, Widget? child) {
                          return Opacity(
                            opacity: val,
                            child: Padding(
                              padding: EdgeInsets.only(top: val * 50),
                              child: child,
                            ),
                          );
                        },
                        child: Text(
                          'Note\nPick Your Notes',
                          style: GoogleFonts.aBeeZee(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: AppColor.headingText),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1.0,
                              blurRadius: 8.0,
                              offset: const Offset(
                                0,
                                8,
                              ),
                            ),
                          ],
                        ),
                        child: IconButton(
                            onPressed: () {
                              BlocProvider.of<NoteBloc>(context)
                                  .add(GetNoteEvent(uid: '1'));
                            },
                            icon: Icon(
                              Icons.refresh,
                              color: AppColor.homePageIcon,
                            )),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1.0,
                              blurRadius: 8.0,
                              offset: const Offset(
                                0,
                                8,
                              ),
                            ),
                          ],
                        ),
                        child: IconButton(
                            onPressed: () {
                              BlocProvider.of<NoteBloc>(context)
                                  .add(NoteLogoutEvent());
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/login', (route) => false);
                            },
                            icon: Icon(
                              Icons.logout,
                              color: AppColor.homePageIcon,
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
            BlocBuilder<NoteBloc, NoteState>(
              // listener: (context, state) {
              //   if (state is NoteAddingState) {
              //     CircularProgressIndicator();
              //   }
              // },
              builder: (context, state) {
                if (state is NoteLoadedState) {
                  return AnimatedBuilder(
                    builder: (context, child) => SlideTransition(
                      position: Tween(
                        begin: const Offset(0, 0.3),
                        end: const Offset(0, 0),
                      ).animate(CurvedAnimation(
                          parent: _animationController,
                          curve: Curves.easeInOut)),
                      child: child,
                    ),
                    animation: _animationController,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height - 200,
                      child: GridView.builder(
                        // scrollDirection: Axis.vertical,
                        // shrinkWrap: true,
                        itemCount: state.notes.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 1.2),
                        itemBuilder: (_, index) {
                          return GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(context, PageConst.updateNotePage,
                                //     arguments: noteLoadedState.notes[index]);
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.bottomToTop,
                                        child: UpdateNotePageWrapper(
                                            note: state.notes[index])));
                              },
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context2) {
                                    return AlertDialog(
                                      title: const Text("Delete Note"),
                                      content: const Text(
                                          "are you sure you want to delete this note."),
                                      actions: [
                                        TextButton(
                                          child: const Text("Delete"),
                                          onPressed: () {
                                            BlocProvider.of<NoteBloc>(context)
                                                .add(NoteDeleteEvent(
                                                    note: state.notes[index]));
                                            Navigator.pop(context);
                                          },
                                        ),
                                        TextButton(
                                          child: const Text("No"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: NoteContainer(
                                  note: state.notes[index].note,
                                  time: DateFormat("dd MMM yyy hh:mm a").format(
                                      state.notes[index].time!.toDate()),
                                  title: state.notes[index].noteId.toString()));
                        },
                      ),
                    ),
                  );
                } else if (state is NoteAddingState) {
                  return Center(
                    child: Container(
                      child: Center(
                        child: Lottie.asset(
                            'assets/json/circular_prograss_indicator.json'),
                      ),
                    ),
                  );
                } else if (state is NoteEmptyState) {
                  return Container(
                    height: 300,
                    width: 300,
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Image.asset('assets/images/note.png'),
                          ),
                        ),
                        const Text(
                          'No Notes',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: AppColor.floatingActionButtonBackground,
        onPressed: () {
          // Navigator.pushNamedAndRemoveUntil(
          //     context, '/newnote', (route) => true);
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: AddNotePageWrapper()));
        },
        child: Icon(
          Icons.add,
          color: AppColor.floatingActionIcon,
        ),
      ),
    );
  }
}
