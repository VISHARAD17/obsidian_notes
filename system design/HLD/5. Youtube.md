> **Design a video streaming platform like youtube or Netflix or hulu**

### **Requirements**
| Functional                     | Non Functional    |
| ------------------------------ | ----------------- |
| Ability to upload a video fast | Global Servie     |
| Watch a video                  | High Availability |
| Smooth video Streaming         | Scalability       |
|                                | reliability       |
### **Estimations:**
- Lets assume the youtube has 5M daily active users
- users watch 5 videos per day
- 10% of users upload 1 video per day
- Assume the average video size is 300 MB
- total daily space needed : 5M * 10% * 300MB = 150 TB

### **Design :**
- **LB**: evenly distributes load among available servers
- **Object store**: for storing original and encoded videos
- **Queues**: for handling large and concurrent requests
##### **Flows**:
- upload requests goes through the **LB** 
- **Meatadata Cache**: for better performance of video details like description, comments, etc.
- **Video uploading flow**:
	- when upload is requested by user `api/youtube/upload/{user_id}` it goes to upload service via **LB** 
	- upload service stores the original video is a blob storage ( Binary large object storage )
	- once done storing it add the video details like path in the **transcoding queue** , which is then picked up by **transcoding service** to transcode the video for efficient storage.
	- one transcoding is done, **transcoding service** updates the **completion queue** which is being consumed by **completion helper service** which updates the latest metadata after transcoding is done.
- **video streaming flow :**
	- for video streaming **cached metadata** is used and videos are streamed directly video edge locations ( **CDNs**).
	- **Streaming service** helps in managing streaming requests and providing the latest metadata. `api/youtube/stream/{user_id}/{video_id}`
	
---


![[youtube.excalidraw|1000|center]]

--- 

