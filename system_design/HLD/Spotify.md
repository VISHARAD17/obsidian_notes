#HLD

#### **Requirements**:

| Functional              | Non Functional    |
| ----------------------- | ----------------- |
| Search and stream songs | Scalable          |
| Create playlist         | Low Latency       |
| Music Recommendatio     | High Availability |
| Add support             | Global Service    |
#### **Estimations**:
- Daily 500M songs
- 
#### **Flows**:
- ***stream_songs***: request goes through the LB to the streaming service which then fetches data from the metadata DB and we can leverage CDN for faster and uninterrupted streaming experience.
- ***Recommend songs*** : request goes through the recommendation service via LB, which uses to cache to faster metadata retrieval.
- ***search songs***:  request goes through the recommendation service via LB, which uses stored indices from song metaData DB to give faster retrieval
- `1` : **Load Balancer** will take request and distribute among the service
- `2` : **Use Service**: handles the user data
	-  somthing

--- 
### Diagram:
![[spotify.excalidraw|1000|center]]