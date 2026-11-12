-- ======================================================
-- 03_master_data_projects_skills_extended.sql
-- Freelance Project Management System - Member 2
-- MySQL 8.0+ | Professional | No Warnings
-- ======================================================

-- PART 1: INSERT 30 SKILLS
INSERT INTO Skills (skill_id, skill_name, category) VALUES
(1, 'React.js', 'Frontend'),
(2, 'Angular', 'Frontend'),
(3, 'Vue.js', 'Frontend'),
(4, 'HTML', 'Frontend'),
(5, 'CSS', 'Frontend'),
(6, 'Node.js', 'Backend'),
(7, 'Python', 'Backend'),
(8, 'Java', 'Backend'),
(9, 'PHP', 'Backend'),
(10, '.NET', 'Backend'),
(11, 'MySQL', 'Database'),
(12, 'MongoDB', 'Database'),
(13, 'PostgreSQL', 'Database'),
(14, 'Firebase', 'Database'),
(15, 'Flutter', 'Mobile'),
(16, 'React Native', 'Mobile'),
(17, 'Android', 'Mobile'),
(18, 'iOS', 'Mobile'),
(19, 'Figma', 'Design'),
(20, 'Adobe XD', 'Design'),
(21, 'Photoshop', 'Design'),
(22, 'Canva', 'Design'),
(23, 'Machine Learning', 'AI'),
(24, 'Deep Learning', 'AI'),
(25, 'Python AI', 'AI'),
(26, 'ChatGPT API', 'AI'),
(27, 'AWS', 'Others'),
(28, 'Docker', 'Others'),
(29, 'Git', 'Others'),
(30, 'Blockchain', 'Others')
AS new_skills
ON DUPLICATE KEY UPDATE
  skill_name = new_skills.skill_name,
  category = new_skills.category;

