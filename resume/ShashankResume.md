<!--
MASTER CONTENT RESERVOIR (not a 1:1 mirror of the PDF).
This is the full superset of verified facts and bullets to draw from when
tailoring ShashankResume.tex (master) and its cluster variants
(recsys / platform / hpc). The compiled .tex is the trimmed, ATS-optimized
artifact; this file is the deep source. Keep facts here consistent with the
canonical .tex (e.g. "ASPLOS 2027", not "MICRO 2026"). No GPA in resume-bound
content. Avoid em dashes.
-->

# Shashank Srinivasan
#### [+1-404-519-4936](tel:+14045194936) · [contact@knhash.in](mailto:contact@knhash.in) · [knhash.in](https://knhash.in) · [github.com/knhash](https://github.com/knhash) · [linkedin.com/in/knhash](https://linkedin.com/in/knhash)
Seattle, WA · Authorized to work in the US (STEM OPT, 36 months); no immediate sponsorship required

## Summary (swappable per variant)

- **Master:** Senior Machine Learning Engineer with 6 years building real-time recommendation and ranking systems. Served personalized content to 100M DAU at sub-50ms p99, lifting conversion +12% and engagement +5%. MS in CS (HPC specialization), Georgia Tech, May 2026.
- **Recsys / ranking:** Senior MLE specializing in recommendations, candidate generation, retrieval, and ranking. Owned cold-start personalization for a 100M DAU feed at sub-50ms p99, lifting conversion +12%; designed bandit, Elo, and lookalike models for sparse users.
- **ML platform / systems:** Senior MLE focused on ML platform and systems: low-latency serving, feature stores, streaming, and MLOps. Built serving and retraining infrastructure delivering 100M DAU at sub-50ms p99; standardized deployment, on-call, and automated canary across the team.
- **ML infra / HPC:** Senior MLE across HPC and ML systems: GPU and parallel computing, analog compute-in-memory, and large-scale data pipelines. Cut a pipeline over billions of events from 5 hours to 20 minutes, with active research on drift correction for analog ML accelerators.

## Experience

