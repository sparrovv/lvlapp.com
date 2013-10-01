TODOs:

- [] Number of blanks is incorrect, or something else, but affter tabing it doesn't sum up
- [] generate blanks in callback after start of the player, maybe it's time to introduce lvls
- [] At the end of video, It would be cool to see something that it saved....
- [] Time indicator would be usefulllllll
- [] Start game on clicking in youtube video
- [] smarter feeeling blanks: fix: good bye


-[] Lyrics Player
  -[] Introduce more lvls

-[] Phrase Book
  -[x] List of phrases per video
  -[] Creating own lists
  -[x] Find some APIs and get usage of word / def / transalation

-[x] Stats 
  -[x] tracking users progress
  -[] consider adding Time, so we will keep information how long it takes to get all the words.

-[] Shorter Videos
  -[x] youtube music - is short and nice
  -[] self hosting - have no clue what would be performance

-[x] Youtube 
  -[x] music / lyrics
  -[x] probably new player

-[] Front Page 
  -[]/ with video and lyrics player, at the end examples how to do it
  -[] fiverr - someone will read it
  -[] new format of transcript, where you can indicate what words are missing, instead of randoms

-[] congratulations at the end

-[] testing ?!
-[] refactoring, more angularjs knowledge I need ?!

BUG:
-[] words with 
-[] When reaching the last line: (in skipWord) Uncaught TypeError: Cannot call method 'clearBuffer' of undefined 
-[] Smarter blanks, there is some issue with: "why"
-[] compressed javascript doesn't work

KNOWN BUGS:

-[] videojs youtube players seems to not work with angular. 
-[] videojs when controls are disabled, they still appears on pause. It is fixed on master branch, but not yet released. Will wait couple days and see what is the release process.

DONE

-[x] Make sure that when focus leaves the transcript area, then video stop playing, and keys are not bind.
-[x] Deploy somewhere
  DigitalOcean 146.185.132.161
  ruby 1.9.3, bundler, mysql, git

-[x] It seems that after couple minutes the video won't pause. It says that it paused, but it still playing, with very irritating sound. Looks like a player problem, or the setTiemout issue, but can't see a big connection between setTiemout and this problem.  But maybe it is. Need more information, but definitely it has to be fixed before releasing to public.

-[] Add User model
  -[x] Sign in / sign out user
  -[x] Save phrases per users

FOR FAR FUTURE:

  -[] spaced repetition - exporting to anki / this should happen sometime in the future, not now