-- PART 2: INSERT 50 PROJECTS
INSERT INTO Projects (project_id, client_id, title, description, category, budget, status) VALUES
(1, 31, 'Online Grocery Marketplace for Local Stores', 'Build a marketplace where neighborhood grocery stores can list products, manage stock, and receive customer orders online.', 'E-commerce', 45000, 'Completed'),
(2, 32, 'Fashion E-commerce Store with Admin Panel', 'Develop a responsive fashion shopping website with product filters, cart, secure checkout, and order management.', 'E-commerce', 85000, 'In Progress'),
(3, 33, 'Handmade Products Shopify Store', 'Create a Shopify storefront for handmade products with collections, product variants, payment integration, and shipping details.', 'E-commerce', 32000, 'Open'),
(4, 34, 'Electronics Shopping Website', 'Develop an electronics store with comparison features, warranty information, product search, and online payment.', 'E-commerce', 110000, 'In Progress'),
(5, 35, 'Organic Food Subscription Store', 'Build an e-commerce platform where customers can subscribe to weekly organic food baskets and manage deliveries.', 'E-commerce', 95000, 'Completed'),
(6, 36, 'Multi-vendor Marketplace for Home Decor', 'Create a marketplace that allows multiple home-decor sellers to manage listings, orders, and commissions.', 'E-commerce', 150000, 'Open'),
(7, 37, 'Beauty Products Online Store', 'Design and develop a beauty store with category navigation, customer reviews, discount coupons, and inventory tracking.', 'E-commerce', 68000, 'In Progress'),
(8, 38, 'Bookstore with Digital and Physical Products', 'Build an online bookstore supporting physical book orders, downloadable products, wishlists, and recommendations.', 'E-commerce', 72000, 'Completed'),
(9, 39, 'Sports Equipment Shopping Portal', 'Develop a sports equipment store with size filters, product availability, cart, and shipment tracking.', 'E-commerce', 58000, 'Open'),
(10, 40, 'B2B Wholesale Ordering Platform', 'Create a wholesale portal with bulk pricing, business accounts, quotation requests, and repeat-order functionality.', 'E-commerce', 180000, 'In Progress'),
(11, 41, 'AI Resume Screening and Ranking System', 'Build an AI system that extracts resume details, compares candidate profiles with job requirements, and ranks applicants.', 'AI', 125000, 'In Progress'),
(12, 42, 'Customer Support Chatbot', 'Develop a chatbot using natural language processing to answer common customer questions and route complex queries to staff.', 'AI', 65000, 'Completed'),
(13, 43, 'Credit Card Fraud Detection Model', 'Train a machine-learning model to identify unusual transaction patterns and flag potentially fraudulent payments.', 'AI', 145000, 'Open'),
(14, 44, 'Student Performance Prediction System', 'Create a predictive model using attendance, assessment scores, and study patterns to identify students needing support.', 'AI', 55000, 'In Progress'),
(15, 45, 'Product Recommendation Engine', 'Develop a recommendation engine that suggests products based on browsing activity, purchase history, and user preferences.', 'AI', 98000, 'Open'),
(16, 46, 'AI-powered Invoice Data Extractor', 'Build a document-processing solution that reads invoices and extracts supplier, date, tax, and amount information.', 'AI', 78000, 'Completed'),
(17, 47, 'Plant Disease Detection using Images', 'Train an image-classification model to identify common plant diseases from leaf photographs and display treatment guidance.', 'AI', 115000, 'In Progress'),
(18, 48, 'Sales Forecasting Dashboard', 'Create a machine-learning forecasting solution that predicts monthly sales from historical sales and seasonal trends.', 'AI', 90000, 'Open'),
(19, 49, 'Email Spam Classification System', 'Develop a text-classification model that detects spam messages and explains the main indicators behind its prediction.', 'AI', 42000, 'Completed'),
(20, 50, 'AI Meeting Notes and Summary Generator', 'Build a service that converts meeting transcripts into concise summaries, action items, and assigned follow-ups.', 'AI', 160000, 'In Progress'),
(21, 31, 'Food Delivery Application for Restaurants', 'Develop an Android and iOS app for browsing nearby restaurants, placing food orders, and tracking delivery status.', 'Mobile App', 135000, 'In Progress'),
(22, 32, 'Ride Booking Application', 'Create a ride-booking app with passenger and driver interfaces, GPS location, fare estimates, and trip history.', 'Mobile App', 190000, 'Open'),
(23, 33, 'Personal Expense Tracker App', 'Build a mobile application to record daily expenses, set budgets, categorize spending, and view monthly reports.', 'Mobile App', 48000, 'Completed'),
(24, 34, 'Fitness and Workout Planner App', 'Develop a fitness app with workout schedules, exercise demonstrations, progress tracking, and reminders.', 'Mobile App', 82000, 'In Progress'),
(25, 35, 'Clinic Appointment Booking App', 'Create an app where patients can find doctors, view available slots, book appointments, and receive reminders.', 'Mobile App', 105000, 'Open'),
(26, 36, 'Campus Event and Noticeboard App', 'Build a student-focused app for college announcements, event registrations, schedules, and notification updates.', 'Mobile App', 62000, 'Completed'),
(27, 37, 'Local Service Provider Booking App', 'Develop an app to discover and book electricians, plumbers, tutors, and other local service professionals.', 'Mobile App', 118000, 'In Progress'),
(28, 38, 'Travel Planner and Trip Journal App', 'Create a travel app for itinerary planning, saved destinations, trip photos, and expense sharing.', 'Mobile App', 76000, 'Open'),
(29, 39, 'Online Learning Mobile Application', 'Build a learning app with recorded lessons, quizzes, course progress, and student discussion features.', 'Mobile App', 155000, 'In Progress'),
(30, 40, 'Medicine Reminder and Refill App', 'Develop a reminder app that lets users schedule medicine alerts and maintain a list of refill requirements.', 'Mobile App', 52000, 'Completed'),
(31, 41, 'Company Portfolio Website', 'Design a professional responsive website presenting company services, projects, team details, and contact information.', 'Website', 28000, 'Completed'),
(32, 42, 'School Management Website', 'Develop a school portal for notices, admissions information, academic calendars, and parent-teacher communication.', 'Website', 125000, 'In Progress'),
(33, 43, 'Real Estate Listing Website', 'Build a property portal with location filters, property photographs, enquiry forms, and agent contact details.', 'Website', 98000, 'Open'),
(34, 44, 'Online Job Portal', 'Create a job listing website where employers publish vacancies and candidates search and submit applications.', 'Website', 145000, 'In Progress'),
(35, 45, 'Restaurant Website with Table Reservations', 'Develop a restaurant website featuring menus, opening hours, table booking, location maps, and customer enquiries.', 'Website', 42000, 'Completed'),
(36, 46, 'NGO Donation and Volunteer Website', 'Build a website to explain NGO initiatives, accept donation enquiries, and register volunteers for campaigns.', 'Website', 67000, 'Open'),
(37, 47, 'News and Editorial Publishing Website', 'Create a content publishing portal with article categories, author profiles, search, and editorial approval workflow.', 'Website', 88000, 'In Progress'),
(38, 48, 'Online Course Landing Website', 'Design a course website with course descriptions, instructor profiles, enquiry forms, and student testimonials.', 'Website', 36000, 'Completed'),
(39, 49, 'Hotel Booking Information Website', 'Develop a hotel website with room details, availability enquiries, photo galleries, and booking request forms.', 'Website', 79000, 'Open'),
(40, 50, 'Event Management Company Website', 'Build a responsive website to showcase event services, portfolios, packages, and customer enquiry forms.', 'Website', 59000, 'In Progress'),
(41, 31, 'Brand Identity and Logo Design', 'Create a distinctive logo, color palette, typography system, and basic brand usage guidelines for a startup.', 'Design', 18000, 'Completed'),
(42, 32, 'Figma UI Design for Banking Dashboard', 'Design a clean banking dashboard in Figma with account summaries, transaction views, and reusable components.', 'Design', 42000, 'In Progress'),
(43, 33, 'Mobile App User Experience Redesign', 'Review an existing app journey and prepare improved wireframes, user flows, and high-fidelity interface screens.', 'Design', 55000, 'Open'),
(44, 34, 'Social Media Creative Design Package', 'Prepare a consistent set of social media post templates, story layouts, and promotional creatives for a business.', 'Design', 15000, 'Completed'),
(45, 35, 'E-commerce Website UI Kit', 'Design a reusable UI kit containing product cards, navigation, filters, checkout screens, and responsive layouts.', 'Design', 48000, 'In Progress'),
(46, 36, 'Product Packaging and Label Design', 'Create print-ready packaging and label artwork for a consumer product while following supplied brand guidelines.', 'Design', 26000, 'Open'),
(47, 37, 'Corporate Presentation and Infographic Design', 'Design a professional presentation with charts, diagrams, and infographics to communicate company performance.', 'Design', 22000, 'Completed'),
(48, 38, 'Restaurant Menu and Visual Identity', 'Create a restaurant menu layout and matching visual assets for print and digital display.', 'Design', 12000, 'Open'),
(49, 39, 'Website Wireframes for Healthcare Portal', 'Prepare user flows and responsive wireframes for a healthcare portal covering appointments, services, and patient information.', 'Design', 35000, 'In Progress'),
(50, 40, 'Dashboard Data Visualization Design', 'Design an analytics dashboard with clear charts, filters, summary cards, and accessible visual hierarchy.', 'Design', 39000, 'Completed')
AS new_projects
ON DUPLICATE KEY UPDATE
  title = new_projects.title,
  description = new_projects.description,
  category = new_projects.category,
  budget = new_projects.budget,
  status = new_projects.status;

