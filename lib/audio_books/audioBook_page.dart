import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ebiblio/audio_books/services/playlist_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/home_provider.dart';
import 'data_podcast.dart';
import 'notifiers/play_button_notifier.dart';
import 'notifiers/progress_notifier.dart';
import 'notifiers/repeat_button_notifier.dart';
import 'page_manager.dart';
import 'services/service_locator.dart';

class AudioBookPage extends StatefulWidget {
  @override
  _AudioBookPageState createState() => _AudioBookPageState();
}

class _AudioBookPageState extends State<AudioBookPage> {
  // @override
  // void initState() {
  //   super.initState();
  //   getIt<PageManager>().init();
  // }
  //
  // @override
  // void dispose() {
  //   getIt<PageManager>().dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Biblio AudioBook'),
      ),
        body: Column(
          children: [
            SizedBox(height: 10,),
            ImageBook(),
            CurrentSongTitle(),
            CurrentSongDescription(),
            // Playlist(),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  AddRemoveSongButtons(),
                  AudioProgressBar(),
                  AudioControlButtons(),
                ],
              ),
            ),

          ],
        ),
      );

  }
}

class CurrentSongTitle extends StatelessWidget {
  const CurrentSongTitle({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<String>(
      valueListenable: pageManager.currentSongTitleNotifier,
      builder: (_, title, __) {
        return Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        );
      },
    );
  }
}

class CurrentSongDescription extends StatelessWidget {
  const CurrentSongDescription({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<String>(
      valueListenable: pageManager.currentSongDescriptionNotifier,
      builder: (_, description, __) {
        return Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(description, style: TextStyle(fontSize: 15,), maxLines: 1, overflow: TextOverflow.ellipsis,),
        );
      },
    );
  }
}

class Playlist extends StatelessWidget {
  const Playlist({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<List<String>>(
      valueListenable: pageManager.playlistNotifier,
      builder: (context, playlistTitles, _) {
        return Container(
          height: 60,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: playlistTitles.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                // color: Colors.deepPurple,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue.shade50,
                          ),
                          child: Center(child: Text('${playlistTitles[index]}'))
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class ImageBook extends StatefulWidget {
  const ImageBook({Key? key}) : super(key: key);

  @override
  State<ImageBook> createState() => _ImageBookState();
}

class _ImageBookState extends State<ImageBook> {



  AnimatedContainer dotIndicator(index) {
    HomeProvider HProvider = Provider.of<HomeProvider>(context, listen: false);
    return AnimatedContainer(
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.all(10),
      duration: const Duration(milliseconds: 400),
      height: 4,
      width: HProvider.currentNum == index ? 22 : 9,
      decoration: BoxDecoration(
        color: HProvider.currentNum == index ? Colors.blue : Colors.grey.shade300,
        // shape: _current == index ? BoxShape.rectangle : BoxShape.circle,
        borderRadius: HProvider.currentNum == index ? BorderRadius.circular(30) : BorderRadius.circular(5),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    HomeProvider HProvider = Provider.of<HomeProvider>(context, listen: false);


    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<List<String>>(
      valueListenable: pageManager.playlistNotifier,
      builder: (context, playlistTitles, _) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                CarouselSlider.builder(
                  options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      aspectRatio: 20/9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: false,
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                      height: 400,
                      onPageChanged: (value, carousel) {
                        setState(() {
                          print(value);
                          if (HProvider.currentNum < value) {
                            HProvider.currentNum = value;
                           pageManager.next();
                          } else {
                            HProvider.currentNum = value;
                            pageManager.previous();
                          }
                        });
                      }
                  ),
                  itemCount: playlistTitles.length,
                  itemBuilder: (BuildContext context, index, realIdx ) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 300,
                          child: Image.asset(allPdItemsContent[index].image, fit: BoxFit.cover,)
                        ),
                      );

                  },


                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      playlistTitles.length,(index) => dotIndicator(index)
                  ),),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AddRemoveSongButtons extends StatelessWidget {
  const AddRemoveSongButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: pageManager.add,
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: pageManager.remove,
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: pageManager.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek: pageManager.seek,
        );
      },
    );
  }
}

class AudioControlButtons extends StatelessWidget {
  const AudioControlButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RepeatButton(),
          PreviousSongButton(),
          PlayButton(),
          NextSongButton(),
          ShuffleButton(),
        ],
      ),
    );
  }
}

class RepeatButton extends StatelessWidget {
  const RepeatButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<RepeatState>(
      valueListenable: pageManager.repeatButtonNotifier,
      builder: (context, value, child) {
        Icon icon;
        switch (value) {
          case RepeatState.off:
            icon = Icon(Icons.repeat, color: Colors.grey);
            break;
          case RepeatState.repeatSong:
            icon = Icon(Icons.repeat_one);
            break;
          case RepeatState.repeatPlaylist:
            icon = Icon(Icons.repeat);
            break;
        }
        return IconButton(
          icon: icon,
          onPressed: pageManager.repeat,
        );
      },
    );
  }
}

class PreviousSongButton extends StatelessWidget {
  const PreviousSongButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HomeProvider HProvider = Provider.of<HomeProvider>(context, listen: false);
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isFirstSongNotifier,
      builder: (_, isFirst, __) {
        return IconButton(
          icon: Icon(Icons.skip_previous),
          // onPressed: (isFirst) ? null : pageManager.previous,
          onPressed: () {
            if(isFirst) {
              null;
            } else {
              pageManager.previous();
              HProvider.currentNum--;
            }
          },
        );
      },
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<ButtonState>(
      valueListenable: pageManager.playButtonNotifier,
      builder: (_, value, __) {
        switch (value) {
          case ButtonState.loading:
            return Container(
              margin: EdgeInsets.all(8.0),
              width: 32.0,
              height: 32.0,
              child: CircularProgressIndicator(),
            );
          case ButtonState.paused:
            return IconButton(
              icon: Icon(Icons.play_arrow),
              iconSize: 32.0,
              onPressed: pageManager.play,
            );
          case ButtonState.playing:
            return IconButton(
              icon: Icon(Icons.pause),
              iconSize: 32.0,
              onPressed: pageManager.pause,
            );
        }
      },
    );
  }
}

class NextSongButton extends StatelessWidget {
  const NextSongButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HomeProvider HProvider = Provider.of<HomeProvider>(context, listen: false);

    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isLastSongNotifier,
      builder: (_, isLast, __) {
        return IconButton(
          icon: Icon(Icons.skip_next),
          // onPressed: (isLast) ? null : pageManager.next,
          onPressed: () {
            if(isLast) {
               null;
            } else {
              pageManager.next();
              HProvider.currentNum++;
            }
          },
        );
      },
    );
  }
}

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isShuffleModeEnabledNotifier,
      builder: (context, isEnabled, child) {
        return IconButton(
          icon: (isEnabled)
              ? Icon(Icons.shuffle)
              : Icon(Icons.shuffle, color: Colors.grey),
          onPressed: pageManager.shuffle,
        );
      },
    );
  }
}
