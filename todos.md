# TODOs - Move it to github issues

- [] Add duration - youtube API
- [] restarted game doesn't refresh stats when you're signed off.

- [] editing doesn't work for TED videos
- [] stats page link from the game
   - consider informing about the % of the guessed words at the end
   - Page with the points explained
   - Validation that there won't be more than x points per person
   - Global Profile points object - so the points are visible on every page...

- [] Memorise - Finish up agree on first version: word | definition / usage in a word / translation .. more
  - [] better design

- [] On click inside the transcript there always should be focus, and maybe some indication that the focus is in?

- [] [bug] guessing one word before the last one makes it instantly switch to the last line.
- [] game menu seems not to be over youtube on ie sometimes....
- [] add terms of service
- [] help should be somehow visible or possible to access when playing game....
- [] puppet
  - ruby 2.0
  - runit
  - postgresql
  - deploy account
  - nginx

VERSION 2

- [] Add possibility for a text selection, so you can add expressions to your phrasebook- http://jsfiddle.net/qY7gE/
- [] Add printable version with blanks - This could be valuable for teachers who want to print the text and give it in the class
- [] On hove on thumbnail show already the dificulty that you want to play with
- [] Use postgresql
- [] smarter filing in blanks: fix: good bye
- [] Smarter blanks, there is some issue with: "why" whoa, ...

- [] Memorize - 2nd version 
  - [] edit and your own stuff
  - [] add image search
  - [] last 20 unknown
  - [] Smarter adding line when adding to phrasebook, whole sentence (from . to . - it can be a problem casue transcript is without periods)
  - [] translate whole line, it can be useful in case of phrasal verbs or expressions.
- [] add "go to the end / finish" when is the last line, and there is still plenty video to finsihed, becasue of ....
- [] Consider switching to google translate - it's about 20bucks for 125000 words, it's not so bad....
- [] On Smylek's designs there was way to start a video from the browse section - nice, but not very necessary

BUGS:
- [] After adding gem I Had to stop and start puma, because restart didn't help
- [] compressed javascript doesn't work


Suggestions: 

- [] spaced repetition - exporting to anki / this should happen sometime in the future, not now

- [] Phrase Book
  -[x] List of phrases per video
  -[] Creating own lists
  -[x] Find some APIs and get usage of word / def / transalation

DONE

- [x] Make sure that when focus leaves the transcript area, then video stop playing, and keys are not bind.
- [x] Deploy somewhere
  DigitalOcean 146.185.132.161
  ruby 1.9.3, bundler, mysql, git

- [x] It seems that after couple minutes the video won't pause. It says that it paused, but it still playing, with very irritating sound. Looks like a player problem, or the setTiemout issue, but can't see a big connection between setTiemout and this problem.  But maybe it is. Need more information, but definitely it has to be fixed before releasing to public.

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
- [] Add HUD - head up display, that will have some navs, prompts, messages, flash messages....kk
- [] when adding audio video there was Slug errors - mysql indexes....
- [] (BUG) Some singularized words shouldn't be singularized and when this is happen it can't find def/transaltion
     Also verbs adjectives shouldn't be singularized.....

- [] Fix clicking on youtube video:
    - focus on play 

- [] add link to source - so there is no problem
- [] alwyas focus on start...
- [] remove singularizing phraes... ambigous -> ambigou ...
- [] Filter what words can be add to the phrasebook, 
    - don't add missing ones, 
    - allow hypen/dash
    - and maybe 1 letters, prepare filtter for that, so it decorates it wit...
- [] Stats - Game Data score per video and overall user score, so it introduces a way to compete with another users...
- [] When a new line triggers timeouts to volume up, and at the same time I go to the beginning of the line it doesn't seem to clear that interval and bring volume to the max. That's annoying.

- [] debug what happens if there are words separated witch commas without space foo,bar  boys like these,younger
- [] validate transcript that after comma or colon, period there is a space
- [] shorten video titles add dots ....
- [] Add sitemap xml generator
- [] Style game menus over the video - seems to work when it has absolutes values.
     There's
- [] Add integrations tests - just to be certain that everything works.
- [] fonts not loading -----
- [] when karaoke mode don't show points...
- [] improve controls - make proper icons
- [] Add twitter/facebook/g+ buttons to like
- [] Consider moving to 960 - looks really awful on bad dimensions
- [] switch to non sticky footer
- [] line down when the current one has some missing words should trigger skip all words
- [] pagination
- [] add "how-it-works" page, copy, etc
  - add images
  - add to google index

- [] like facebook button on first page
- [] Fix the learn iritating issues:
   - video takes to learn
   - save and exit takes you to the index page
   ...
- [] notice that doesn't work on mobiles
- [] check the performance of the site AB

- fix minor styles / ted border / stats.. check out asciicasts 

- move "logo" to the right a bit
- sign in/up colors


- [] change pass on the box
- [] Implement layout improvements
  - some small things left

- [] youtube video start seems not to be triggered ?  ---- hard to reproduce on my machine
- [] Talking with youtube and validating that video is still available....
- [] Add cron job to check if youtube video is available
