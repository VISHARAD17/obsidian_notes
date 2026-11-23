---
title: "Top 13 Microservices Interview Questions Answered"
source: "https://newsletter.systemdesign.one/p/microservices-interview-questions"
author:
  - "[[Neo Kim]]"
published: 2026-11-20
created: 2026-11-21
description: "Master microservices interview questions with practical answers, real-world examples, common mistakes, and expert tips to ace your next system design interview."
tags:
  - "clippings"
---

Here are the top 13 must-know interview questions with answers:

## 1\. Microservices

> “What problems do microservices solve & what new problems do they create?”

Microservices split one application into small services, each running in its own process and deployed independently.

An online shop might run separate services for catalog, cart, payments, and shipping. Each has its own code, data, and release schedule. Services talk over the network through application programming interfaces (**APIs**).

A small group of engineers owns each service from design to production.

[![](https://substackcdn.com/image/fetch/$s_!U5pc!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F4f32ced5-e6e5-41f6-9a2e-2782bbef51c7_1536x1024.png)](https://substackcdn.com/image/fetch/$s_!U5pc!,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F4f32ced5-e6e5-41f6-9a2e-2782bbef51c7_1536x1024.png)

### Tips for a strong answer

- They solve coordination problems. Each group ships its own service without waiting for a shared release.
- Also they let you scale each service independently. A busy search service gets more instances while the rest stay small.
- Yet they create network problems. Every call can be slow, fail, or arrive twice.
- Plus, they create data problems. No single database transaction spans services, so you need sagas or eventual consistency.
- And they need tooling before the first service goes live: service discovery, tracing, and automated deployment.

### Likely follow-up

> “How do you decide where to draw the line between two services?”

Split along business capabilities, such as payments/shipping, not technical layers.

Each service should own its data and change for one business reason. If two services always deploy “together or call each other” on every request, they belong in one service.

### Common mistake

Listing only the benefits.

This question tests whether you know the costs. “Microservices are more scalable” with no mention of network failures or split data sounds like you’ve only read about them.

Strong candidates also say when not to use them, such as a small product with a handful of engineers.

## 2\. API gateway

> “What’s the difference between an API gateway & a load balancer?”

An API gateway is a single entry point that receives every client request and routes it to the right service.

The gateway handles the work every request needs. It checks the token, applies rate limits, and validates the request. Then it finds the target service and forwards the call.

It also merges several service responses into one reply for the client.

[![](https://substackcdn.com/image/fetch/$s_!VvCP!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Ff0677ec0-6bae-49ee-83a1-dc3e852287bf_1536x1024.png)](https://substackcdn.com/image/fetch/$s_!VvCP!,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Ff0677ec0-6bae-49ee-83a1-dc3e852287bf_1536x1024.png)

### Tips for a strong answer

- A load balancer spreads traffic across copies of one service.
- While a gateway reads paths, headers, and tokens, then decides which service gets the request.
- They work together. A load balancer sits in front of several gateway instances.

### Likely follow-up

> “Your gateway is becoming a bottleneck. What do you do?”

Keep the gateway stateless and run more instances behind the load balancer.

Cache token checks. Move heavy work like response merging into “backend for frontend”. If it’s still too much, split the gateway by domain.

### Common mistake

Putting business rules in the gateway, such as discount logic.

The gateway then changes with every feature and needs every group’s sign-off, which recreates the enterprise service bus problem.

## 3\. Service discovery

> “Compare client-side and server-side service discovery.”

Service discovery is how a caller finds a healthy instance of the service it wants to reach.

In *client-side* discovery, the caller queries the registry itself. It gets a list of instances and picks one.

In *server-side* discovery, the caller sends the request to a router/gateway. The router then queries the registry and forwards the call.

[![](https://substackcdn.com/image/fetch/$s_!mA4t!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F62f5f528-f6f1-4874-9210-57c06c518f77_1536x1024.png)](https://substackcdn.com/image/fetch/$s_!mA4t!,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F62f5f528-f6f1-4874-9210-57c06c518f77_1536x1024.png)

### Tips for a strong answer

- Client-side: one less network hop & callers can pick smarter routes.
- But client-side needs a discovery library in every language you use.
- Server-side: callers stay simple as the router does the lookup.
- Yet the router adds an extra hop and must keep its address cache in sync.

### Likely follow-up

> “Which would you use on Kubernetes?”

Server-side, since it’s built in.

Each Service gets a stable DNS name, and the platform routes to healthy pods. A client-side library adds little there. If you need smarter routing, a service mesh[^1] adds it without code changes.

### Common mistake

Mixing up the registry and discovery.

The registry stores where instances live… Discovery is how a caller uses it.

Treating them as one thing makes the answer vague.

## 4\. Database per service

> “Order service needs customer details stored in customer database. How does it get them?”

Database per service means each service owns its data store, and other services reach data only through the owner’s API.

Order service owns the orders database. If shipping needs order details, it calls the order API or listens for order events. Each service can also pick the store that suits it best.

Search might use Elasticsearch while payments stays on PostgreSQL.

[![](https://substackcdn.com/image/fetch/$s_!J9p3!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F522a8c07-cef2-44b1-9e07-eaf1abf6dae9_1536x1024.png)](https://substackcdn.com/image/fetch/$s_!J9p3!,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F522a8c07-cef2-44b1-9e07-eaf1abf6dae9_1536x1024.png)

### Tips for a strong answer

- Never read another service’s tables directly!
- Instead, call the customer API when you need fresh data.
- Or keep a local read copy, updated from customer events for speed & resilience.
- Tradeoff: API call is fresh but adds a runtime dependency, while a local copy is fast but slightly stale.
- For reports across services, feed a separate read store from events.

### Likely follow-up

> “How do you make sure the event goes out whenever the data changes?”

Use the transactional outbox pattern[^2]:

Write the change and the event into the same local transaction, with the event in an outbox table. A separate relay reads the outbox and publishes each event.

This avoids a commit that succeeds while the publish fails.

### Common mistake

Saying services could share one database as long as each uses its own tables. A shared database still *couples* schema changes, load, and outages across services.

## 5\. Saga

> “A customer places an order. You need to reserve stock, charge the card, and book delivery. Yet each step lives on a different service. How do you keep data correct?”

A saga splits one long transaction into a chain of local transactions, each with an undo step called a “compensating transaction".

An order saga might reserve stock, charge the card, and book delivery. Each step commits in its own service right away. If delivery booking fails, the saga runs compensations in reverse.

It refunds the card & releases the stock.

[![](https://substackcdn.com/image/fetch/$s_!v6XR!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F0b71e67d-0d6d-4e5b-a63b-c4e0a78b11c5_1536x1024.png)](https://substackcdn.com/image/fetch/$s_!v6XR!,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F0b71e67d-0d6d-4e5b-a63b-c4e0a78b11c5_1536x1024.png)

### Tips for a strong answer

- Explain why one database transaction cannot span three services.
- Explain why two-phase commit[^3] is a poor fit: *long locks across services hurt availability.*
- Walk through the saga: *each step commits locally, each has a compensating step.*
- Name both styles of Saga. In “choreography”, services react to each other’s events. In “orchestration”, one orchestrator tells each service what to do next.

### Likely follow-up

> “What happens if the refund itself fails?”

Retry the compensation until it succeeds; every compensation must be idempotent[^4]. Plus, store the saga’s state, so a crash can resume from the last step.

If retries keep failing, raise an alert for manual handling.

### Common mistake

Saying a saga keeps data consistent at every moment.

Other requests can see half-finished states between steps. Strong candidates say how they’d handle this, such as marking the order “pending” until the saga completes.

## 6\. Circuit breaker

> “Your order service calls a payment service. Payment starts timing out. What happens to the order service, and how do you protect it?”

A circuit breaker stops calls to a failing service once errors cross a threshold, then lets a few test calls through later.

The breaker starts closed and calls flow normally. When failures pass a set rate, it trips open. Every call now fails fast without touching the broken service. After a cooldown, it moves to half-open and allows a few test calls.

Success closes it again, but failure opens it again.

[![](https://substackcdn.com/image/fetch/$s_!DsIx!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fba629b22-6396-4702-b9c0-f85dd8e9bb06_1536x1024.png)](https://substackcdn.com/image/fetch/$s_!DsIx!,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fba629b22-6396-4702-b9c0-f85dd8e9bb06_1536x1024.png)

### Tips for a strong answer

- Threads in the order service wait on slow payment calls, pile up, and the order service fails as well.
- A circuit breaker trips once the failure rate crosses a threshold, so calls fail fast.
- Name the three states: *closed, open, and half-open*.
- Pair the breaker with a timeout and a fallback. On its own, it only turns slow errors into fast ones.

### Likely follow-up

> “How do you pick the threshold?”

Start from real traffic data.

Use a failure rate over a sliding window, not a raw error count, so quiet periods don’t trip it. Set a minimum number of calls before it can trip. Then tune it from what you see in production.

### Common mistake

Describing the breaker as a retry mechanism. Retries keep calling the broken service. A breaker stops calling it.

## 7\. Monolith

> “You’re starting a new product with 5 engineers. Would you build a monolith or microservices?”

A monolith is one application where every module ships together as a single deployable unit.

Orders, payments, and user accounts live in one codebase. They share one process and usually one database. Modules talk through plain function calls, so each call is fast and fails loudly.

You build it once, test it once, and deploy it once.

[![](https://substackcdn.com/image/fetch/$s_!zQw0!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F37232d4e-8559-4546-85c7-397ceb94f5bf_1536x1024.png)](https://substackcdn.com/image/fetch/$s_!zQw0!,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F37232d4e-8559-4546-85c7-397ceb94f5bf_1536x1024.png)

### Tips for a strong answer

- Pick a monolith first. Five engineers ship faster with one codebase, one pipeline, and one deploy.
- The product will change shape often, so service boundaries drawn now will probably be wrong.
- Keep clean module boundaries inside the monolith. Each module owns its own tables, and other modules call it through a clear interface.
- Name the signals for splitting later: builds get slow, engineers block each other’s releases, or one module needs to scale on its own.

### Likely follow-up

> “Your monolith has grown to 60 engineers. What do you do?”

Find the module with the most pain first, such as the one that changes most often or needs to scale most.

Extract it into its own service behind the same interface. Route traffic to the new service bit by bit, and keep the old code path until the new one proves stable.

Repeat one module at a time, never all at once.

### Common mistake

Calling the monolith outdated by default.

Interviewers want to hear you match the architecture to the size of the group and the product. A rewrite into many services on day one is the answer they’re testing you against.

Shopify still runs a very large Rails monolith, so “monoliths don’t scale” sounds like you’re simply following trends.

## 8\. Sidecar and service mesh

> “When would you add a service mesh & what does it cost you?”

A service mesh is a layer of proxies, one beside each service, which handles all traffic between services.

Each proxy, called a sidecar, runs in the same pod as its service. Every request in and out passes through it. The sidecar handles encryption, retries, timeouts, and metrics. A control plane pushes rules to every sidecar at once.

You change a retry policy in one place, and the entire fleet follows.

[![](https://substackcdn.com/image/fetch/$s_!nyii!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F85050529-2adf-479e-a0b1-3b1555865b39_1536x1024.png)](https://substackcdn.com/image/fetch/$s_!nyii!,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F85050529-2adf-479e-a0b1-3b1555865b39_1536x1024.png)

### Tips for a strong answer

- It gives you encryption, retries, timeouts, and traffic metrics without code changes.
- A service mesh becomes more useful when you have many microservices built with different programming languages.
- But it adds extra delay on every call, extra memory in every pod, and makes the system complex.
- Plus, debugging gets harder because a failure could occur in the proxy…not the service.

### Likely follow-up

> “How is a service mesh different from an API gateway?”

A gateway handles traffic coming into the system from clients…A mesh handles traffic between services inside the system.

Many large systems run both.

### Common mistake

Adding a mesh to five services because it’s popular.

At that size, a library like Resilience4j covers retries and timeouts. Interviewers want to hear you weigh the running costs.

## 9\. Observability

> “Checkout request is slow & it touches ten services. How do you find the cause?”

Observability is your ability to understand a system’s inner state from logs, metrics, and traces it produces.

Logs record single events, like an error with its details. Metrics track numbers over time, like request rate and error rate. Traces follow one request across every service it touches.

Each service passes a shared trace ID along with the call. Your tracing tool then stitches the pieces into one timeline.

[![](https://substackcdn.com/image/fetch/$s_!zAeJ!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fde55b45c-35e1-48ec-a56b-bd1a11440902_1536x1024.png)](https://substackcdn.com/image/fetch/$s_!zAeJ!,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fde55b45c-35e1-48ec-a56b-bd1a11440902_1536x1024.png)

### Tips for a strong answer

- Start with a distributed trace. It shows how much time each service spent on the request.
- Use metrics to spot which service’s latency or error rate went up.
- Search the logs by trace ID to see the exact error.
- Alert on what users feel, such as slow checkouts, not on every server metric.

### Likely follow-up

> “Tracing every request costs too much. What do you do?”

Sample. Keep a small share of normal traces and keep every trace with an error or a slow response. Set retention limits on logs as well.

### Common mistake

Answering “I’d check the logs.”

Logs from ten services can’t be joined without a shared trace ID. Name tracing first.

## 10\. Service-oriented architecture

> “How is service-oriented architecture different from microservices?”

Service-oriented architecture (**SOA**) builds an application from large, shared services connected through a central messaging layer.

In SOA, one service covers an entire business function, like billing. Several applications reuse the same service. An enterprise service bus (**ESB**) sits in the middle. It routes messages, converts formats, and applies rules between services.

[![](https://substackcdn.com/image/fetch/$s_!ViIh!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F6cc2263a-d141-4882-bb0b-e17ccb6994ce_1536x1024.png)](https://substackcdn.com/image/fetch/$s_!ViIh!,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F6cc2263a-d141-4882-bb0b-e17ccb6994ce_1536x1024.png)

### Tips for a strong answer

- Size: SOA services are large and shared across applications. Microservices are small and built around one capability.
- Logic: SOA puts routing and rules in the bus. Microservices keep the pipes simple and put logic inside each service.
- Data: SOA services share a database. Each microservice owns its own data.
- Releases: Shared SOA service needs sign-off from every consumer. A microservice ships on its own.

### Likely follow-up

> “Isn’t an API gateway just an enterprise service bus again?”

Only if you let it grow into one.

A gateway should route, check tokens, and apply rate limits. Once it starts holding business rules or joining data from many services, it becomes the bottleneck the bus was.

Watch for gateway changes in every feature release.

### Common mistake

Saying “microservices are just SOA done right” without naming a single difference. Interviewers want concrete points. The bus and data ownership are the two clearest ones.

*Start a discussion in the comments & connect with fellow readers:*

## 11\. Bounded context

> “How would you split an online shop’s monolith into services?”

A *bounded context* is a boundary inside which one domain model and its terms have one exact meaning.

Take the word “customer.” Sales sees a customer as a lead with a deal value. Support sees someone with open tickets. Shipping only needs a name and an address.

A bounded context lets each area keep its own small model instead of sharing one giant one.

[![](https://substackcdn.com/image/fetch/$s_!X5k0!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fa5ba5120-1e24-4a2a-af77-6471321622b4_1536x1024.png)](https://substackcdn.com/image/fetch/$s_!X5k0!,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fa5ba5120-1e24-4a2a-af77-6471321622b4_1536x1024.png)

### Tips for a strong answer

- Start from the business domain, not from database tables or code layers.
- Find boundaries where words change meaning, such as “customer” or “product.”
- Each context owns its model & data, and becomes a candidate service.
- Map how contexts depend on each other, and which events pass between them.
- Start with a few large contexts, and split further only when you have a reason.

### Likely follow-up

> “Two contexts both need customer data. Where does it live?”

One context owns the source of truth, such as customer service. It publishes an event whenever a customer changes. Other contexts keep their own copy with only the fields they need, updated from those events.

### Common mistake

Splitting by technical layer, with one service for the user interface, one for logic, and one for data. Every feature then touches all three, so nothing ships alone. One service per database table fails the same way.

## 12\. Rate limiting

> “Design rate limiting for a public API running on ten gateway instances.”

Rate limiting caps the number of requests a caller make in a set time window.

The gateway counts requests per user, API key, or IP address. Once a caller passes the limit, extra requests get an `HTTP 429` response. A common method is the token bucket.

Each caller has a bucket that refills at a steady rate & each request spends one token.

[![](https://substackcdn.com/image/fetch/$s_!oVW1!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fe773a7bc-7e0b-4b14-9177-f7accf197152_1536x1024.png)](https://substackcdn.com/image/fetch/$s_!oVW1!,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fe773a7bc-7e0b-4b14-9177-f7accf197152_1536x1024.png)

### Tips for a strong answer

- Limit per user or API key, not just per IP address[^5].
- Pick an algorithm: token bucket allows short bursts; sliding window gives smoother limits.
- Also keep counters in a shared store like Redis, so all ten instances see the same count.
- Return a `429` with a `Retry-After` header on limit.
- Plus, set different limits per plan and per endpoint.

### Likely follow-up

> “Redis goes down. Do you block all traffic or let it through?”

Usually let it through, using rough limits inside each gateway instance.

An outage in the limiter then doesn’t become an outage of the entire API. For sensitive endpoints like login, block instead.

### Common mistake

Counting inside each instance only. With ten instances, the real limit becomes ten times higher. Fixed time windows have a similar flaw since a caller can send double the limit on a window edge.

## 13\. REST

> “Design a REST API for orders.”

Representational state transfer (**REST**) is an API style where clients act on resources using standard HTTP methods.

A uniform resource locator (**URL**) like `/orders/42` names one order. GET reads it, POST creates one, PUT replaces it, and DELETE removes it. Responses normally come back as JSON.

Each request carries everything the server needs, so servers keep no session state between calls.

[![](https://substackcdn.com/image/fetch/$s_!dGmg!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F4fb066e5-36a5-44f8-a4a1-ee2eef61f13c_1536x1024.png)](https://substackcdn.com/image/fetch/$s_!dGmg!,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F4fb066e5-36a5-44f8-a4a1-ee2eef61f13c_1536x1024.png)

### Tips for a strong answer

- Use nouns for resources, such as `/orders` and `/orders/42/items`.
- Use the right methods: GET, POST, PUT, PATCH, and DELETE.
- Return clear status codes, such as `201` for created, `404` for not found, and `409` for a conflict.
- Paginate lists, and plan how you’ll version the API.

### Likely follow-up

> “A client retries POST `/orders` after a timeout. How do you avoid creating two orders?”

Ask the client to send an idempotency key with each POST. The server stores the key with the result. A repeat request with the same key returns the stored result instead of creating a new order.

### Common mistake

Putting verbs in URLs, like `/createOrder`, or returning `200` for every error with the real problem hidden in the body.

---

What happens next is up to you. Because the next time an interviewer asks you to design a microservices system, the answer won’t come from this letter. It’ll come from what you’ve learned and practiced.

— Neo

---

*Contribute to the conversation by sharing your insights & experiences:*

---

[![](https://substackcdn.com/image/fetch/$s_!68aQ!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fe4eab3a0-fda8-4df8-b651-0f976b223e9a_320x320.png)](https://www.linkedin.com/in/nk-systemdesign-one/)

Find me elsewhere: LinkedIn | Twitter Instagram

---

**Want to reach 250K+ tech professionals at scale?** 📰

If your company wants to reach 250K+ tech professionals, [advertise with me](https://newsletter.systemdesign.one/p/sponsorship).

---

Thank you for supporting this newsletter.

You are now 250,001+ readers strong, very close to 251k. Let’s try to get 251k readers by 27 November. Consider sharing this letter with your friends and get rewards.

Y’all are the best.

[![system design newsletter](https://substackcdn.com/image/fetch/$s_!6oWl!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F2e739087-a910-4643-be36-997b6dd5b4af_800x500.png)](https://substackcdn.com/image/fetch/$s_!6oWl!,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F2e739087-a910-4643-be36-997b6dd5b4af_800x500.png)

system design newsletter

---

### References

- Martin Fowler and James Lewis, *Microservices*:
	[https://martinfowler.com/articles/microservices.html](https://martinfowler.com/articles/microservices.html)
- Martin Fowler, *MonolithFirst*: [https://martinfowler.com/bliki/MonolithFirst.html](https://martinfowler.com/bliki/MonolithFirst.html)
- Martin Fowler, *BoundedContext*: [https://martinfowler.com/bliki/BoundedContext.html](https://martinfowler.com/bliki/BoundedContext.html)
- Martin Fowler, *CircuitBreaker*: [https://martinfowler.com/bliki/CircuitBreaker.html](https://martinfowler.com/bliki/CircuitBreaker.html)
- Melvin E. Conway, *How Do Committees Invent?* [https://www.melconway.com/Home/Committees\_Paper.html](https://www.melconway.com/Home/Committees_Paper.html)
- Sam Newman, *Backends For Frontends*: [https://samnewman.io/patterns/architectural/bff/](https://samnewman.io/patterns/architectural/bff/)
- Chris Richardson, *Pattern: Database per service*: [https://microservices.io/patterns/data/database-per-service.html](https://microservices.io/patterns/data/database-per-service.html)
- Netflix, *Eureka*: [https://github.com/Netflix/eureka](https://github.com/Netflix/eureka)
- HashiCorp, *Consul documentation*: [https://developer.hashicorp.com/consul/docs](https://developer.hashicorp.com/consul/docs)
- Kubernetes, *Service*: [https://kubernetes.io/docs/concepts/services-networking/service/](https://kubernetes.io/docs/concepts/services-networking/service/)
- Spring, *Spring Cloud Config*: [https://docs.spring.io/spring-cloud-config/reference/](https://docs.spring.io/spring-cloud-config/reference/)
- Istio, *What is a service mesh*: [https://istio.io/latest/about/service-mesh/](https://istio.io/latest/about/service-mesh/)
- OpenTelemetry, *Documentation*: [https://opentelemetry.io/docs/](https://opentelemetry.io/docs/)
- Benjamin H. Sigelman et al., *Dapper, a Large-Scale Distributed Systems Tracing Infrastructure*: [https://research.google/pubs/dapper-a-large-scale-distributed-systems-tracing-infrastructure/](https://research.google/pubs/dapper-a-large-scale-distributed-systems-tracing-infrastructure/)
- RFC 6585, *Additional HTTP Status Codes*: [https://www.rfc-editor.org/rfc/rfc6585](https://www.rfc-editor.org/rfc/rfc6585)
- Roy Fielding, *Architectural Styles and the Design of Network-based Software Architectures*: [https://ics.uci.edu/~fielding/pubs/dissertation/top.htm](https://ics.uci.edu/~fielding/pubs/dissertation/top.htm)
- gRPC, *Introduction to gRPC*: [https://grpc.io/docs/what-is-grpc/introduction/](https://grpc.io/docs/what-is-grpc/introduction/)
- Amazon Builders’ Library, *Timeouts, retries, and backoff with jitter:* [https://aws.amazon.com/builders-library/timeouts-retries-and-backoff-with-jitter/](https://aws.amazon.com/builders-library/timeouts-retries-and-backoff-with-jitter/)
- Netflix, *Hystrix*: [https://github.com/Netflix/Hystrix](https://github.com/Netflix/Hystrix)
- Resilience4j, *Bulkhead*: [https://resilience4j.readme.io/docs/bulkhead](https://resilience4j.readme.io/docs/bulkhead)
- PostgreSQL, *PREPARE TRANSACTION*: [https://www.postgresql.org/docs/current/sql-prepare-transaction.html](https://www.postgresql.org/docs/current/sql-prepare-transaction.html)
- Apache Seata, *TCC Mode*: [https://seata.apache.org/docs/user/mode/tcc/](https://seata.apache.org/docs/user/mode/tcc/)
- Hector Garcia-Molina and Kenneth Salem, *Sagas*: [https://www.cs.cornell.edu/andru/cs711/2002fa/reading/sagas.pdf](https://www.cs.cornell.edu/andru/cs711/2002fa/reading/sagas.pdf)
- Werner Vogels, *Eventually Consistent*: [https://queue.acm.org/detail.cfm?id=1466448](https://queue.acm.org/detail.cfm?id=1466448)

---

∙

[4 Restacks](https://substack.com/note/p-225635609/restacks?utm_source=substack&utm_content=facepile-restacks)

[^1]: A service mesh is an infrastructure layer that manages communication between microservices without requiring developers to implement networking features in every service

[^2]: The transactional outbox pattern saves a database change and its event in the same transaction, so the event can be reliably published later even if system crashes.

[^3]: Two-phase commit (**2PC**) makes sure multiple databases either all commit their changes or all roll them back, using a coordinator that asks each database to prepare before committing.

[^4]: Idempotent = performing the same operation multiple times has the same effect as performing it once, such as retrying a payment without charging the customer twice.

[^5]: Because multiple users can share the same IP address, and one user can make requests from different IP addresses.