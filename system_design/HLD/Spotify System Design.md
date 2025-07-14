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
#### Calculation:
- Daily 500M songs

#### Flows:
- ***stream_songs***: request goes through the LB to the streaming service which then fetches data from the metadata DB and we can leverage CDN for faster and uninterrupted streaming experience.
- ***Recommend songs*** : request goes through the recommendation service via LB, which uses to cache to faster metadata retrieval.
- ***flow_3**:


![[spotify.excalidraw|500000000|center]]