### Senior Machine Learning Engineer
**[Walmart](https://walmart.com/)** · *Dec 2024 -- Jul 2025 (concurrent with MS)*

- Cut per-experiment compute cost by **40%** on floor-price and adtech recommendation ML pipelines by profiling PySpark bottlenecks, rewriting shuffle-heavy transformations, and right-sizing batch processing.
- Built a **Text2SQL agentic system** (plain-English querying, visualizations, active chat) giving non-technical teams self-serve analytics over business and ML pipeline data.
- Improved production ML reliability and release velocity with an **observability framework** and standardized model build, test, and deployment via GitHub Actions.

### Machine Learning Engineer III
**[Glance (InMobi)](https://glance.com/)** · *Jul 2022 -- Dec 2024* · Promoted from Data Scientist II

- **Founding engineer** on the rebuilt Glance feed personalization platform serving **100M DAU**; owned cold-start and sparse-user personalization end to end (the team split the feed problem into sparse vs dense users; owned the sparse side).
- Designed the sparse-user modeling stack: multinomial **Thompson-sampling bandits** (category-sampling layer, bubble-popularity fallback, time-of-day variants), an **Elo-style exploration** scheme adapted from game matchmaking (rank early users by inferred capability to drive exploration), and **lookalike models** (clustering with SVD/K-Means, then node2vec on app-ownership signals) that beat pacing and production baselines on time spent and reward for cold and sparse users; **+18.38%** time spent for cold users, **+11.68%** overall.
- Delivered content at **sub-50ms p99** via low-latency serving and streaming pipelines (prediction services, Vertex AI feature store, Kafka, ELK logging, Airflow retraining); **+12% conversion**, **+5% engagement**.
- Built and optimized a lock-screen rewards summary pipeline (gcat) over **billions of clicks**, cutting runtime from **5 hours to 20 minutes**.
- Drove engineering health: standardized **on-call** responsibilities, cleaned up the end-to-end prediction-service deployment cycle to reduce developer mistakes, contributed to the Model Controller refactor, set up an **automated canary** used across the team (plus Neptune metrics in the deploy cycle), and built a solutions-first debugging culture.
- Leadership / influence: **mentored** a junior engineer (Ritika) on lookalike modeling; **led an org-wide paper-reading session** ("multiplying matrices without multiplying"); wrote an externally-published blog "building recommender systems in production"; cross-functional point of contact with Data Analytics, Product, and Engineering, and for Xiaomi India and Game Centre within Feed; submitted a lookalike paper to CODS.

### Data Scientist II
**[Glance (InMobi)](https://glance.com/)** · *May 2021 -- Jun 2022*

- Built Glance's **first live-commerce recommendation system** (Roposo) on graph embeddings at sub-50ms, deployed as the first iteration of Live Commerce recommendations.
- Built the Feed team's **first Python prediction service** (sub-100ms, in two weeks): **+6.54%** lift over control, beating the base model (5.38%); best-performing model in production as of Dec 2021.
- Shipped real-time, NLP-based **quiz / auto-polls generation over live video** (GCP, questgen.ai, deployed on GKE), demoed at the company Friday Demo Day and AI Demo Day.
- Drove technical integration of OEM / OTT content for Glance TV (CardPress), managing external content partners (**Docubay, EpicON, Zee5**); helped chalk out early Glance TV personalization architecture.

### Founding Data Scientist
**[Bright Money](https://www.brightmoney.co/)** · *Jun 2019 -- Apr 2021*

- Founded the data science function and built **Debt Manager**, Bright's flagship AI product that analyzes a user's finances and autonomously schedules debt payments; on Airflow and Django, it served **20K+ users/day** at **$100K+ daily transaction volume** and drove close to **100% of revenue** by 2020, with minimal human intervention.
- Shipped multiple **0-to-1 ML products**: bill identification, affordability scoring, overdraft prediction, and liability inference for risk and retention workflows.
- Built **time-series forecasting** for income, expense, and account balance (Prophet, SARIMA), plus segmentation and user-behavior models powering activation, retention, and monetization.

## Education

### Master of Science, Computer Science
**[Georgia Institute of Technology](https://www.gatech.edu/)**, Atlanta, USA · *Aug 2024 -- May 2026*

- Specialization: High Performance Computing.
- Research: Analog compute-in-memory error mitigation with *Prof. Hyesoon Kim*.
- Coursework: GPU Hardware & Software, High-Performance Parallel Computing, HPC Architecture, Scientific Machine Learning, Deep Learning, Compiler Design, Designing for Curiosity.

### Bachelor of Engineering, Computer Science & Engineering
**[Sir M. Visvesvaraya Institute of Technology](https://www.sirmvit.edu/)**, Bengaluru, India · *May 2018*

- First Class with Distinction.
- Thesis: [Image Regeneration with Generative Models](https://knhash.github.io/files/ImageRegenerationWithGenerativeModels.pdf).
- Electives: Pattern Recognition, Clouds & Clusters, Artificial Intelligence.

## Selected Systems & Research

- **Embedded Drift Sentinel** (under review at ASPLOS 2027): Companion-crossbar architecture for online drift correction in analog compute-in-memory accelerators. Improved day-360 ImageNet top-1 accuracy by +14 pp on average over GDC across ResNet-18/34/50 and GoogLeNet on a 360-day PCM drift horizon (ResNet-50: 68% vs 53% GDC, vs 17% uncorrected); eliminates main-array probe downtime at 0.3-1.7% cell overhead.
- **[Physics-Informed RL for Plasma Control](https://knhash.github.io/files/PIRLforPlasma.pdf):** PPO policies trained in TORAX (auto-differentiable 1D core transport simulator) on a 50-parameter partially-observed state for ITER tokamak fusion control; 1.7 ms average inference (3.5 ms max), under the 50 ms real-time threshold.
- **Deep Learning Segmentation of Meibomian Glands:** Published CNN-based meibography segmentation in [Biomedical Signal Processing and Control](https://www.sciencedirect.com/science/article/abs/pii/S174680941930357X); custom augmentation and gland-health metrics validated against clinical expert annotations across tabletop and prototype handheld imagers.
- **Automated Debt Management (patents):** R&D contributor; [US20220261886A1](https://patents.google.com/patent/US20220261886A1), [US20230075411A1](https://patents.google.com/patent/US20230075411A1/).
- **[GhostGame.io](https://kienme.medium.com/building-ghostgame-io-a-multiplayer-word-game-449f13c55657):** Browser-based multiplayer word game on Firebase/GCP (Firestore, Cloud Functions).
- **[Shank's Sessions](https://www.youtube.com/@ShankSessions)** and **[Various Tech Toys](https://knhash.in/den/):** podcasts/streams and assorted side projects (mostly Streamlit).

## Technical Skills (comprehensive, shared across variants in the PDF)

- **Languages:** Python, C/C++, Go, SQL, PySpark, Shell
- **Artificial Intelligence & Machine Learning:** Recommendation Systems, Candidate Generation, Retrieval & Ranking, Multi-Armed Bandits, Collaborative Filtering, Graph ML (node2vec, embeddings), Deep Learning, NLP, LLMs & Agentic Workflows (LangChain), Reinforcement Learning, Time-Series Forecasting (Prophet, SARIMA), A/B Testing; PyTorch, scikit-learn, XGBoost/LightGBM
- **MLOps & Infrastructure:** Docker, Kubernetes, Airflow, Argo, Kafka, Spark, Vertex AI Feature Store, Neptune, GitHub Actions (CI/CD), ELK, Prometheus, Grafana; CUDA, MPI, OpenMP, GPU Profiling (Nsight Systems, nvprof), Distributed Systems, Scientific ML (PINNs)
- **Cloud & Data:** GCP, AWS, Azure, PostgreSQL, Cosmos DB, Firebase, Tableau, Metabase, Django, Linux, Git

Cluster keyword sets to mirror into the variant summary (`\SummaryPara`) per JD:
- **Recsys / ranking:** candidate generation, retrieval, ranking, multi-armed bandits, Thompson sampling, Elo, collaborative filtering, lookalike modeling, graph embeddings
- **Platform / systems:** low-latency serving, feature stores, streaming, retraining, MLOps, observability, automated canary, model controllers
- **HPC / infra:** parallel & GPU computing, distributed training, profiling (Nsight), scientific ML (PINNs), analog compute-in-memory, large-scale data pipelines
- Extras (kept off the focused PDF): JavaScript, HTML/CSS, Streamlit, OpenGL, Azure Data Factory, GKE, questgen.ai

## Honors & Teaching

- **[ACM ICPC 2015](https://knhash.github.io/files/ICPC_2015.pdf):** Qualified to regional level; honorable mention.
- **Letter of Commendation, Minister of HRD** for [AISSCE board exam](https://knhash.github.io/files/12th.pdf).
- **Section Leader, Code in Place, Stanford University:** Taught Python to 30+ students per cohort in [2021](https://knhash.in/files/CodeInPlace.pdf), [2023](https://knhash.in/files/CodeInPlace2023.pdf), and [2024](https://knhash.in/files/CodeInPlace2024.pdf).
- **Certifications:** [Neural Networks & Deep Learning (deeplearning.ai)](https://knhash.github.io/files/NeuralNetworksAndDeepLearning.pdf), [Machine Learning (Stanford / Coursera)](https://knhash.github.io/files/CourseraML.pdf), [Android Developer Nanodegree (Google / Udacity)](https://knhash.github.io/files/UdacityAND.pdf).

## Raw accomplishment bank (superset, from 2021/2022 reviews)

Extra granular items not all surfaced on the one/two-page PDF; pull from here when a JD calls for a specific signal.

- **Ranking:** bubble-threshold score modeling session length within a bubble (worked well for dense users); bubble-popularity score v2 with new scoring logic; modality-cut experiment (MTS hybrid layer deciding how much content per user) that seeded the next year's proportion modeling.
- **Live / lock-screen personalization:** took over rule-based live systems and shipped the MAB-based version (the live model at scale by end 2022, lighter and more performant codebase); unified live + non-live rewards pipeline; lock-screen v1/v2 on Google categories and a diversity model (different ranking per category); FIFA/cricket high-priority content pushes during sports seasons.
- **Game Centre:** reward definition from relative play counts; first GC-focused UserLR model (taken down after underperformance); point of contact for GC within Feed.
- **Platform / MLOps:** automated canary adopted across the team; Neptune metrics in the deploy cycle; Model Controller refactor; standardized on-call; end-to-end prediction-service deployment cleanup; healthchecks.io pipeline alerting (initiated org-wide pipeline-monitoring conversation, later GCP logging); Azure Data Factory ingestion into Cosmos bringing ~1M-row writes from ~40 min to ~20 min at ~$23/batch.
- **Roposo Commerce:** consumer-creator affinity v1 on graph embeddings (first live-commerce reco in prod, sub-50ms); EDA for a more robust heterogeneous-graph affinity v2.
- **Glance TV:** OTT content integration (Docubay, EpicON, Zee5); auto-polls/quiz POCs (Wikipedia/Twitter context, questgen.ai NLP, GKE deploy); OnDemand Tambola video-stitching POC; early TV personalization architecture; A/B experiment setup for DS on Glance TV.
- **Thought leadership:** org-wide paper-reading session ("multiplying matrices without multiplying"); external + Glance blog "building recommender systems in production"; lookalike paper submitted to CODS (rejected, useful feedback); regular Thursday/Friday demo and paper sessions.
- **Manager:** Suba Palani (Glance Feed Reco). Feedback themes: strong technical-to-business judgment, ownership, fast execution, people/stakeholder skills; growth toward leadership.
