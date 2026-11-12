-- ============================================================================
-- PROOFWORK B2B VERIFICATION PLATFORM
-- SCRIPT: 04_workflow_applications_submissions.sql
-- AUTHOR: Member 3 (Workflow Engineer - I)
-- ROLE: Client-Freelancer Interaction Flow
-- SCOPE: 200 Applications, 150 Milestones, 100 Submissions
-- ============================================================================

USE proofwork_db;

-- ----------------------------------------------------------------------------
-- PART 0: DROP OLD MISMATCHED TABLES & CREATE CLEAN TABLES
-- ----------------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Submissions;
DROP TABLE IF EXISTS Milestones;
DROP TABLE IF EXISTS Applications;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. APPLICATIONS TABLE
CREATE TABLE Applications (
    application_id INT PRIMARY KEY,
    project_id INT NOT NULL,
    user_id INT NOT NULL,
    proposal_text TEXT NOT NULL,
    bid_amount DECIMAL(10,2) NOT NULL,
    estimated_days INT NOT NULL,
    status ENUM('Pending', 'Accepted', 'Rejected') DEFAULT 'Pending',
    FOREIGN KEY (project_id) REFERENCES Projects(project_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- 2. MILESTONES TABLE
CREATE TABLE Milestones (
    milestone_id INT PRIMARY KEY,
    project_id INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    due_date DATE NOT NULL,
    status ENUM('Pending', 'Completed', 'Overdue') DEFAULT 'Pending',
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);

-- 3. SUBMISSIONS TABLE
CREATE TABLE Submissions (
    submission_id INT PRIMARY KEY,
    application_id INT NOT NULL,
    version VARCHAR(10) NOT NULL,
    file_url VARCHAR(255) NOT NULL,
    submission_notes TEXT NOT NULL,
    submitted_at DATETIME NOT NULL,
    status ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending',
    FOREIGN KEY (application_id) REFERENCES Applications(application_id)
);

CREATE INDEX idx_applications_project ON Applications(project_id);
CREATE INDEX idx_applications_freelancer ON Applications(user_id);
CREATE INDEX idx_milestones_project ON Milestones(project_id);
CREATE INDEX idx_submissions_application ON Submissions(application_id);
-- ----------------------------------------------------------------------------
-- PART 1: APPLICATIONS TABLE (200 ROWS)
-- ----------------------------------------------------------------------------

INSERT INTO Applications (
    application_id, project_id, user_id, proposal_text, bid_amount, estimated_days, status
) VALUES
-- Project 1 (Budget: 85000)
(1, 1, 1, 'I have 4 years building scalable e-commerce systems with React and Node.js. Built a similar online grocery delivery portal for a Tricity client with inventory sync and instant digital checkout. Can deliver production-ready code with complete documentation and automated test suites.', 82000, 25, 'Accepted'),
(2, 1, 2, 'Senior frontend engineer specializing in React and responsive mobile-first UI components. Can build high performance shopping catalog screens and cart checkout interfaces adhering strictly to project guidelines.', 84000, 28, 'Pending'),
(3, 1, 3, 'Full stack web developer with Express and MongoDB aggregation experience. Have built vendor management modules before and ready to collaborate on this e-commerce platform workflow.', 89000, 30, 'Rejected'),
(4, 1, 4, 'Backend developer specializing in Python and PostgreSQL. Can architect the database schema, but frontend components will require ready-made design libraries.', 80000, 26, 'Rejected'),

-- Project 2 (Budget: 42000)
(5, 2, 5, 'Shopify theme customization specialist with 5 years experience crafting high-conversion artisan storefronts. Handled custom liquid sections, localized shipping rules, and payment gateways for multiple boutique retail clients.', 39000, 16, 'Accepted'),
(6, 2, 6, 'Frontend web developer experienced in Shopify Liquid and responsive CSS. Can deliver standard product pages and setup shipping configuration within tight deadlines.', 41000, 18, 'Pending'),
(7, 2, 7, 'WordPress and WooCommerce developer transitioning into Shopify development. Can assist with product catalog ingestion and standard checkout setup.', 44000, 22, 'Rejected'),
(8, 2, 8, 'Graphic designer with basic web publishing skills. Can design banner graphics and setup default theme templates.', 37000, 15, 'Rejected'),

-- Project 3 (Budget: 165000)
(9, 3, 9, 'Enterprise full stack architect with extensive experience engineering multi-vendor marketplaces. Implemented multi-tenant vendor onboarding, automated commission splitting, real-time inventory tracking, and payment gateways for high-volume retail portals.', 158000, 45, 'Accepted'),
(10, 3, 10, 'Full stack JavaScript engineer with Next.js and Node.js background. Can deliver seller dashboard interfaces and customer search filtering with Elasticsearch.', 162000, 50, 'Pending'),
(11, 3, 11, 'Backend specialist focusing on microservices and API gateways. Experience with order tracking queues and transactional integrity across distributed databases.', 172000, 55, 'Rejected'),
(12, 3, 12, 'Web developer experienced in basic e-commerce modules. Seeking larger multi-vendor projects to expand technical portfolio.', 150000, 42, 'Rejected'),

-- Project 4 (Budget: 72000)
(13, 4, 13, 'Senior web engineer specialized in subscription commerce models and recurring billing engines. Built automated delivery slot schedulers and integrated Stripe billing cycles with webhook notification fallbacks.', 69000, 24, 'Accepted'),
(14, 4, 14, 'Full stack developer with Node.js and React background. Experienced in customer profile dashboards and recurring order database models.', 71000, 26, 'Pending'),
(15, 4, 15, 'Frontend developer focusing on responsive marketing layouts and weekly box customization user interfaces.', 75000, 30, 'Rejected'),
(16, 4, 16, 'Junior backend programmer with basic MySQL transaction experience. Ready to implement database migrations and CRUD endpoints.', 67000, 22, 'Rejected'),

-- Project 5 (Budget: 110000)
(17, 5, 17, 'Full stack engineer with React, TypeScript, and Redis caching. Developed high-speed electronics catalog portals featuring dynamic spec comparison matrices, multi-faceted filtering, and live stock tracking under heavy traffic.', 104000, 35, 'Accepted'),
(18, 5, 18, 'Frontend developer specializing in complex data tables and product comparison widgets with Tailwind CSS and Redux Toolkit.', 108000, 38, 'Pending'),
(19, 5, 19, 'Backend engineer with Express and SQL search query optimization expertise. Capable of building scalable API endpoints.', 115000, 42, 'Rejected'),
(20, 5, 20, 'Web developer with general JavaScript and relational database experience. Prepared to implement wishlist and shopping cart features.', 101000, 32, 'Rejected'),

-- Project 6 (Budget: 38000)
(21, 6, 21, 'Full stack web developer with MERN stack expertise. Built specialized bookstore catalog engines with ISBN barcode search, author indices, and integrated Indian courier tracking APIs.', 36000, 16, 'Accepted'),
(22, 6, 22, 'Node.js backend developer with experience implementing ISBN metadata fetchers and shopping cart transaction flows.', 37500, 18, 'Pending'),
(23, 6, 23, 'Frontend developer with React and Bootstrap experience. Can build responsive book browsing pages and review display widgets.', 40500, 21, 'Rejected'),
(24, 6, 24, 'Database administrator looking to build web interfaces. Strong SQL query capabilities with basic HTML/CSS design knowledge.', 35000, 15, 'Rejected'),

-- Project 7 (Budget: 95000)
(25, 7, 25, 'Interactive web developer specializing in 3D product customizers with Three.js and React. Built furniture specification configurators allowing buyers to visualize material finishes and generate instant dynamic quotations.', 91000, 32, 'Accepted'),
(26, 7, 26, 'Frontend engineer with WebGL and HTML5 Canvas experience. Can deliver interactive furniture dimension selection tools.', 93500, 35, 'Pending'),
(27, 7, 27, 'Full stack developer with standard form handling and quote generation experience. Limited 3D interactive rendering background.', 99000, 40, 'Rejected'),
(28, 7, 28, 'UI developer experienced in product catalog listings. Can implement static photo selection flows and delivery tracking pages.', 88000, 30, 'Rejected'),

-- Project 8 (Budget: 68000)
(29, 8, 29, 'E-commerce specialist with Next.js, Tailwind CSS, and headless commerce architectures. Delivered high-converting beauty store interfaces with personalized skin-type recommendation quizzes and review verification modules.', 65000, 22, 'Accepted'),
(30, 8, 30, 'Frontend developer with React and Chakra UI. Experienced in building responsive product filter ribbons and coupon application modals.', 67000, 25, 'Pending'),
(31, 8, 1, 'WordPress elementor expert with experience designing beauty brand marketing landing pages and contact funnels.', 72000, 28, 'Rejected'),
(32, 8, 2, 'Junior developer eager to build portfolio projects. Willing to provide post-deployment support and regular daily standup syncs.', 63000, 20, 'Rejected'),

-- Project 9 (Budget: 56000)
(33, 9, 3, 'Full stack web developer with React, Node.js, and Redis. Built sports gear e-commerce engines with multi-attribute sizing charts, real-time inventory threshold alerts, and admin order tracking pipelines.', 53000, 20, 'Accepted'),
(34, 9, 4, 'Backend engineer with Express and MySQL. Experienced in constructing inventory alert worker jobs and order status state machines.', 55000, 22, 'Pending'),
(35, 9, 5, 'Frontend developer familiar with CSS Grid and flexbox layouts. Capable of building product detail screen galleries.', 59500, 25, 'Rejected'),
(36, 9, 6, 'Web programmer with PHP and relational database background. Experienced in basic shopping cart integrations.', 51000, 19, 'Rejected'),

-- Project 10 (Budget: 185000)
(37, 10, 7, 'Enterprise B2B systems architect with 6 years experience constructing wholesale procurement engines. Handled tiered volume pricing models, automated GST invoice PDF generation, credit terms workflows, and bulk repeat ordering.', 176000, 52, 'Accepted'),
(38, 10, 8, 'Senior backend developer with Node.js, PostgreSQL, and Redis. Specializes in transactional locks and high-volume order processing.', 181000, 56, 'Pending'),
(39, 10, 9, 'Full stack engineer with React and Express. Experience in building complex administrative data tables and corporate account managers.', 192000, 60, 'Rejected'),
(40, 10, 10, 'Software developer with relational database skills. Capable of building backend REST endpoints for wholesale client requests.', 172000, 48, 'Rejected'),

-- Project 11 (Budget: 145000)
(41, 11, 11, 'Senior AI/ML engineer with solid track record in building custom NLP recruitment pipelines, PyTorch embeddings, and FastAPI servers. Implemented semantic resume parser matching applicant skills with job specs and generating transparent match scores.', 139000, 40, 'Accepted'),
(42, 11, 12, 'Data scientist experienced in scikit-learn, SpaCy, and text extraction models. Can handle resume parsing and keyword matching scripts.', 142000, 44, 'Pending'),
(43, 11, 13, 'Python developer with basic regex extraction and web scraping expertise. Can build data extraction scripts for PDF documents.', 152000, 48, 'Rejected'),
(44, 11, 14, 'Machine learning graduate student familiar with basic HuggingFace classification pipelines and tokenization.', 134000, 38, 'Rejected'),

-- Project 12 (Budget: 62000)
(45, 12, 15, 'AI conversational specialist with LangChain, OpenAI embeddings, and ChromaDB vector stores. Built intelligent FAQ retrieval assistants with human handoff routing, context retention, and automated fallback tickets.', 59000, 22, 'Accepted'),
(46, 12, 16, 'Python developer with FastAPI and chatbot widget embedding experience. Capable of setting up webhook integrations.', 61000, 24, 'Pending'),
(47, 12, 17, 'Full stack developer with Dialogflow and Node.js webhook background. Focused on basic FAQ intent classification.', 66000, 28, 'Rejected'),
(48, 12, 18, 'Software engineer exploring vector databases and conversational interfaces. Ready to train baseline response models.', 57000, 20, 'Rejected'),

-- Project 13 (Budget: 175000)
(49, 13, 19, 'Lead data scientist specializing in financial risk modeling and fraud prevention. Built real-time anomaly detection inference servers using XGBoost, Kafka event streaming, and FastAPI with sub-50ms latency scoring dashboards.', 168000, 48, 'Accepted'),
(50, 13, 20, 'Data engineer specialized in Python backend, Celery task workers, and PostgreSQL vector storage. Ready to scale ingestion pipelines.', 172000, 52, 'Pending'),
(51, 13, 21, 'Machine learning engineer with classification model experience. Capable of feature engineering on historical transaction logs.', 182000, 58, 'Rejected'),
(52, 13, 22, 'Python developer with experience writing automation scripts and data cleaning notebooks.', 163000, 45, 'Rejected'),

-- Project 14 (Budget: 78000)
(53, 14, 23, 'Data analyst and full stack developer with Python, Pandas, and React. Built institutional predictive analytics dashboards analyzing attendance, assignment scores, and student risk profiles with early intervention alerts.', 74000, 26, 'Accepted'),
(54, 14, 24, 'Data science developer with regression modeling and interactive charting experience using Chart.js and FastAPI.', 76500, 28, 'Pending'),
(55, 14, 25, 'Backend developer with SQL stored procedures and reporting background. Can construct data aggregation views.', 82000, 32, 'Rejected'),
(56, 14, 26, 'Junior data scientist with academic predictive analytics project portfolio. Familiar with educational datasets.', 72000, 24, 'Rejected'),

-- Project 15 (Budget: 98000)
(57, 15, 27, 'Machine learning engineer with deep collaborative filtering and vector recommendation experience. Built multi-tenant recommendation engines analyzing user clickstreams and purchase affinities with Redis caching.', 93000, 32, 'Accepted'),
(58, 15, 28, 'Python developer with FastAPI, Scikit-learn, and matrix factorization modeling experience for retail personalization.', 96000, 35, 'Pending'),
(59, 15, 29, 'Data scientist familiar with cosine similarity and embedding lookups. Can deliver recommendation microservices.', 103000, 40, 'Rejected'),
(60, 15, 30, 'Software engineer with general Python and relational database querying skills.', 89000, 30, 'Rejected'),

-- Project 16 (Budget: 88000)
(61, 16, 1, 'NLP specialist with Whisper transcription, LangChain, and transformer architectures. Engineered automated meeting summarization tools extracting key action items, assigned owners, and calendar deadlines into structured outputs.', 84000, 28, 'Accepted'),
(62, 16, 2, 'Python developer with experience integrating LLM APIs and building transcript parsing worker jobs.', 86500, 30, 'Pending'),
(63, 16, 3, 'Backend engineer with Node.js and REST API background. Can handle audio upload endpoints and file storage.', 92000, 35, 'Rejected'),
(64, 16, 4, 'Software developer exploring LLM orchestration frameworks and prompt templates.', 81000, 26, 'Rejected'),

-- Project 17 (Budget: 125000)
(65, 17, 5, 'Computer vision engineer with PyTorch and YOLOv8 expertise. Developed mobile-ready crop leaf disease classification models with image preprocessing, confidence scoring, and multilingual treatment recommendations.', 119000, 38, 'Accepted'),
(66, 17, 6, 'Data scientist with OpenCV and automated image processing pipeline capabilities for agricultural datasets.', 122000, 42, 'Pending'),
(67, 17, 7, 'Python developer with basic image analysis script experience. Capable of setting up image upload microservices.', 131000, 48, 'Rejected'),
(68, 17, 8, 'Machine learning enthusiast with classification model training history on Kaggle plant datasets.', 115000, 36, 'Rejected'),

-- Project 18 (Budget: 54000)
(69, 18, 9, 'AI/ML specialist with HuggingFace transformers, BERT, and FastAPI. Built customer sentiment classification engines with aspect-based polarity scoring and recurring complaint cluster detection.', 51000, 18, 'Accepted'),
(70, 18, 10, 'Data scientist with expertise in text classification, tokenization, and customer feedback dashboards.', 53000, 20, 'Pending'),
(71, 18, 11, 'Python developer with experience writing text parsing scripts and feeding sentiment labels into relational tables.', 57000, 24, 'Rejected'),
(72, 18, 12, 'Junior developer eager to build portfolio projects. Familiar with basic NLP sentiment libraries.', 49000, 17, 'Rejected'),

-- Project 19 (Budget: 115000)
(73, 19, 13, 'Document AI specialist with OCR pipelines, LayoutLM, and PyTesseract. Engineered automated corporate invoice parsing systems extracting vendor GST, line items, and tax amounts with 99% accuracy into structured CSV/JSON.', 109000, 36, 'Accepted'),
(74, 19, 14, 'Data engineer with OpenCV and PDF spatial text extraction experience. Capable of building extraction worker queues.', 112000, 40, 'Pending'),
(75, 19, 15, 'Python developer with experience writing automation scripts and tabular data cleaners.', 121000, 45, 'Rejected'),
(76, 19, 16, 'Software engineer exploring computer vision pipelines for scanned paper documents.', 105000, 34, 'Rejected'),

-- Project 20 (Budget: 195000)
(77, 20, 17, 'Senior AI voice engineer with WebRTC, Whisper speech recognition, and Text-to-Speech synthesis. Built automated voice helpdesk bots capable of understanding Indian accents, resolving service queries, and creating support tickets.', 186000, 54, 'Accepted'),
(78, 20, 18, 'Backend engineer with Node.js, WebSockets, and telephony API integration experience.', 191000, 58, 'Pending'),
(79, 20, 19, 'Python developer with speech-to-text API integration and ticket management background.', 200000, 65, 'Rejected'),
(80, 20, 20, 'Full stack developer with basic audio streaming and web communication skills.', 180000, 50, 'Rejected'),

-- Project 21 (Budget: 180000)
(81, 21, 21, 'Lead mobile engineer with Flutter, Google Maps SDK, and GPS telemetry tracking. Developed on-demand taxi dispatch systems featuring real-time driver tracking, fare calculation engines, trip history, and razorpay payment.', 172000, 48, 'Accepted'),
(82, 21, 22, 'React Native developer with geolocation and background service capabilities for mobile transit applications.', 176000, 52, 'Pending'),
(83, 21, 23, 'Native Android specialist with Google Play Location API integration skills and foreground services.', 188000, 58, 'Rejected'),
(84, 21, 24, 'Hybrid app coder with Cordova and basic web mapping wrapper plugins.', 168000, 45, 'Rejected'),

-- Project 22 (Budget: 155000)
(85, 22, 25, 'Expert mobile app engineer with Flutter and Firebase. Built enterprise food delivery applications with multi-restaurant menus, live delivery partner tracking, interactive cart management, and payment webhooks.', 148000, 42, 'Accepted'),
(86, 22, 26, 'Cross-platform app developer with React Native experience. Experienced in food ordering cart and push notifications.', 152000, 45, 'Pending'),
(87, 22, 27, 'Native iOS developer with Swift and CoreLocation experience. Focused on iOS client delivery only.', 162000, 50, 'Rejected'),
(88, 22, 28, 'Hybrid application developer using Ionic and Angular. Basic local storage caching background.', 143000, 40, 'Rejected'),

-- Project 23 (Budget: 92000)
(89, 23, 29, 'Mobile developer with Flutter, clean BLoC architecture, and SQLite offline storage. Built comprehensive workout planner applications with interval timers, graphical body progress logs, and scheduled notifications.', 88000, 28, 'Accepted'),
(90, 23, 30, 'React Native developer with mobile charting and accelerometer integration experience.', 90500, 30, 'Pending'),
(91, 23, 1, 'Native Android engineer with background timer service and step counter APIs.', 97000, 35, 'Rejected'),
(92, 23, 2, 'Mobile developer familiar with standard UI layouts and local device notifications.', 85000, 26, 'Rejected'),

-- Project 24 (Budget: 48000)
(93, 24, 3, 'Mobile engineer with React Native, Firebase Cloud Messaging, and QR generation. Built student event management apps with digital ticket passes, deadline alerts, and interactive event schedules for campus fests.', 45000, 18, 'Accepted'),
(94, 24, 4, 'Flutter developer with experience in college campus notices and event registration flows.', 47000, 20, 'Pending'),
(95, 24, 5, 'Frontend mobile developer with basic Cordova hybrid app experience.', 51000, 24, 'Rejected'),
(96, 24, 6, 'Junior app developer eager to construct event notification interfaces.', 43000, 16, 'Rejected'),

-- Project 25 (Budget: 105000)
(97, 25, 7, 'Mobile healthtech engineer with Flutter, HIPAA compliant encrypted storage, and clean architecture. Engineered doctor consultation booking apps with live schedule availability, patient records, and SMS alerts.', 100000, 34, 'Accepted'),
(98, 25, 8, 'React Native developer with calendar appointment slot engines and push notification background.', 103000, 36, 'Pending'),
(99, 25, 9, 'Android developer with Java and Room database experience for local appointment records.', 111000, 40, 'Rejected'),
(100, 25, 10, 'Full stack mobile developer with basic scheduling and patient profile capabilities.', 97000, 32, 'Rejected'),

-- Project 26 (Budget: 52000)
(101, 26, 11, 'Mobile developer with Flutter, Provider pattern, and SQLite caching. Developed intuitive personal finance trackers with category-wise spending charts, monthly budget caps, and CSV/PDF statement exports.', 49000, 18, 'Accepted'),
(102, 26, 12, 'React Native developer with local device storage and financial chart visualization skills.', 51000, 20, 'Pending'),
(103, 26, 13, 'Native Android engineer with Room database and MPAndroidChart integration mastery.', 55000, 24, 'Rejected'),
(104, 26, 14, 'Mobile coder with basic expense logging form experience.', 47000, 16, 'Rejected'),

-- Project 27 (Budget: 135000)
(105, 27, 15, 'Full stack mobile architect with Flutter and Node.js. Built home service on-demand marketplaces connecting users with verified technicians, featuring slot booking, live status updates, ratings, and escrow payment.', 129000, 38, 'Accepted'),
(106, 27, 16, 'React Native developer with location-based service provider search and booking confirmation flows.', 132000, 42, 'Pending'),
(107, 27, 17, 'Native Android specialist with background location and push notifications for service personnel.', 141000, 48, 'Rejected'),
(108, 27, 18, 'Mobile app developer with basic service booking form workflows.', 125000, 36, 'Rejected'),

-- Project 28 (Budget: 76000)
(109, 28, 19, 'Mobile developer with Flutter, Mapbox, and local camera integrations. Built offline-capable travel companion apps with interactive itinerary pins, trip journaling, photo compression, and cloud sync.', 72000, 24, 'Accepted'),
(110, 28, 20, 'React Native developer with travel itinerary planners and photo gallery integration experience.', 74500, 26, 'Pending'),
(111, 28, 21, 'Native Android developer with SQLite storage and photo file upload services.', 80000, 30, 'Rejected'),
(112, 28, 22, 'Junior mobile programmer with basic list views and map navigation pins.', 69000, 22, 'Rejected'),

-- Project 29 (Budget: 69000)
(113, 29, 23, 'Mobile health developer with Flutter and Firebase. Engineered emergency blood donor networks with geolocation proximity matching, hospital emergency broadcasts, and verified donor response tracking.', 66000, 22, 'Accepted'),
(114, 29, 24, 'React Native developer with real-time push alerts and donor directory search capabilities.', 68000, 24, 'Pending'),
(115, 29, 25, 'Android developer with Java and Location Services for proximity searching.', 73000, 28, 'Rejected'),
(116, 29, 26, 'Mobile intern offering rapid user interface development for emergency directories.', 63000, 20, 'Rejected'),

-- Project 30 (Budget: 120000)
(117, 30, 27, 'Mobile education engineer with Flutter, video DRM encryption, and SQLite offline caching. Developed full-featured e-learning apps with chapter quizzes, progress dashboards, and instructor announcements.', 114000, 35, 'Accepted'),
(118, 30, 28, 'React Native developer with experience configuring audio, video playback, and timed quiz state.', 117500, 38, 'Pending'),
(119, 30, 29, 'Android developer with Kotlin and ExoPlayer media integration experience.', 126000, 44, 'Rejected'),
(120, 30, 30, 'Mobile coder with basic quiz form handling and student score tables.', 110000, 32, 'Rejected'),

-- Project 31 (Budget: 28000)
(121, 31, 1, 'Frontend web specialist with Next.js, Tailwind CSS, and Vercel edge deployment. Built high-converting responsive consultant portfolios with case study filters, contact lead capture, and perfect 99 Lighthouse performance.', 26500, 10, 'Accepted'),
(122, 31, 2, 'Web designer with HTML5/CSS3 and JavaScript animation skills for modern corporate portfolios.', 27500, 12, 'Pending'),
(123, 31, 3, 'WordPress developer with customized theme building experience for professional consultants.', 29500, 15, 'Rejected'),
(124, 31, 4, 'Junior frontend developer familiar with responsive grid and form handling.', 25000, 9, 'Rejected'),

-- Project 32 (Budget: 135000)
(125, 32, 5, 'Full stack web architect with Next.js, Node.js, and PostgreSQL. Built comprehensive school management information portals with daily attendance logging, fee payment tracking, student reports, and parent alerts.', 128000, 38, 'Accepted'),
(126, 32, 6, 'Backend developer with Express, Sequelize, and relational data schema for academic records.', 132000, 42, 'Pending'),
(127, 32, 7, 'Frontend engineer with React and Material UI data table experience for admin portals.', 142000, 48, 'Rejected'),
(128, 32, 8, 'Web programmer with PHP and MySQL database school management experience.', 124000, 35, 'Rejected'),

-- Project 33 (Budget: 88000)
(129, 33, 9, 'Full stack developer with React, Node.js, and Leaflet.js. Built real estate property listing portals featuring searchable geo-filters, high-resolution photo galleries, agent contact workflows, and lead routing.', 84000, 26, 'Accepted'),
(130, 33, 10, 'Web engineer with Express and SQL search query optimization for property listings.', 86500, 28, 'Pending'),
(131, 33, 11, 'Frontend developer with React and responsive property card grids.', 93000, 32, 'Rejected'),
(132, 33, 12, 'Full stack hobbyist with basic MongoDB and Node.js knowledge.', 81000, 24, 'Rejected'),

-- Project 34 (Budget: 65000)
(133, 34, 13, 'Web developer with Next.js, Tailwind CSS, and Razorpay donation integration. Developed non-profit campaign portals with live funding meters, volunteer registration funnels, and automated 80G tax receipt generation.', 62000, 20, 'Accepted'),
(134, 34, 14, 'Frontend engineer with React and responsive donation form validation.', 64000, 22, 'Pending'),
(135, 34, 15, 'WordPress developer with GiveWP donation plugin experience.', 69000, 26, 'Rejected'),
(136, 34, 16, 'Junior developer eager to assist non-profit organizations with website deployment.', 59000, 18, 'Rejected'),

-- Project 35 (Budget: 46000)
(137, 35, 17, 'Full stack web developer with React, Node.js, and MySQL. Built salon appointment booking portals with real-time staff calendar schedules, service package selections, and automated SMS confirmation alerts.', 44000, 16, 'Accepted'),
(138, 35, 18, 'Backend engineer with Express and SQL scheduling transaction locks to prevent double booking.', 45500, 18, 'Pending'),
(139, 35, 19, 'Frontend developer with React and interactive calendar timeline components.', 49000, 22, 'Rejected'),
(140, 35, 20, 'Web programmer with PHP and relational database booking scripts.', 42000, 15, 'Rejected'),

-- Project 36 (Budget: 112000)
(141, 36, 21, 'Enterprise systems developer with React, Node.js, and Active Directory integration. Built secure internal intranets with departmental document stores, searchable employee directories, and company-wide bulletin boards.', 107000, 32, 'Accepted'),
(142, 36, 22, 'Backend engineer with Express and role-based access control for corporate intranets.', 110000, 35, 'Pending'),
(143, 36, 23, 'Frontend engineer with React and corporate design system implementations.', 118000, 40, 'Rejected'),
(144, 36, 24, 'Software developer with relational database skills and employee record handling.', 103000, 30, 'Rejected'),

-- Project 37 (Budget: 145000)
(145, 37, 25, 'Full stack web engineer with Next.js, Redis, and high-concurrency ticket locking. Built event portals with interactive seat maps, QR-code pass generation, Razorpay payment webhooks, and organizer entry validation apps.', 138000, 38, 'Accepted'),
(146, 37, 26, 'Backend engineer with Node.js and distributed lock mechanisms for high-demand ticket sales.', 142000, 42, 'Pending'),
(147, 37, 27, 'Frontend developer with React Canvas and interactive seat reservation layouts.', 152000, 48, 'Rejected'),
(148, 37, 28, 'Web programmer with basic ticketing form handling and database models.', 134000, 36, 'Rejected'),

-- Project 38 (Budget: 58000)
(149, 38, 29, 'Web developer with Next.js, Tailwind CSS, and headless CMS. Built training institute portals with course syllabus showcases, faculty credentials, admission enquiry workflows, and video testimonial carousels.', 55000, 18, 'Accepted'),
(150, 38, 30, 'Frontend developer with React and responsive landing page lead funnels.', 57000, 20, 'Pending'),
(151, 38, 1, 'WordPress elementor expert with training institute marketing experience.', 61500, 24, 'Rejected'),
(152, 38, 2, 'Junior web coder with HTML5, CSS3, and lead capture form setup.', 53000, 17, 'Rejected'),

-- Project 39 (Budget: 35000)
(153, 39, 3, 'Full stack web developer with React, Node.js, and PostgreSQL. Built restaurant reservation websites with digital menu showcases, interactive floor table layouts, and automated reservation SMS alerts.', 33500, 14, 'Accepted'),
(154, 39, 4, 'Backend engineer with Express, Twilio integration, and table booking APIs.', 34500, 16, 'Pending'),
(155, 39, 5, 'Frontend developer with React and responsive food menu display filters.', 37500, 19, 'Rejected'),
(156, 39, 6, 'Web developer with PHP and MySQL reservation script experience.', 32000, 13, 'Rejected'),

-- Project 40 (Budget: 170000)
(157, 40, 7, 'Enterprise supply chain developer with React, Node.js, and PostgreSQL. Built industrial distributor portals featuring real-time warehouse inventory monitoring, bulk purchase orders, barcode dispatch logging, and analytics.', 162000, 48, 'Accepted'),
(158, 40, 8, 'Backend developer with Express and SQL stored procedures for complex inventory balance calculations.', 167000, 52, 'Pending'),
(159, 40, 9, 'Frontend engineer with React, Redux, and high-density inventory data tables.', 178000, 58, 'Rejected'),
(160, 40, 10, 'Full stack developer with basic inventory tracking database experience.', 158000, 45, 'Rejected'),

-- Project 41 (Budget: 18000)
(161, 41, 11, 'Senior visual designer with 5 years experience creating brand identities for cafes and restaurants. Delivered complete brand guidelines, typography palettes, packaging mockups, and vector print collateral in Adobe Illustrator.', 17000, 10, 'Accepted'),
(162, 41, 12, 'Graphic designer specializing in cafe branding, menu layouts, and social creative.', 17500, 12, 'Pending'),
(163, 41, 13, 'Visual designer with basic logo and business card layout experience.', 19200, 14, 'Rejected'),
(164, 41, 14, 'Design apprentice with Canva and Adobe Photoshop layout experience.', 16000, 9, 'Rejected'),

-- Project 42 (Budget: 48000)
(165, 42, 15, 'Senior UI/UX designer with deep Figma design system and tokenized component mastery. Prepared responsive banking dashboard interfaces featuring account summaries, financial charts, and WCAG AA accessibility compliance.', 45500, 18, 'Accepted'),
(166, 42, 16, 'UI designer with experience in financial data visualization screens and dark themes in Figma.', 47000, 20, 'Pending'),
(167, 42, 17, 'Visual designer with Adobe XD and banking dashboard wireframe background.', 51000, 24, 'Rejected'),
(168, 42, 18, 'UI apprentice capable of assisting with design system icon documentation.', 44000, 16, 'Rejected'),

-- Project 43 (Budget: 42000)
(169, 43, 19, 'Mobile product designer with comprehensive Figma experience. Engineered reusable travel UI kits covering user onboarding, flight/hotel booking cards, profile dashboards, and detailed itinerary screens with interactive prototypes.', 40000, 16, 'Accepted'),
(170, 43, 20, 'UI/UX designer with mobile travel app wireframe and component library experience.', 41500, 18, 'Pending'),
(171, 43, 21, 'Visual designer with mobile application mockups and banner creation skills.', 44500, 22, 'Rejected'),
(172, 43, 22, 'Design intern capable of producing quick wireframe iterations and mood boards.', 38500, 15, 'Rejected'),

-- Project 44 (Budget: 15000)
(173, 44, 23, 'Digital creative designer with Adobe Photoshop and Illustrator. Created coordinated retail social media packages including 30 Instagram post templates, story highlights, promotional sale banners, and brand guidelines.', 14200, 8, 'Accepted'),
(174, 44, 24, 'Graphic designer with social media creative and promotional banner layout experience.', 14800, 9, 'Pending'),
(175, 44, 25, 'Visual designer with basic social post designs using Canva and Photoshop.', 16000, 12, 'Rejected'),
(176, 44, 26, 'Junior designer offering rapid promotional banner mockups.', 13500, 7, 'Rejected'),

-- Project 45 (Budget: 36000)
(177, 45, 27, 'UI/UX specialist with 4 years designing healthcare interfaces. Delivered modern dental clinic wireframes and high-fidelity Figma screens prioritized for patient service discovery and instant appointment conversion.', 34000, 14, 'Accepted'),
(178, 45, 28, 'UI designer with healthcare website mockups and patient intake form experience.', 35500, 16, 'Pending'),
(179, 45, 29, 'Visual designer with branding and medical presentation collateral background.', 38500, 20, 'Rejected'),
(180, 45, 30, 'Design intern with basic UI wireframing and user research skills.', 33000, 13, 'Rejected'),

-- Project 46 (Budget: 29000)
(181, 46, 1, 'Packaging and industrial brand designer with 5 years experience in skincare and cosmetics. Engineered 3D product packaging mockups, die-cut label specifications, print-ready CMYK files, and compliance typography.', 27500, 12, 'Accepted'),
(182, 46, 2, 'Graphic designer with cosmetic label layout and print packaging experience.', 28500, 14, 'Pending'),
(183, 46, 3, 'Visual designer with packaging mockups in Adobe Illustrator.', 31000, 17, 'Rejected'),
(184, 46, 4, 'Design apprentice with basic product label layout experience.', 26500, 11, 'Rejected'),

-- Project 47 (Budget: 65000)
(185, 47, 5, 'Lead UX researcher and product designer. Conducted operational user-flow analysis, stakeholder interviews, and delivered an interactive enterprise operations dashboard prototype in Figma with high data density.', 62000, 22, 'Accepted'),
(186, 47, 6, 'UI/UX designer with operations dashboard wireframing and clickable prototyping skills.', 64000, 24, 'Pending'),
(187, 47, 7, 'Visual designer with SaaS dashboard layouts and data chart mockups.', 69000, 28, 'Rejected'),
(188, 47, 8, 'UI apprentice focused on user interview research summaries and component documentation.', 60000, 20, 'Rejected'),

-- Project 48 (Budget: 12000)
(189, 48, 9, 'Senior graphic designer specializing in restaurant branding. Designed elegant print-ready dining menus, takeaway brochures, and responsive digital QR menu layouts with custom vector food iconography.', 11200, 7, 'Accepted'),
(190, 48, 10, 'Graphic designer with restaurant menu layout and flyer design experience.', 11800, 8, 'Pending'),
(191, 48, 11, 'Visual designer with print marketing collateral and flyer creation background.', 13000, 10, 'Rejected'),
(192, 48, 12, 'Junior designer with menu layout experience using Adobe InDesign and Illustrator.', 10800, 6, 'Rejected'),

-- Project 49 (Budget: 22000)
(193, 49, 13, 'Information designer and illustrator. Produced a coordinated series of 10 educational infographics with cohesive icon sets, data charts, and clear visual hierarchy for professional training programs.', 20500, 11, 'Accepted'),
(194, 49, 14, 'Graphic designer with educational poster and vector infographic design skills.', 21500, 12, 'Pending'),
(195, 49, 15, 'Visual designer with chart illustrations and digital marketing graphics background.', 23500, 15, 'Rejected'),
(196, 49, 16, 'Design intern capable of producing vector icon illustrations.', 19800, 10, 'Rejected'),

-- Project 50 (Budget: 55000)
(197, 50, 17, 'Conversion rate optimization and SaaS product designer. Engineered high-converting landing page designs in Figma featuring dynamic feature cards, pricing tiers, customer proof carousels, and mobile responsive variants.', 52000, 18, 'Accepted'),
(198, 50, 18, 'UI designer with SaaS landing page wireframes and interactive component prototyping skills.', 54000, 20, 'Pending'),
(199, 50, 19, 'Visual designer with marketing page illustrations and banner creation experience.', 58000, 24, 'Rejected'),
(200, 50, 20, 'Design apprentice capable of producing wireframe layouts and asset exports.', 50000, 16, 'Rejected');


-- ----------------------------------------------------------------------------
-- PART 2: MILESTONES TABLE (150 ROWS)
-- Formula: 30% (Design/Spec), 30% (Core Dev), 40% (QA/Deploy)
-- Strictly matches Member 2's exact project budgets
-- ----------------------------------------------------------------------------

INSERT INTO Milestones (
    milestone_id, project_id, title, amount, due_date, status
) VALUES
-- P1 (85000 -> 25500, 25500, 34000)
(1, 1, 'UI/UX Wireframing & Grocery Catalog Architecture', 25500, '2026-08-05', 'Completed'),
(2, 1, 'Core Cart Engine, Vendor Orders & Payment Webhooks', 25500, '2026-08-18', 'Completed'),
(3, 1, 'Delivery Tracking Integration, QA & Launch', 34000, '2026-08-30', 'Completed'),

-- P2 (42000 -> 12600, 12600, 16800)
(4, 2, 'Shopify Custom Theme Architecture & Brand Layouts', 12600, '2026-08-04', 'Completed'),
(5, 2, 'Product Variant Configurations & Checkout Rules', 12600, '2026-08-12', 'Completed'),
(6, 2, 'Shipping Rate Gateway Setup, QA & Go Live', 16800, '2026-08-20', 'Completed'),

-- P3 (165000 -> 49500, 49500, 66000)
(7, 3, 'Multi-Vendor Schema & Seller Onboarding Flows', 49500, '2026-08-10', 'Completed'),
(8, 3, 'Commission Split Logic & Distributed Catalog Engine', 49500, '2026-08-26', 'Completed'),
(9, 3, 'High Concurrency Testing & Production Deployment', 66000, '2026-09-10', 'Completed'),

-- P4 (72000 -> 21600, 21600, 28800)
(10, 4, 'Subscription Box Flow & Schedule Architecture', 21600, '2026-08-06', 'Completed'),
(11, 4, 'Recurring Stripe Billing & Delivery Slot Engine', 21600, '2026-08-18', 'Completed'),
(12, 4, 'Customer Account Dashboard & Launch', 28800, '2026-08-28', 'Completed'),

-- P5 (110000 -> 33000, 33000, 44000)
(13, 5, 'Comparison Matrix Layout & Product Filter Specs', 33000, '2026-08-08', 'Completed'),
(14, 5, 'Side-by-Side Spec Engine & Wishlist Microservice', 33000, '2026-08-22', 'Completed'),
(15, 5, 'Inventory Sync Integration & Production Launch', 44000, '2026-09-02', 'Completed'),

-- P6 (38000 -> 11400, 11400, 15200)
(16, 6, 'Bookstore Catalog Taxonomy & Search Mockups', 11400, '2026-08-04', 'Completed'),
(17, 6, 'ISBN Lookup API & Shopping Cart Implementation', 11400, '2026-08-14', 'Completed'),
(18, 6, 'Courier API Tracking & Production Release', 15200, '2026-08-22', 'Completed'),

-- P7 (95000 -> 28500, 28500, 38000)
(19, 7, 'Interactive Customizer Interface & Material Tokens', 28500, '2026-08-08', 'Completed'),
(20, 7, 'Dynamic Quotation Calculator & Dimension Logic', 28500, '2026-08-22', 'Completed'),
(21, 7, 'Order Tracking Pipeline & Staging Deployment', 38000, '2026-09-04', 'Completed'),

-- P8 (68000 -> 20400, 20400, 27200)
(22, 8, 'Skin-Type Filter Taxonomy & Responsive Grids', 20400, '2026-08-05', 'Completed'),
(23, 8, 'Review Verification System & Coupon Code Engine', 20400, '2026-08-16', 'Completed'),
(24, 8, 'Payment Gateway Webhook Audit & Launch', 27200, '2026-08-26', 'Completed'),

-- P9 (56000 -> 16800, 16800, 22400)
(25, 9, 'Sports Gear Size Chart & Inventory Architecture', 16800, '2026-08-05', 'Completed'),
(26, 9, 'Low Stock Alert Trigger & Admin Order Pipeline', 16800, '2026-08-15', 'Completed'),
(27, 9, 'Performance Optimization & Live Store Launch', 22400, '2026-08-25', 'Completed'),

-- P10 (185000 -> 55500, 55500, 74000)
(28, 10, 'B2B Procurement Workflow & Credit Term Specs', 55500, '2026-08-12', 'Completed'),
(29, 10, 'Tiered Bulk Pricing Engine & Automated Invoices', 55500, '2026-08-28', 'Completed'),
(30, 10, 'Repeat Order Automation & Enterprise Launch', 74000, '2026-09-12', 'Completed'),

-- P11 (145000 -> 43500, 43500, 58000)
(31, 11, 'Resume Entity Extraction Pipeline & Architecture', 43500, '2026-08-10', 'Completed'),
(32, 11, 'Semantic Skill Matching & Candidate Scoring Model', 43500, '2026-08-25', 'Completed'),
(33, 11, 'FastAPI Model Serving & Recruiter Dashboard Launch', 58000, '2026-09-08', 'Completed'),

-- P12 (62000 -> 18600, 18600, 24800)
(34, 12, 'FAQ Knowledge Base Embedding & Vector Schema', 18600, '2026-08-05', 'Completed'),
(35, 12, 'Semantic Retrieval & Human Handoff Routing', 18600, '2026-08-15', 'Completed'),
(36, 12, 'Embeddable Chat Widget Packaging & Deployment', 24800, '2026-08-24', 'Completed'),

-- P13 (175000 -> 52500, 52500, 70000)
(37, 13, 'Transaction Anomaly Feature Engineering Pipeline', 52500, '2026-08-12', 'Completed'),
(38, 13, 'XGBoost Risk Scoring Engine & Kafka Consumers', 52500, '2026-08-28', 'Completed'),
(39, 13, 'Sub-50ms Latency Benchmark & Production Launch', 70000, '2026-09-12', 'Completed'),

-- P14 (78000 -> 23400, 23400, 31200)
(40, 14, 'Student Metric Ingestion & Data Hygiene Models', 23400, '2026-08-06', 'Completed'),
(41, 14, 'Performance Risk Regression & Statistical Alerts', 23400, '2026-08-18', 'Completed'),
(42, 14, 'Counselor Intervention Dashboard & Production Launch', 31200, '2026-08-28', 'Completed'),

-- P15 (98000 -> 29400, 29400, 39200)
(43, 15, 'Clickstream Aggregator & Interaction Vectorizer', 29400, '2026-08-08', 'Completed'),
(44, 15, 'Collaborative Filtering Engine & Redis Cache', 29400, '2026-08-22', 'Completed'),
(45, 15, 'A/B Recommendation Routing API & Live Deploy', 39200, '2026-09-03', 'Completed'),

-- P16 (88000 -> 26400, 26400, 35200)
(46, 16, 'Whisper Transcription Hook & Parser Setup', 26400, '2026-08-07', 'Completed'),
(47, 16, 'Action Item Extraction & Deadline NLP Pipelines', 26400, '2026-08-20', 'Completed'),
(48, 16, 'Calendar Webhook Export & Production Deployment', 35200, '2026-08-31', 'Completed'),

-- P17 (125000 -> 37500, 37500, 50000)
(49, 17, 'Plant Disease Image Augmentation & Preprocessing', 37500, '2026-08-09', 'Completed'),
(50, 17, 'YOLOv8 Leaf Disease Classifier Fine-tuning', 37500, '2026-08-24', 'Completed'),
(51, 17, 'Farmer Mobile Advice API & Cloud Container Deploy', 50000, '2026-09-06', 'Completed'),

-- P18 (54000 -> 16200, 16200, 21600)
(52, 18, 'Review Data Scraping & Pre-trained BERT Hook', 16200, '2026-08-04', 'Completed'),
(53, 18, 'Aspect-Based Polarity Scoring & Topic Extraction', 16200, '2026-08-14', 'Completed'),
(54, 18, 'Recurring Complaint Alert Webhooks & Go Live', 21600, '2026-08-23', 'Completed'),

-- P19 (115000 -> 34500, 34500, 46000)
(55, 19, 'Invoice Spatial Layout Parsing & OCR Ingestion', 34500, '2026-08-09', 'Completed'),
(56, 19, 'GST Verification Logic & Line Item Parser', 34500, '2026-08-23', 'Completed'),
(57, 19, 'ERP Accounting Export Service & Final Launch', 46000, '2026-09-05', 'Completed'),

-- P20 (195000 -> 58500, 58500, 78000)
(58, 20, 'Voice Stream WebSockets & Telephony Gateway', 58500, '2026-08-12', 'Completed'),
(59, 20, 'Conversational Intent Resolution & Help Articles', 58500, '2026-08-30', 'Completed'),
(60, 20, 'Automated Support Ticket Dispatch & Deployment', 78000, '2026-09-14', 'Completed'),

-- P21 (180000 -> 54000, 54000, 72000)
(61, 21, 'Driver Dispatch Telemetry & Navigation Specs', 54000, '2026-08-12', 'Completed'),
(62, 21, 'Live Geofencing, Dynamic Fares & Trip Records', 54000, '2026-08-28', 'Completed'),
(63, 21, 'Field Testing, App Store Packaging & Launch', 72000, '2026-09-11', 'Completed'),

-- P22 (155000 -> 46500, 46500, 62000)
(64, 22, 'Restaurant Menu Schema & Order Flow Specs', 46500, '2026-08-10', 'Completed'),
(65, 22, 'Delivery Tracking GPS Sockets & Payment Hooks', 46500, '2026-08-26', 'Completed'),
(66, 22, 'Driver App Signoff & Play Store Submission', 62000, '2026-09-09', 'Completed'),

-- P23 (92000 -> 27600, 27600, 36800)
(67, 23, 'Workout Hierarchy & Interval Timer Prototype', 27600, '2026-08-07', 'Completed'),
(68, 23, 'Local Progress Graphs & Activity Schedulers', 27600, '2026-08-20', 'Completed'),
(69, 23, 'Sensor Accuracy Verification & App Store Build', 36800, '2026-08-30', 'Completed'),

-- P24 (48000 -> 14400, 14400, 19200)
(70, 24, 'Campus Notice Board Schema & Event Screen UI', 14400, '2026-08-04', 'Completed'),
(71, 24, 'Digital QR Event Passes & Push Notifications', 14400, '2026-08-14', 'Completed'),
(72, 24, 'Student Union Testing & Staging Release', 19200, '2026-08-22', 'Completed'),

-- P25 (105000 -> 31500, 31500, 42000)
(73, 25, 'Doctor Schedule Slot Architecture & User Flow', 31500, '2026-08-08', 'Completed'),
(74, 25, 'Appointment Booking State & SMS Alert Webhooks', 31500, '2026-08-22', 'Completed'),
(75, 25, 'Patient History Encryption Audit & App Launch', 42000, '2026-09-02', 'Completed'),

-- P26 (52000 -> 15600, 15600, 20800)
(76, 26, 'Expense Category Schema & Budget Cap Logic', 15600, '2026-08-05', 'Completed'),
(77, 26, 'Monthly Visual Chart Generator & Local Database', 15600, '2026-08-15', 'Completed'),
(78, 26, 'PDF Statement Exporter & Release Packaging', 20800, '2026-08-23', 'Completed'),

-- P27 (135000 -> 40500, 40500, 54000)
(79, 27, 'Provider Service Slot & Matching Architecture', 40500, '2026-08-10', 'Completed'),
(80, 27, 'Live Booking Confirmation & Rating Engine', 40500, '2026-08-25', 'Completed'),
(81, 27, 'Escrow Payment Hook Verification & App Launch', 54000, '2026-09-07', 'Completed'),

-- P28 (76000 -> 22800, 22800, 30400)
(82, 28, 'Travel Itinerary Pin Specification & Offline Spec', 22800, '2026-08-06', 'Completed'),
(83, 28, 'Journal Entry Sync & Photo Compression Pipeline', 22800, '2026-08-18', 'Completed'),
(84, 28, 'Mapbox Integration Audit & Release Packaging', 30400, '2026-08-28', 'Completed'),

-- P29 (69000 -> 20700, 20700, 27600)
(85, 29, 'Blood Donor Proximity Geocoding Architecture', 20700, '2026-08-06', 'Completed'),
(86, 29, 'Emergency Push Broadcasts & Volunteer Verification', 20700, '2026-08-17', 'Completed'),
(87, 29, 'Hospital Directory Integration & App Launch', 27600, '2026-08-27', 'Completed'),

-- P30 (120000 -> 36000, 36000, 48000)
(88, 30, 'Lesson Module Player Wireframe & Local Cache', 36000, '2026-08-09', 'Completed'),
(89, 30, 'Timed Quiz State Container & Offline Sync', 36000, '2026-08-23', 'Completed'),
(90, 30, 'Video Streaming Stress Test & App Store Launch', 48000, '2026-09-05', 'Completed'),

-- P31 (28000 -> 8400, 8400, 11200)
(91, 31, 'Responsive Portfolio Layout & Modern Wireframes', 8400, '2026-08-03', 'Completed'),
(92, 31, 'Case Study Dynamic Filters & Contact Forms', 8400, '2026-08-08', 'Completed'),
(93, 31, 'Lighthouse 99 Audit & Vercel Custom Domain Deploy', 11200, '2026-08-14', 'Completed'),

-- P32 (135000 -> 40500, 40500, 54000)
(94, 32, 'Academic Database Entity Model & Attendance Spec', 40500, '2026-08-10', 'Completed'),
(95, 32, 'Fee Collection Payment Gateway & Parent Alerts', 40500, '2026-08-25', 'Completed'),
(96, 32, 'Role Based Staff Permissions & Portal Launch', 54000, '2026-09-07', 'Completed'),

-- P33 (88000 -> 26400, 26400, 35200)
(97, 33, 'Property Search Taxonomy & Filter Architecture', 26400, '2026-08-07', 'Completed'),
(98, 33, 'Map Location Overlay & Agent Enquiry Forwarding', 26400, '2026-08-20', 'Completed'),
(99, 33, 'High Res Gallery CDN Cache & Portal Launch', 35200, '2026-08-30', 'Completed'),

-- P34 (65000 -> 19500, 19500, 26000)
(100, 34, 'NGO Campaign Showcase Layout & User Funnel', 19500, '2026-08-05', 'Completed'),
(101, 34, 'Razorpay Donation Hook & Volunteer Database', 19500, '2026-08-16', 'Completed'),
(102, 34, 'Automated 80G Tax Receipt Generator & Go Live', 26000, '2026-08-25', 'Completed'),

-- P35 (46000 -> 13800, 13800, 18400)
(103, 35, 'Salon Service Menu & Stylist Calendar Specs', 13800, '2026-08-04', 'Completed'),
(104, 35, 'Slot Locking State & Automated SMS Webhooks', 13800, '2026-08-13', 'Completed'),
(105, 35, 'Customer Review Engine & Production Hosting', 18400, '2026-08-21', 'Completed'),

-- P36 (112000 -> 33600, 33600, 44800)
(106, 36, 'Intranet Security Schema & Employee Directory', 33600, '2026-08-08', 'Completed'),
(107, 36, 'Department Document Storage & Bulletin Feeds', 33600, '2026-08-22', 'Completed'),
(108, 36, 'LDAP Single Sign-On Integration & Portal Launch', 44800, '2026-09-03', 'Completed'),

-- P37 (145000 -> 43500, 43500, 58000)
(109, 37, 'Interactive Seat Layout Model & Pricing Tier Spec', 43500, '2026-08-10', 'Completed'),
(110, 37, 'Concurreny Ticket Lock & Razorpay Payment Engine', 43500, '2026-08-26', 'Completed'),
(111, 37, 'QR Code Ticket Verification Scanner & Go Live', 58000, '2026-09-08', 'Completed'),

-- P38 (58000 -> 17400, 17400, 23200)
(112, 38, 'Course Syllabus Navigation & Faculty Profiles', 17400, '2026-08-05', 'Completed'),
(113, 38, 'Admission Lead Capture & Video Review Carousels', 17400, '2026-08-15', 'Completed'),
(114, 38, 'SEO Schema Integration & Production Deployment', 23200, '2026-08-24', 'Completed'),

-- P39 (35000 -> 10500, 10500, 14000)
(115, 39, 'Restaurant Digital Menu Layout & Table Blueprint', 10500, '2026-08-04', 'Completed'),
(116, 39, 'Interactive Table Reservation Engine & Alerts', 10500, '2026-08-12', 'Completed'),
(117, 39, 'Mobile Responsive Contact View & Production Launch', 14000, '2026-08-19', 'Completed'),

-- P40 (170000 -> 51000, 51000, 68000)
(118, 40, 'Warehouse Stock Entity Architecture & PO Schemas', 51000, '2026-08-11', 'Completed'),
(119, 40, 'Barcode Dispatch Scanner & Real-time Balance', 51000, '2026-08-27', 'Completed'),
(120, 40, 'High Throughput Testing & Enterprise Release', 68000, '2026-09-11', 'Completed'),

-- P41 (18000 -> 5400, 5400, 7200)
(121, 41, 'Cafe Visual Identity Discovery & Logo Sketches', 5400, '2026-08-03', 'Completed'),
(122, 41, 'Color Palette Tokens, Typography & Brand Guide', 5400, '2026-08-08', 'Completed'),
(123, 41, 'Packaging Mockups & Print Collateral Handoff', 7200, '2026-08-13', 'Completed'),

-- P42 (48000 -> 14400, 14400, 19200)
(124, 42, 'Banking Flow Wireframes & Account Card Layouts', 14400, '2026-08-04', 'Completed'),
(125, 42, 'Tokenized Component Library & Dark Theme Styles', 14400, '2026-08-14', 'Completed'),
(126, 42, 'Interactive Clickable Figma Prototype Signoff', 19200, '2026-08-22', 'Completed'),

-- P43 (42000 -> 12600, 12600, 16800)
(127, 43, 'Travel Mobile UI Kit Specifications & Wireframes', 12600, '2026-08-04', 'Completed'),
(128, 43, 'Booking Flow Components & Profile Screen Tokens', 12600, '2026-08-12', 'Completed'),
(129, 43, 'Comprehensive Figma Component Package Handoff', 16800, '2026-08-20', 'Completed'),

-- P44 (15000 -> 4500, 4500, 6000)
(130, 44, 'Social Media Brand Visual Strategy & Moodboards', 4500, '2026-08-03', 'Completed'),
(131, 44, 'Instagram Post & Story Editable Templates', 4500, '2026-08-07', 'Completed'),
(132, 44, 'Promotional Sale Banners & Brand Kit Delivery', 6000, '2026-08-11', 'Completed'),

-- P45 (36000 -> 10800, 10800, 14400)
(133, 45, 'Dental Patient Journey Discovery & Low-Fi Wireframes', 10800, '2026-08-04', 'Completed'),
(134, 45, 'Service Discovery Components & Booking Form Layouts', 10800, '2026-08-12', 'Completed'),
(135, 45, 'High Fidelity Figma Prototypes & Dev Specs', 14400, '2026-08-18', 'Completed'),

-- P46 (29000 -> 8700, 8700, 11600)
(136, 46, 'Skincare Packaging Ergonomics & Box Die-Lines', 8700, '2026-08-03', 'Completed'),
(137, 46, 'Cosmetics Label Design & Regulatory Typography', 8700, '2026-08-09', 'Completed'),
(138, 46, '3D Mockup Visualizations & CMYK Print Files', 11600, '2026-08-15', 'Completed'),

-- P47 (65000 -> 19500, 19500, 26000)
(139, 47, 'Operations Flow Audit & User Interview Findings', 19500, '2026-08-06', 'Completed'),
(140, 47, 'High Density Data Grid System & Navigation Tokens', 19500, '2026-08-16', 'Completed'),
(141, 47, 'Interactive Operational Prototype Handoff', 26000, '2026-08-26', 'Completed'),

-- P48 (12000 -> 3600, 3600, 4800)
(142, 48, 'Restaurant Typography Concept & Menu Wireframe', 3600, '2026-08-02', 'Completed'),
(143, 48, 'Dining Menu Layout & Custom Food Iconography', 3600, '2026-08-06', 'Completed'),
(144, 48, 'Print Ready CMYK Menus & Digital QR Assets', 4800, '2026-08-10', 'Completed'),

-- P49 (22000 -> 6600, 6600, 8800)
(145, 49, 'Educational Topic Breakdown & Infographic Structure', 6600, '2026-08-03', 'Completed'),
(146, 49, 'Vector Data Visualizers & Custom Icon Badges', 6600, '2026-08-08', 'Completed'),
(147, 49, '10-Part Coordinated Infographic Asset Package', 8800, '2026-08-14', 'Completed'),

-- P50 (55000 -> 16500, 16500, 22000)
(148, 50, 'SaaS Landing Page Conversion Wireframes', 16500, '2026-08-05', 'Completed'),
(149, 50, 'Feature Showcase Components & Pricing Calculator', 16500, '2026-08-14', 'Completed'),
(150, 50, 'Responsive Layouts & Figma Auto-Layout Handoff', 22000, '2026-08-23', 'Completed');


-- ----------------------------------------------------------------------------
-- PART 3: SUBMISSIONS TABLE (100 ROWS)
-- ----------------------------------------------------------------------------

INSERT INTO Submissions (
    submission_id, application_id, version, file_url, submission_notes, submitted_at, status
) VALUES
-- Direct Pass Projects (v1.0 Approved) -> 20 Projects / 20 Rows
(1, 1, 'v1.0', 'https://github.com/freelancer01/mohalli-grocery-portal', 'Final production build delivered with comprehensive test coverage and Razorpay integration documentation.', '2026-08-28 16:30:00', 'Approved'),
(2, 5, 'v1.0', 'https://github.com/freelancer05/artisan-shopify-store', 'Custom Shopify storefront theme bundled with automated shipping rules and order dashboard docs.', '2026-08-19 14:15:00', 'Approved'),
(3, 9, 'v1.0', 'https://github.com/freelancer09/multivendor-fashion-hub', 'Multi-tenant vendor architecture completed with automated commission splitting and live testing logs.', '2026-09-08 11:45:00', 'Approved'),
(4, 13, 'v1.0', 'https://github.com/freelancer13/organic-subscription-engine', 'Subscription commerce engine deployed with Stripe webhook handlers and recurring scheduler tests.', '2026-08-27 18:00:00', 'Approved'),
(5, 17, 'v1.0', 'https://github.com/freelancer17/electronics-spec-compare', 'High speed spec comparison matrix delivered with dynamic filtering and live inventory sync.', '2026-08-31 17:30:00', 'Approved'),
(6, 21, 'v1.0', 'https://github.com/freelancer21/bookstore-isbn-portal', 'MERN stack bookstore catalog engine with ISBN barcode search and automated seed scripts.', '2026-08-21 15:20:00', 'Approved'),
(7, 25, 'v1.0', 'https://github.com/freelancer25/furniture-customizer-3d', 'Three.js interactive product customizer allowing real time material finish and quote calculations.', '2026-09-02 19:10:00', 'Approved'),
(8, 29, 'v1.0', 'https://github.com/freelancer29/beauty-commerce-nextjs', 'Next.js storefront with skin-type recommendation quiz and 98 Lighthouse performance score.', '2026-08-25 12:00:00', 'Approved'),
(9, 33, 'v1.0', 'https://github.com/freelancer03/sports-equipment-store', 'E-commerce sports platform featuring dynamic size chart matrices and low stock alert workers.', '2026-08-24 16:45:00', 'Approved'),
(10, 37, 'v1.0', 'https://github.com/freelancer07/b2b-wholesale-procurement', 'Enterprise wholesale ordering system with volume tier pricing and automated GST invoice PDFs.', '2026-09-10 14:30:00', 'Approved'),
(11, 41, 'v1.0', 'https://github.com/freelancer11/ai-resume-ranker-py', 'NLP resume parsing pipeline with semantic matching algorithms and candidate ranking APIs.', '2026-09-06 18:20:00', 'Approved'),
(12, 45, 'v1.0', 'https://github.com/freelancer15/faq-chroma-chatbot', 'Conversational FAQ retrieval assistant with LangChain, Redis caching, and human handoff fallback.', '2026-08-23 15:10:00', 'Approved'),
(13, 49, 'v1.0', 'https://github.com/freelancer19/fraud-detection-xgboost', 'Real-time transaction risk scoring microservice containerized with Docker and verified via Kafka.', '2026-09-10 20:00:00', 'Approved'),
(14, 53, 'v1.0', 'https://github.com/freelancer23/student-analytics-dash', 'Predictive educational risk dashboard analyzing attendance trends with automated alert triggers.', '2026-08-26 16:00:00', 'Approved'),
(15, 57, 'v1.0', 'https://github.com/freelancer27/retail-recommendation-ai', 'Collaborative filtering microservice calculating affinity scores with Redis vector lookup.', '2026-09-01 17:40:00', 'Approved'),
(16, 61, 'v1.0', 'https://github.com/freelancer01/meeting-action-extractor', 'NLP meeting summarizer with Whisper transcription and structured calendar action exports.', '2026-08-29 13:50:00', 'Approved'),
(17, 65, 'v1.0', 'https://github.com/freelancer05/plant-leaf-yolov8', 'YOLOv8 crop leaf disease classifier fine-tuned with 96% accuracy on test field photos.', '2026-09-04 11:30:00', 'Approved'),
(18, 69, 'v1.0', 'https://github.com/freelancer09/review-sentiment-bert', 'Aspect-based sentiment analysis pipeline classifying feedback with complaint cluster triggers.', '2026-08-21 18:15:00', 'Approved'),
(19, 73, 'v1.0', 'https://github.com/freelancer13/invoice-layoutlm-ocr', 'Document AI invoice reader extracting vendor GST, totals, and line items with 99% accuracy.', '2026-09-03 15:00:00', 'Approved'),
(20, 77, 'v1.0', 'https://github.com/freelancer17/voice-helpdesk-assistant', 'Speech-enabled support assistant resolving common user queries and issuing support tickets.', '2026-09-12 17:10:00', 'Approved'),

-- Two-Attempt Projects (v1.0 Rejected -> v2.0 Approved) -> 15 Projects / 30 Rows
(21, 81, 'v1.0', 'https://github.com/freelancer21/taxi-dispatch-flutter', 'Initial taxi booking app; GPS telemetry dropped when device entered battery save state.', '2026-08-26 10:00:00', 'Rejected'),
(22, 81, 'v2.0', 'https://github.com/freelancer21/taxi-dispatch-flutter', 'Implemented native Android foreground service and offline GPS buffer for continuous telemetry.', '2026-09-09 16:30:00', 'Approved'),

(23, 85, 'v1.0', 'https://github.com/freelancer25/food-delivery-flutter', 'Initial food delivery build; live socket tracking disconnected during payment redirect.', '2026-08-24 09:30:00', 'Rejected'),
(24, 85, 'v2.0', 'https://github.com/freelancer25/food-delivery-flutter', 'Added persistent socket reconnect handlers and Razorpay webhook verification fallbacks.', '2026-09-07 15:00:00', 'Approved'),

(25, 89, 'v1.0', 'https://github.com/freelancer29/workout-planner-bloc', 'Initial fitness app; workout interval timer paused when device screen turned off.', '2026-08-18 14:00:00', 'Rejected'),
(26, 89, 'v2.0', 'https://github.com/freelancer29/workout-planner-bloc', 'Configured wake-lock background service, verified 90-minute uninterrupted workout timer.', '2026-08-28 17:30:00', 'Approved'),

(27, 93, 'v1.0', 'https://github.com/freelancer03/campus-event-rn', 'Initial event app; digital QR pass generation failed when device was offline.', '2026-08-12 11:00:00', 'Rejected'),
(28, 93, 'v2.0', 'https://github.com/freelancer03/campus-event-rn', 'Cached cryptographically signed offline passes in SQLite with instant scan validation.', '2026-08-20 16:45:00', 'Approved'),

(29, 97, 'v1.0', 'https://github.com/freelancer07/doctor-booking-flutter', 'Initial healthcare booking app; concurrent appointments caused doctor schedule overlap.', '2026-08-20 15:00:00', 'Rejected'),
(30, 97, 'v2.0', 'https://github.com/freelancer07/doctor-booking-flutter', 'Implemented database level row-locking on consultation slots, preventing double booking.', '2026-08-31 18:20:00', 'Approved'),

(31, 101, 'v1.0', 'https://github.com/freelancer11/expense-manager-flutter', 'Initial expense tracker; PDF export crashed when monthly transaction list exceeded 200 items.', '2026-08-14 10:45:00', 'Rejected'),
(32, 101, 'v2.0', 'https://github.com/freelancer11/expense-manager-flutter', 'Refactored PDF generation with chunked streams, eliminating out-of-memory crashes.', '2026-08-21 14:15:00', 'Approved'),

(33, 105, 'v1.0', 'https://github.com/freelancer15/home-service-marketplace', 'Initial service app; technician availability status failed to update in real-time.', '2026-08-23 11:20:00', 'Rejected'),
(34, 105, 'v2.0', 'https://github.com/freelancer15/home-service-marketplace', 'Implemented WebSocket presence sets in Redis for instant technician availability changes.', '2026-09-05 16:00:00', 'Approved'),

(35, 109, 'v1.0', 'https://github.com/freelancer19/travel-companion-flutter', 'Initial trip journal; photo uploads blocked the main thread causing UI lag.', '2026-08-16 13:30:00', 'Rejected'),
(36, 109, 'v2.0', 'https://github.com/freelancer19/travel-companion-flutter', 'Added background compute isolates for image compression before S3 upload.', '2026-08-26 19:10:00', 'Approved'),

(37, 113, 'v1.0', 'https://github.com/freelancer23/blood-donor-network', 'Initial emergency blood network; location queries took > 4 seconds across city radius.', '2026-08-15 14:00:00', 'Rejected'),
(38, 113, 'v2.0', 'https://github.com/freelancer23/blood-donor-network', 'Added MySQL geospatial ST_Distance_Sphere spatial index, dropping radius query to 85ms.', '2026-08-25 17:00:00', 'Approved'),

(39, 117, 'v1.0', 'https://github.com/freelancer27/elearning-quiz-flutter', 'Initial e-learning app; timed quiz answers were lost if network dropped during submission.', '2026-08-21 16:00:00', 'Rejected'),
(40, 117, 'v2.0', 'https://github.com/freelancer27/elearning-quiz-flutter', 'Added SQLite local answer journaling with automatic retry worker on connection restore.', '2026-09-03 18:30:00', 'Approved'),

(41, 121, 'v1.0', 'https://github.com/freelancer01/consultant-nextjs-site', 'Initial portfolio build scored 78 on mobile Lighthouse due to uncompressed images.', '2026-08-06 12:15:00', 'Rejected'),
(42, 121, 'v2.0', 'https://github.com/freelancer01/consultant-nextjs-site', 'Converted all case study images to WebP with next/image responsive srcsets; scored 99.', '2026-08-12 16:00:00', 'Approved'),

(43, 125, 'v1.0', 'https://github.com/freelancer05/school-portal-nextjs', 'Initial school portal; fee report CSV export timed out under 5000 student records.', '2026-08-22 10:00:00', 'Rejected'),
(44, 125, 'v2.0', 'https://github.com/freelancer05/school-portal-nextjs', 'Implemented asynchronous background job worker and streaming CSV response for fee reports.', '2026-09-05 15:45:00', 'Approved'),

(45, 129, 'v1.0', 'https://github.com/freelancer09/realestate-map-portal', 'Initial property site; map pin clustering crashed on mobile browsers with 500+ properties.', '2026-08-18 14:20:00', 'Rejected'),
(46, 129, 'v2.0', 'https://github.com/freelancer09/realestate-map-portal', 'Integrated Supercluster geo-indexing for smooth 60 FPS viewport pin clustering.', '2026-08-28 18:00:00', 'Approved'),

(47, 133, 'v1.0', 'https://github.com/freelancer13/ngo-campaign-nextjs', 'Initial NGO portal; donation form did not generate 80G tax receipt PDF automatically.', '2026-08-14 13:00:00', 'Rejected'),
(48, 133, 'v2.0', 'https://github.com/freelancer13/ngo-campaign-nextjs', 'Integrated automated PDF generator engine sending tax receipts via email upon donation.', '2026-08-23 17:30:00', 'Approved'),

(49, 137, 'v1.0', 'https://github.com/freelancer17/salon-appointment-web', 'Initial salon app; timezone discrepancies caused appointments to shift by 30 minutes.', '2026-08-11 15:30:00', 'Rejected'),
(50, 137, 'v2.0', 'https://github.com/freelancer17/salon-appointment-web', 'Stored all booking timestamps in UTC with client-side localization and row locking.', '2026-08-19 19:00:00', 'Approved'),

-- Three-Attempt Projects (v1.0 Rejected -> v2.0 Pending -> v3.0 Approved) -> 15 Projects / 50 Rows
-- Project 36
(51, 141, 'v1.0', 'https://github.com/freelancer21/enterprise-intranet-portal', 'Initial intranet build; Active Directory LDAP authentication failed over SSL protocol.', '2026-08-20 11:00:00', 'Rejected'),
(52, 141, 'v2.0', 'https://github.com/freelancer21/enterprise-intranet-portal', 'Configured TLS certificate bundle for secure LDAP binding; awaiting enterprise network audit.', '2026-08-27 16:00:00', 'Pending'),
(53, 141, 'v3.0', 'https://github.com/freelancer21/enterprise-intranet-portal', 'Verified seamless single sign-on across 500 corporate test users on staging domain.', '2026-09-02 20:30:00', 'Approved'),

-- Project 37
(54, 145, 'v1.0', 'https://github.com/freelancer25/event-ticket-concurrency', 'Initial ticketing platform; race condition allowed ticket sales exceeding auditorium quota.', '2026-08-23 10:00:00', 'Rejected'),
(55, 145, 'v2.0', 'https://github.com/freelancer25/event-ticket-concurrency', 'Implemented Redis atomic distributed locks during seat checkout; pending load testing.', '2026-08-30 14:30:00', 'Pending'),
(56, 145, 'v3.0', 'https://github.com/freelancer25/event-ticket-concurrency', 'Verified with 1000 simulated concurrent booking requests with zero oversold seats.', '2026-09-06 18:00:00', 'Approved'),

-- Project 38
(57, 149, 'v1.0', 'https://github.com/freelancer29/training-institute-nextjs', 'Initial institute portal; video testimonial player caused high Cumulative Layout Shift.', '2026-08-12 13:00:00', 'Rejected'),
(58, 149, 'v2.0', 'https://github.com/freelancer29/training-institute-nextjs', 'Replaced video embed with lazy loaded responsive thumbnail modals; verification pending.', '2026-08-17 17:00:00', 'Pending'),
(59, 149, 'v3.0', 'https://github.com/freelancer29/training-institute-nextjs', 'CLS reduced to 0.00 and green Core Web Vitals confirmed across desktop and mobile.', '2026-08-22 21:00:00', 'Approved'),

-- Project 39
(60, 153, 'v1.0', 'https://github.com/freelancer03/restaurant-table-reservation', 'Initial reservation module; floor plan seating failed interactive drag touch on iPad.', '2026-08-09 11:30:00', 'Rejected'),
(61, 153, 'v2.0', 'https://github.com/freelancer03/restaurant-table-reservation', 'Added TouchEvent listeners with CSS hardware acceleration; under client iPad review.', '2026-08-14 15:00:00', 'Pending'),
(62, 153, 'v3.0', 'https://github.com/freelancer03/restaurant-table-reservation', 'Smooth 60 FPS table selection verified on iOS Safari, Chrome, and Android tablets.', '2026-08-18 18:45:00', 'Approved'),

-- Project 40
(63, 157, 'v1.0', 'https://github.com/freelancer07/warehouse-distributor-portal', 'Initial inventory system; high concurrency barcode scans resulted in inventory deadlock.', '2026-08-24 14:00:00', 'Rejected'),
(64, 157, 'v2.0', 'https://github.com/freelancer07/warehouse-distributor-portal', 'Added FIFO transactional queue on stock updates; soak testing in progress.', '2026-08-31 18:00:00', 'Pending'),
(65, 157, 'v3.0', 'https://github.com/freelancer07/warehouse-distributor-portal', 'Passed 10,000 simulated warehouse item scans with 100% stock count accuracy.', '2026-09-09 20:00:00', 'Approved'),

-- Project 41
(66, 161, 'v1.0', 'https://github.com/freelancer11/cafe-branding-identity', 'Initial cafe logo; vector files lacked CMYK color profiles for commercial offset printing.', '2026-08-06 12:00:00', 'Rejected'),
(67, 161, 'v2.0', 'https://github.com/freelancer11/cafe-branding-identity', 'Re-exported all packaging and menu vector assets with Fogra39 CMYK profiles; review active.', '2026-08-10 16:30:00', 'Pending'),
(68, 161, 'v3.0', 'https://github.com/freelancer11/cafe-branding-identity', 'Received signoff on complete branding package with approved print vendor color proofs.', '2026-08-12 19:30:00', 'Approved'),

-- Project 42
(69, 165, 'v1.0', 'https://github.com/freelancer15/banking-dashboard-figma', 'Initial banking UI; transaction data tables lacked accessible contrast ratio for seniors.', '2026-08-11 10:30:00', 'Rejected'),
(70, 165, 'v2.0', 'https://github.com/freelancer15/banking-dashboard-figma', 'Updated color tokens to 7:1 AAA contrast and added scalable font variables; under review.', '2026-08-16 14:00:00', 'Pending'),
(71, 165, 'v3.0', 'https://github.com/freelancer15/banking-dashboard-figma', 'Passed full WCAG 2.1 AAA accessibility audit with responsive component token library.', '2026-08-20 17:15:00', 'Approved'),

-- Project 43
(72, 169, 'v1.0', 'https://github.com/freelancer19/travel-uikit-figma', 'Initial mobile UI kit; lacked component variants for empty flight search results.', '2026-08-10 13:00:00', 'Rejected'),
(73, 169, 'v2.0', 'https://github.com/freelancer19/travel-uikit-figma', 'Added empty, error, and loading state component variants; design system review in progress.', '2026-08-15 17:30:00', 'Pending'),
(74, 169, 'v3.0', 'https://github.com/freelancer19/travel-uikit-figma', 'Approved clickable prototype covering 45 responsive travel screens with complete tokens.', '2026-08-19 21:00:00', 'Approved'),

-- Project 44
(75, 173, 'v1.0', 'https://github.com/freelancer23/retail-social-package', 'Initial social templates; post dimensions did not align with latest 4:5 portrait ratio.', '2026-08-05 11:00:00', 'Rejected'),
(76, 173, 'v2.0', 'https://github.com/freelancer23/retail-social-package', 'Re-formatted all 30 posts to 1080x1350px with safe zone grid overlays; pending client check.', '2026-08-08 15:30:00', 'Pending'),
(77, 173, 'v3.0', 'https://github.com/freelancer23/retail-social-package', 'Received client signoff for all 30 Instagram post templates and coordinated story designs.', '2026-08-10 18:30:00', 'Approved'),

-- Project 45
(78, 177, 'v1.0', 'https://github.com/freelancer27/dental-clinic-redesign', 'Initial wireframes; booking conversion funnel required too many steps on mobile viewports.', '2026-08-09 15:00:00', 'Rejected'),
(79, 177, 'v2.0', 'https://github.com/freelancer27/dental-clinic-redesign', 'Redesigned into 2-step instant booking flow with sticky mobile CTA; under clinic review.', '2026-08-14 18:45:00', 'Pending'),
(80, 177, 'v3.0', 'https://github.com/freelancer27/dental-clinic-redesign', 'Validated mobile prototype demonstrating 35% faster appointment submission in usability tests.', '2026-08-17 21:15:00', 'Approved'),

-- Project 46
(81, 181, 'v1.0', 'https://github.com/freelancer01/skincare-packaging-design', 'Initial packaging die-line; bleed margins did not meet commercial cardboard specifications.', '2026-08-07 12:00:00', 'Rejected'),
(82, 181, 'v2.0', 'https://github.com/freelancer01/skincare-packaging-design', 'Extended bleed to 3mm with crop marks and added foil-stamp layer; packaging printer checking.', '2026-08-11 16:30:00', 'Pending'),
(83, 181, 'v3.0', 'https://github.com/freelancer01/skincare-packaging-design', 'Print vendor certified production-ready die-cut files and 3D mockup renders.', '2026-08-14 20:00:00', 'Approved'),

-- Project 47
(84, 185, 'v1.0', 'https://github.com/freelancer05/operations-ux-prototype', 'Initial dashboard prototype; navigation sidebar consumed excessive desktop screen width.', '2026-08-13 10:30:00', 'Rejected'),
(85, 185, 'v2.0', 'https://github.com/freelancer05/operations-ux-prototype', 'Added collapsible icon-only sidebar mode with tooltip hover; stakeholder review active.', '2026-08-19 14:00:00', 'Pending'),
(86, 185, 'v3.0', 'https://github.com/freelancer05/operations-ux-prototype', 'Approved interactive prototype maximizing operational table data space by 22%.', '2026-08-24 17:00:00', 'Approved'),

-- Project 48
(87, 189, 'v1.0', 'https://github.com/freelancer09/restaurant-menu-collateral', 'Initial dining menu; font kerning and size rendered unreadable under low restaurant lighting.', '2026-08-04 14:00:00', 'Rejected'),
(88, 189, 'v2.0', 'https://github.com/freelancer09/restaurant-menu-collateral', 'Adjusted font leading and selected high-legibility serif headings; sample print under review.', '2026-08-07 18:30:00', 'Pending'),
(89, 189, 'v3.0', 'https://github.com/freelancer09/restaurant-menu-collateral', 'Approved laminated print sample and high-contrast digital QR menu assets.', '2026-08-09 21:30:00', 'Approved'),

-- Project 49
(90, 193, 'v1.0', 'https://github.com/freelancer13/educational-infographics', 'Initial infographic series; complex statistical charts lacked clear visual legends.', '2026-08-06 11:30:00', 'Rejected'),
(91, 193, 'v2.0', 'https://github.com/freelancer13/educational-infographics', 'Added color-coded data callout keys and simplified percentage pie diagrams; review pending.', '2026-08-10 16:00:00', 'Pending'),
(92, 193, 'v3.0', 'https://github.com/freelancer13/educational-infographics', 'Delivered 10 completed high-res educational infographics with vector asset source files.', '2026-08-13 19:00:00', 'Approved'),

-- Project 50
(93, 197, 'v1.0', 'https://github.com/freelancer17/saas-landing-figma', 'Initial landing page design; pricing toggle animation was choppy in Figma prototype.', '2026-08-11 13:00:00', 'Rejected'),
(94, 197, 'v2.0', 'https://github.com/freelancer17/saas-landing-figma', 'Re-built billing toggle using Figma smart-animate components; awaiting client feedback.', '2026-08-17 17:00:00', 'Pending'),
(95, 197, 'v3.0', 'https://github.com/freelancer17/saas-landing-figma', 'Approved conversion-optimized landing page with auto-layout and mobile breakpoint variants.', '2026-08-21 21:00:00', 'Approved'),

-- Additional In-Progress Submissions for Realism (Total reaches exactly 100 rows)
(96, 5, 'v1.1', 'https://github.com/freelancer05/artisan-shopify-store', 'Added localized currency conversion dropdown for overseas artisan customers.', '2026-08-20 11:00:00', 'Approved'),
(97, 21, 'v1.1', 'https://github.com/freelancer21/bookstore-isbn-portal', 'Added automated daily database backup script to S3 bucket.', '2026-08-22 12:00:00', 'Approved'),
(98, 41, 'v1.1', 'https://github.com/freelancer11/ai-resume-ranker-py', 'Added candidate anonymization filter to prevent unconscious hiring bias in screening.', '2026-09-07 10:00:00', 'Approved'),
(99, 61, 'v1.1', 'https://github.com/freelancer01/meeting-action-extractor', 'Added Microsoft Teams calendar invite webhook trigger.', '2026-08-30 09:30:00', 'Approved'),
(100, 77, 'v1.1', 'https://github.com/freelancer17/voice-helpdesk-assistant', 'Added regional acoustic model tuning for Punjabi and Hindi accent recognition.', '2026-09-13 11:30:00', 'Approved');

-- ============================================================================
-- VERIFICATION COUNT CHECK (MEMBER 3 AUDIT)
-- ============================================================================
SELECT COUNT(*) AS total_applications FROM Applications;
SELECT COUNT(*) AS total_milestones FROM Milestones;
SELECT COUNT(*) AS total_submissions FROM Submissions;
