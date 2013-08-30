TODOs:

-[] Make sure that when focus leaves the transcript area, then video stop playing, and keys are not bind.

-[] Stats consider adding Time, so we will keep information how long it took to get all the words.

-[] Add User model
  -[] Save phrases per users
  -[] Find some APIs and get usage of word / def / transalation


-[] Shorter Videos


BUG:

- [] compressed javascript doesn't work
-[] It seems that after couple minutes the video won't pause. It says that it paused, but it still playing, with very irritating sound. Looks like a player problem, or the setTiemout issue, but can't see a big connection between setTiemout and this problem.
But maybe it is. Need more information, but definitely it has to be fixed before releasing to public.



DONE

-[] Deploy somewhere
  DigitalOcean 146.185.132.161
  ruby 1.9.3, bundler, mysql, git
