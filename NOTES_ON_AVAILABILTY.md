Upgrading and adding more workers.

Tue 17 Dec 2013

siege -c40 -v -r 10 "http://lvlapp.com/audio_videos?category_id=1&order=popular"


Transactions:                    392 hits      
Availability:                  98.00 %         
Elapsed time:                  25.39 secs      
Data transferred:               1.64 MB        
Response time:                  1.53 secs      
Transaction rate:              15.44 trans/sec 
Throughput:                     0.06 MB/sec    
Concurrency:                   23.56           
Successful transactions:         392           
Failed transactions:               8           
Longest transaction:           12.29           
Shortest transaction:           0.09

Transactions:                    380 hits      
Availability:                  95.00 %         
Elapsed time:                  29.10 secs      
Data transferred:               1.61 MB        
Response time:                  1.96 secs      
Transaction rate:              13.06 trans/sec 
Throughput:                     0.06 MB/sec    
Concurrency:                   25.64           
Successful transactions:         380           
Failed transactions:              20           
Longest transaction:           13.23           
Shortest transaction:           0.08

Transactions:                    399 hits      
Availability:                  99.75 %         
Elapsed time:                  22.38 secs      
Data transferred:               1.66 MB        
Response time:                  1.49 secs      
Transaction rate:              17.83 trans/sec 
Throughput:                     0.07 MB/sec    
Concurrency:                   26.61           
Successful transactions:         399           
Failed transactions:               1           
Longest transaction:            4.52           
Shortest transaction:           0.09



siege -c40 -v -r 10 http://lvlapp.com

Transactions:                    400 hits  
Availability:                 100.00 %     
Elapsed time:                  34.32 secs  
Data transferred:               2.17 MB    
Response time:                  2.39 secs  
Transaction rate:              11.66 trans/sec
Throughput:                     0.06 MB/sec
Concurrency:                   27.80
Successful transactions:         400
Failed transactions:               0
Longest transaction:           17.81
Shortest transaction:           0.11
