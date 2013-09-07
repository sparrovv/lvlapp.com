TODOs:
-[] Add User model
  -[x] Sign in / sign out user
  -[x] Save phrases per users


-[] Stats consider adding Time, so we will keep information how long it took to get all the words.
-[] Shorter Videos
-[] youtube player

-[] Better Phrase Book 
  -[] Find some APIs and get usage of word / def / transalation
  -[] spatial repetition


BUG:
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



Yo dudes, mam prośbę.

Ostatnio spędziłem troche czasu nad projektem prostej gry edukacyjnej.

Jest jeszcze w fazie ultra-alfa, niemniej chcialbym dostać jakiś feedback, czy koncept tej appki jest jasny, i co Wy byście w niej zobaczyli, zmienili.

Rozumiem też, że nie do końca możecie być targetem, aczkolwiek docenie każdy komentarz.

Nie chce was niczym sugerowac, wiec nie bede więcej pisał.
Dodam tylko, że nie zaimplementowałem konceptu użytkownika, ale to jest jak najbardziej w planach.


