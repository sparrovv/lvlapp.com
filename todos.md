[[TODOs:]]

- [] some problem with sign up that it redirects to non existing page
- [] doesn't start transcript - probably the event was triggered late need to find a better way
- [] add link to source - so there is no problem
- [] style sign-up and add native language
  http://www.octolabs.com/posts/2013/1/17/styling_devise_with_twitter_bootstrap

- [] setup contact inforamtion
- [] make a footer with disclaimer about videos, contact
- [] Add duration - on adding, or on first show....
- [] Add featured flag
- [] Filter what words can be add to the phrasebook, don't add missing ones, and maybe 1 letters, prepare filtter for that, so it decorates it wit...
- [] TED videos preview images
- [] Add HUD - head up display, that will have some navs, prompts, messages, flash messages....kk
  [] Maybe line directive ? That would make a lot of sense
- [] debug what happens if there are words separated witch commas without space foo,bar  boys like these,younger
- [] valdate transcript that after comma or colon, period there is a space
- [] smarter feeeling blanks: fix: good bye

- [] it sometimes skips line, I presume that is when it ends volumes down and the new line event is triggered... / That mabye was fixed when I updated smarter newline
BUG:

- [] Smarter blanks, there is some issue with: "why" whoa, ...
- [] compressed javascript doesn't work

SUGESTIONS:

- key down should skip word as well

FOR Further FUTURE:

-[] spaced repetition - exporting to anki / this should happen sometime in the future, not now

-[] Phrase Book
  -[x] List of phrases per video
  -[] Creating own lists
  -[x] Find some APIs and get usage of word / def / transalation

-[] Shorter Videos
  -[x] youtube music - is short and nice
  -[] self hosting - have no clue what would be performance

-[] Front Page 
  -[]/ with video and lyrics player, at the end examples how to do it
  -[] fiverr - someone will read it
  -[] new format of transcript, where you can indicate what words are missing, instead of randoms

-[] testing ?!
-[] refactoring, more angularjs knowledge I need ?!

DONE

-[x] Make sure that when focus leaves the transcript area, then video stop playing, and keys are not bind.
-[x] Deploy somewhere
  DigitalOcean 146.185.132.161
  ruby 1.9.3, bundler, mysql, git

-[x] It seems that after couple minutes the video won't pause. It says that it paused, but it still playing, with very irritating sound. Looks like a player problem, or the setTiemout issue, but can't see a big connection between setTiemout and this problem.  But maybe it is. Need more information, but definitely it has to be fixed before releasing to public.

- [x] Start game on clicking in youtube video
- [x] generate blanks in callback after start of the player, maybe it's time to introduce lvls
- [x] At the end of video, It would be cool to see something that it saved....
- [x] Time indicator would be usefulllllll
- [x] Number of blanks is incorrect, or something else, but affter tabing it doesn't sum up
  it looks okay, I think that was an issue with metrics that was cleard at start, and me skipping before starting
-[] Add User model
  -[x] Sign in / sign out user
  -[x] Save phrases per users
-[x] Stats 
  -[x] tracking users progress
  -[x] consider adding Time, so we will keep information how long it takes to get all the words.
-[x] Youtube 
  -[x] music / lyrics
  -[x] probably new player
-[x] update videojs when controls are disabled, they still appears on pause. It is fixed on master branch, but not yet released. Will wait couple days and see what is the release process.

- [] When reaching the last line: (in skipWord) Uncaught TypeError: Cannot call method 'clearBuffer' of undefined 
- [] and add views number to the audio_video, so it can be filtered by popularity, all, pagination. Improve nav
- [] how to singularize words before they goes to dict http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html#method-i-singularize
