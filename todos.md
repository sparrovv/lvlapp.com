[[TODOs:]]

- [] Add HUD - head up display, that will have some navs, prompts, messages, flash messages....kk
- [] translate whole line, it can be useful in case of phrasals or some expressions with 
- [] Consider switching to google translate - it's about 20bucks for 125000 words, it's not so bad....
- [] ISSUE: After adding gem I Had to stop and start puma, because restart didn't help

- [] When a new line triggers timeouts to volume up, and at the same time I go to the beginning of the line it doesn't seem to clear that interval and bring volume to the max. That's annoying. 

- [] add link to source - so there is no problem
- [] Fix clicking on youtube video:
    - apply strange logic ____ if lineTimeoutService.nextLineTimeout && not lineTimeoutService.volumeInterval ____
    - focus on play 

- [] Finish up the memorize section
     - agree on first version: word | definition / usage in a word / translation .. more
     - For now there gonna be 3 ways to repeat:
       - per video
       - per 10/20 the least known
- [] Memorise - add image search

- [] Game Data score per video and overall user score, so it introduces a way to compete with another users...

- [] Filter what words can be add to the phrasebook, don't add missing ones, and maybe 1 letters, prepare filtter for that, so it decorates it wit...

- [] debug what happens if there are words separated witch commas without space foo,bar  boys like these,younger
- [] validate transcript that after comma or colon, period there is a space
- [] Smarter adding line when adding to phrasebook, whole sentence (from . to . - it can be a problem casue transcript is without periods)

- [] Use postgresql

BUG:

- [] compressed javascript doesn't work

- [] (BUG) Some singularized words shouldn't be singularized and when this is happen it can't find def/transaltion
     Also verbs adjectives shouldn't be singularized.....

- [] smarter feeeling blanks: fix: good bye
- [] Smarter blanks, there is some issue with: "why" whoa, ...

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
- [] it sometimes skips line, I presume that is when it ends volumes down and the new line event is triggered... / That mabye was fixed when I updated smarter newline
- This should be debugged: updateCurrentTimeInterval()
  L
- [] doesn't start transcript - probably the event was triggered late need to find a better wayooks that if this is commentoed out then I can't get it working
- [] setup contact inforamtion
- [] make a footer with disclaimer about videos, contact
- [] Add duration - on adding, or on first show....
- [] TED videos preview images
- [] Maybe line directive ? That would make a lot of sense
- [] While adding phrase, add also line that this word is in
- [] Add featured flag
- [] some problem with sign up that it redirects to non existing page
- [] style sign-up and add native language
  http://www.octolabs.com/posts/2013/1/17/styling_devise_with_twitter_bootstrap
- [] Added favicon, nothing special, but errors in log were irritating

- [] Fix puma server restarts! That's annoying that service unavailable. 
     Switched to TCP socket, hope it will be more reliable.
- [] add friendlyid - slugs http://norman.github.io/friendly_id/file.Guide.html