-- PART 3: INSERT 200 FREELANCER-SKILL MAPPINGS
INSERT INTO UserSkills (user_id, skill_id, proficiency_level, experience_years) VALUES
(1, 4, 'Intermediate', 2),(1, 5, 'Expert', 4),(1, 6, 'Beginner', 1),(1, 7, 'Intermediate', 3),(1, 8, 'Expert', 5),(1, 9, 'Beginner', 2),(1, 10, 'Intermediate', 4),
(2, 7, 'Expert', 3),(2, 8, 'Beginner', 5),(2, 9, 'Intermediate', 2),(2, 10, 'Expert', 4),(2, 11, 'Beginner', 1),(2, 12, 'Intermediate', 3),(2, 13, 'Expert', 5),
(3, 10, 'Beginner', 4),(3, 11, 'Intermediate', 1),(3, 12, 'Expert', 3),(3, 13, 'Beginner', 5),(3, 14, 'Intermediate', 2),(3, 15, 'Expert', 4),(3, 16, 'Beginner', 1),
(4, 13, 'Intermediate', 5),(4, 14, 'Expert', 2),(4, 15, 'Beginner', 4),(4, 16, 'Intermediate', 1),(4, 17, 'Expert', 3),(4, 18, 'Beginner', 5),(4, 19, 'Intermediate', 2),
(5, 16, 'Expert', 1),(5, 17, 'Beginner', 3),(5, 18, 'Intermediate', 5),(5, 19, 'Expert', 2),(5, 20, 'Beginner', 4),(5, 21, 'Intermediate', 1),(5, 22, 'Expert', 3),
(6, 19, 'Beginner', 2),(6, 20, 'Intermediate', 4),(6, 21, 'Expert', 1),(6, 22, 'Beginner', 3),(6, 23, 'Intermediate', 5),(6, 24, 'Expert', 2),(6, 25, 'Beginner', 4),
(7, 22, 'Intermediate', 3),(7, 23, 'Expert', 5),(7, 24, 'Beginner', 2),(7, 25, 'Intermediate', 4),(7, 26, 'Expert', 1),(7, 27, 'Beginner', 3),(7, 28, 'Intermediate', 5),
(8, 25, 'Expert', 4),(8, 26, 'Beginner', 1),(8, 27, 'Intermediate', 3),(8, 28, 'Expert', 5),(8, 29, 'Beginner', 2),(8, 30, 'Intermediate', 4),(8, 1, 'Expert', 1),
(9, 28, 'Beginner', 5),(9, 29, 'Intermediate', 2),(9, 30, 'Expert', 4),(9, 1, 'Beginner', 1),(9, 2, 'Intermediate', 3),(9, 3, 'Expert', 5),(9, 4, 'Beginner', 2),
(10, 1, 'Intermediate', 1),(10, 2, 'Expert', 3),(10, 3, 'Beginner', 5),(10, 4, 'Intermediate', 2),(10, 5, 'Expert', 4),(10, 6, 'Beginner', 1),(10, 7, 'Intermediate', 3),
(11, 4, 'Expert', 2),(11, 5, 'Beginner', 4),(11, 6, 'Intermediate', 1),(11, 7, 'Expert', 3),(11, 8, 'Beginner', 5),(11, 9, 'Intermediate', 2),(11, 10, 'Expert', 4),
(12, 7, 'Beginner', 3),(12, 8, 'Intermediate', 5),(12, 9, 'Expert', 2),(12, 10, 'Beginner', 4),(12, 11, 'Intermediate', 1),(12, 12, 'Expert', 3),(12, 13, 'Beginner', 5),
(13, 10, 'Intermediate', 4),(13, 11, 'Expert', 1),(13, 12, 'Beginner', 3),(13, 13, 'Intermediate', 5),(13, 14, 'Expert', 2),(13, 15, 'Beginner', 4),(13, 16, 'Intermediate', 1),
(14, 13, 'Expert', 5),(14, 14, 'Beginner', 2),(14, 15, 'Intermediate', 4),(14, 16, 'Expert', 1),(14, 17, 'Beginner', 3),(14, 18, 'Intermediate', 5),(14, 19, 'Expert', 2),
(15, 16, 'Beginner', 1),(15, 17, 'Intermediate', 3),(15, 18, 'Expert', 5),(15, 19, 'Beginner', 2),(15, 20, 'Intermediate', 4),(15, 21, 'Expert', 1),(15, 22, 'Beginner', 3),
(16, 19, 'Intermediate', 2),(16, 20, 'Expert', 4),(16, 21, 'Beginner', 1),(16, 22, 'Intermediate', 3),(16, 23, 'Expert', 5),(16, 24, 'Beginner', 2),(16, 25, 'Intermediate', 4),
(17, 22, 'Expert', 3),(17, 23, 'Beginner', 5),(17, 24, 'Intermediate', 2),(17, 25, 'Expert', 4),(17, 26, 'Beginner', 1),(17, 27, 'Intermediate', 3),(17, 28, 'Expert', 5),
(18, 25, 'Beginner', 4),(18, 26, 'Intermediate', 1),(18, 27, 'Expert', 3),(18, 28, 'Beginner', 5),(18, 29, 'Intermediate', 2),(18, 30, 'Expert', 4),(18, 1, 'Beginner', 1),
(19, 28, 'Intermediate', 5),(19, 29, 'Expert', 2),(19, 30, 'Beginner', 4),(19, 1, 'Intermediate', 1),(19, 2, 'Expert', 3),(19, 3, 'Beginner', 5),(19, 4, 'Intermediate', 2),
(20, 1, 'Expert', 1),(20, 2, 'Beginner', 3),(20, 3, 'Intermediate', 5),(20, 4, 'Expert', 2),(20, 5, 'Beginner', 4),(20, 6, 'Intermediate', 1),(20, 7, 'Expert', 3),
(21, 4, 'Beginner', 2),(21, 5, 'Intermediate', 4),(21, 6, 'Expert', 1),(21, 7, 'Beginner', 3),(21, 8, 'Intermediate', 5),(21, 9, 'Expert', 2),
(22, 7, 'Intermediate', 3),(22, 8, 'Expert', 5),(22, 9, 'Beginner', 2),(22, 10, 'Intermediate', 4),(22, 11, 'Expert', 1),(22, 12, 'Beginner', 3),
(23, 10, 'Expert', 4),(23, 11, 'Beginner', 1),(23, 12, 'Intermediate', 3),(23, 13, 'Expert', 5),(23, 14, 'Beginner', 2),(23, 15, 'Intermediate', 4),
(24, 13, 'Beginner', 5),(24, 14, 'Intermediate', 2),(24, 15, 'Expert', 4),(24, 16, 'Beginner', 1),(24, 17, 'Intermediate', 3),(24, 18, 'Expert', 5),
(25, 16, 'Intermediate', 1),(25, 17, 'Expert', 3),(25, 18, 'Beginner', 5),(25, 19, 'Intermediate', 2),(25, 20, 'Expert', 4),(25, 21, 'Beginner', 1),
(26, 19, 'Expert', 2),(26, 20, 'Beginner', 4),(26, 21, 'Intermediate', 1),(26, 22, 'Expert', 3),(26, 23, 'Beginner', 5),(26, 24, 'Intermediate', 2),
(27, 22, 'Beginner', 3),(27, 23, 'Intermediate', 5),(27, 24, 'Expert', 2),(27, 25, 'Beginner', 4),(27, 26, 'Intermediate', 1),(27, 27, 'Expert', 3),
(28, 25, 'Intermediate', 4),(28, 26, 'Expert', 1),(28, 27, 'Beginner', 3),(28, 28, 'Intermediate', 5),(28, 29, 'Expert', 2),(28, 30, 'Beginner', 4),
(29, 28, 'Expert', 5),(29, 29, 'Beginner', 2),(29, 30, 'Intermediate', 4),(29, 1, 'Expert', 1),(29, 2, 'Beginner', 3),(29, 3, 'Intermediate', 5),
(30, 1, 'Beginner', 1),(30, 2, 'Intermediate', 3),(30, 3, 'Expert', 5),(30, 4, 'Beginner', 2),(30, 5, 'Intermediate', 4),(30, 6, 'Expert', 1)
AS new_us
ON DUPLICATE KEY UPDATE
  proficiency_level = new_us.proficiency_level,
  experience_years = new_us.experience_years;

-- VERIFY COUNTS
SELECT 'Projects' AS table_name, COUNT(*) AS total FROM Projects
UNION ALL SELECT 'Skills', COUNT(*) FROM Skills
UNION ALL SELECT 'UserSkills', COUNT(*) FROM UserSkills;
