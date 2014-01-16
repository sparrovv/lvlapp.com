YOUTUBE

## SOLUTION

I discovered hot to make a request through APIv3. It seems to be reliable, but there is some work that left.

I'd need to add is a cron job, so it can run every day or so.

## Problems - kept only for reference purpose

There are few problems, that should be solved.

1. Some vidoes are removed, because of the copy rights violation
2. There is no eays way to get length of video


1. Video rmeoved
  - In that scenario video should have new state - blocked/disabled/pending/...
  - The check should happend regularly, every day at least.

How to get information about youtube video?

The simplest way is to check url: 

Valid response: 200 http://gdata.youtube.com/feeds/api/videos/IJNR2EpS0jw

Invalid 403, 404.. http://gdata.youtube.com/feeds/api/videos/Lz0jEllqM-0

API:
https://gdata.youtube.com/feeds/api/videos/IJNR2EpS0jw?v=2


