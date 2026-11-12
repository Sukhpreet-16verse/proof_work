-- ======================================================
-- 05_views_and_reports.sql
-- Freelance Project Management System - Final Fixed
-- ======================================================

DROP VIEW IF EXISTS FreelancerDashboard;
DROP VIEW IF EXISTS VerifiedReport;
DROP VIEW IF EXISTS ClientProjectSummary;

-- View 1: Freelancer Dashboard (Payment + Projects)
CREATE VIEW FreelancerDashboard AS
SELECT 
    U.user_id,
    U.full_name,
    U.email,
    P.project_id,
    P.title,
    P.category,
    T.amount,
    T.status AS payment_status,
    T.created_at AS payment_date
FROM Users U
JOIN Applications A ON U.user_id = A.user_id
JOIN Transactions T ON T.project_id = A.project_id AND T.user_id = A.user_id
JOIN Projects P ON T.project_id = P.project_id
WHERE U.role = 'Freelancer';

-- View 2: Verified Experience Report (Client = Organizations owner)
CREATE VIEW VerifiedReport AS
SELECT 
    U.full_name AS freelancer_name,
    O.org_name,
    O.industry,
    P.title AS project_title,
    P.category,
    V.certificate_url,
    V.issued_at
FROM VerifiedExperience V
JOIN Users U ON V.user_id = U.user_id
JOIN Projects P ON V.project_id = P.project_id
JOIN Organizations O ON O.owner_id = P.client_id;

-- View 3: Extra - Client Project Summary (for presentation)
CREATE VIEW ClientProjectSummary AS
SELECT
    C.user_id AS client_id,
    C.full_name AS client_name,
    O.org_name,
    COUNT(P.project_id) AS total_projects,
    SUM(P.budget) AS total_budget
FROM Users C
LEFT JOIN Organizations O ON O.owner_id = C.user_id
LEFT JOIN Projects P ON P.client_id = C.user_id
WHERE C.role = 'Client'
GROUP BY C.user_id, C.full_name, O.org_name;

-- Verify Views
SELECT * FROM FreelancerDashboard LIMIT 5;
SELECT * FROM VerifiedReport LIMIT 5;
SELECT * FROM ClientProjectSummary;
