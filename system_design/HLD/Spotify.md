#HLD

--- start-multi-column: ID_mnj4
```column-settings
Number of Columns: 2
Largest Column: standard
Shadow: disabled
```

**Functional Req**
- Search and stream songs
- create playlist
- Music recommendation
-  Add support

--- column-break ---

**Non-Functional Req**
- Scalable
- Low latency
- High Availability
- Global Service

--- end-multi-column
#### Estimations:
- Daily 500M songs
- 

#### Flows:
- ***stream_songs***: request goes through the LB to the streaming service which then fetches data from the metadata DB and we can leverage CDN for faster and uninterrupted streaming experience.
- ***Recommend songs*** : request goes through the recommendation service via LB, which uses to cache to faster metadata retrieval.
- ***search songs***:  request goes through the recommendation service via LB, which uses stored indices from song metaData DB to give faster retrieval


![[spotify.excalidraw|800|center]]