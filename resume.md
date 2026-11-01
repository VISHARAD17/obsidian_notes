
onecard;

- when I first came i was assigned to handle kyc integration for SMFG lender, which required digilocker integration, selfie, etc.
- then I did this DB migration, scripts I already gave you, then I did code changes for that as well. This experience should sound like I throughly understand DB internals
- then the developer working on SMFG lender left the company, and I handled the entire SMFg lender integration from start to end then prepared it from go alive. secrets, static DB data, etc. 
- after it went live supported it for mutliple weeks till it was stable. during that time I was assigned to implement features like handling refreshable journey stages, Implemented end-to-end encryption layer for secure lender API communication; designed PII data
protection strategy with sensitive field masking in OpenSearch logs and at-rest encryption.
- for offer computation integrated amazon sqs, and kafka for some service to generate offer when new cibil score was pulled for all the active customers on the app ( make it look technical, i did not do much than just integrating bunch of function, but this should loook like a proper software integration task )
- then designed a state machine, which a unified platform that controlls the loan onboarding journey, for complex multi-lender workflow management with automatic retry mechanism, this a unified statemachine lender agnostic, this will allows us to have different journies for diff lenders, with minimal code changes.
- someone else did this copied from his linkedin -> but I need to put this on my name: 
  Engineered an automated re-engagement notification engine for high-drop-off stages in the loan and credit card funnel, significantly improving conversion rates for stalled applications, used distributed redis features to implement this, for this task, mention what real world distributed notification is done for discription. again make it technical 
  
  this is what I've written in my current resume :
  
  Software Engineer — OneCard (FPL Technologies) Aug 2025 – Present · Pune
Architected loan onboarding system for SMFG lender using Java/Micronaut microservices; designed
event-driven architecture generating Rs. 8–10 Cr monthly disbursals with 10% MoM growth.
Built distributed orchestration engine using Uber Cadence with a config-driven finite state machine
for complex multi-lender workflow management with automatic retry mechanisms.
Implemented end-to-end encryption layer for secure lender API communication; designed PII data
protection strategy with sensitive field masking in OpenSearch logs and at-rest encryption.
Engineered asynchronous event processing using Amazon SQS and Kafka for inter-service
communication, enabling reliable callback handling with dynamic load balancing.
Led PostgreSQL migration (<50M records) for RBI compliance using staged batching pattern;
refactored application layer for full backward compatibility.
Integrated third-party APIs (AWS Rekognition, HyperVerge, Digilocker) for biometric verification;
designed abstraction layer migrating 3 active lenders onto a unified platform
- 


![[Pasted image 20260808121832.png]]