-- ============================================================
-- 07_queries_user_dashboard_40.sql
-- ProofWork - Member 5: Freelancer Dashboard (40 Queries)
-- MySQL 8.0+  |  Database: proofwork_db
-- Depends on: 01..06 scripts (Users, Skills, UserSkills, Projects,
--             Applications, Submissions, Payments, Certificates,
--             Verifications, Reviews)
-- ============================================================
-- Change @uid to view the dashboard of any freelancer (user_id 1-30).
-- NOTE: Certificates and Reviews exist only for freelancers 11-30,
--       so 11 is used as default so that every query returns data.
-- ============================================================

USE proofwork_db;

SET @uid = 11;


-- ============================================================
-- PART A: MY PROFILE & TRUST SCORE (Q1-Q5)
-- ============================================================

-- Q1: Show freelancer's personal profile.
SELECT
    user_id,
    full_name,
    email,
    phone,
    city,
    role,
    linkedin_url
FROM Users
WHERE user_id = @uid;

-- Q2: Show freelancer's current trust score.
SELECT
    user_id,
    full_name,
    trust_score
FROM Users
WHERE user_id = @uid;

-- Q3: Show all skills registered by the freelancer.
SELECT
    U.user_id,
    U.full_name,
    S.skill_id,
    S.skill_name,
    S.category
FROM Users U
JOIN UserSkills US ON U.user_id = US.user_id
JOIN Skills S      ON US.skill_id = S.skill_id
WHERE U.user_id = @uid;

-- Q4: Count the total skills of the freelancer.
SELECT
    U.user_id,
    U.full_name,
    COUNT(US.skill_id) AS total_skills
FROM Users U
LEFT JOIN UserSkills US ON U.user_id = US.user_id
WHERE U.user_id = @uid
GROUP BY U.user_id, U.full_name;

-- Q5: Show freelancer's skills and experience level.
SELECT
    S.skill_name,
    S.category,
    US.proficiency_level,
    US.experience_years
FROM UserSkills US
JOIN Skills S ON US.skill_id = S.skill_id
WHERE US.user_id = @uid
ORDER BY US.experience_years DESC;


-- ============================================================
-- PART B: MY APPLICATIONS & STATUS TRACKING (Q6-Q12)
-- ============================================================

-- Q6: Show all projects applied for by the freelancer.
SELECT
    A.application_id,
    P.project_id,
    P.title,
    A.bid_amount,
    A.estimated_days,
    A.status
FROM Applications A
JOIN Projects P ON A.project_id = P.project_id
WHERE A.user_id = @uid;

-- Q7: Show all accepted applications.
SELECT
    A.application_id,
    P.title,
    A.bid_amount,
    A.status
FROM Applications A
JOIN Projects P ON A.project_id = P.project_id
WHERE A.user_id = @uid
  AND A.status = 'Accepted';

-- Q8: Show all pending applications.
SELECT
    A.application_id,
    P.title,
    A.bid_amount,
    A.estimated_days,
    A.status
FROM Applications A
JOIN Projects P ON A.project_id = P.project_id
WHERE A.user_id = @uid
  AND A.status = 'Pending';

-- Q9: Show all rejected applications.
SELECT
    A.application_id,
    P.title,
    A.bid_amount,
    A.status
FROM Applications A
JOIN Projects P ON A.project_id = P.project_id
WHERE A.user_id = @uid
  AND A.status = 'Rejected';

-- Q10: Compare freelancer's bid amount with project budget.
SELECT
    A.application_id,
    P.title,
    A.bid_amount,
    P.budget,
    (P.budget - A.bid_amount) AS budget_difference
FROM Applications A
JOIN Projects P ON A.project_id = P.project_id
WHERE A.user_id = @uid;

-- Q11: Count applications according to their status.
SELECT
    status,
    COUNT(application_id) AS total_applications
FROM Applications
WHERE user_id = @uid
GROUP BY status;

-- Q12: Show application and submission history.
SELECT
    A.application_id,
    P.title,
    A.status AS application_status,
    S.submission_id,
    S.version,
    S.file_url,
    S.status AS submission_status,
    S.submitted_at
FROM Applications A
JOIN Projects P ON A.project_id = P.project_id
LEFT JOIN Submissions S ON A.application_id = S.application_id
WHERE A.user_id = @uid
ORDER BY A.application_id, S.submitted_at;


-- ============================================================
-- PART C: MY EARNINGS & TRANSACTIONS (Q13-Q20)
-- ============================================================

-- Q13: Show all payment records of the freelancer.
SELECT
    A.application_id,
    P.title,
    PAY.payment_id,
    PAY.amount,
    PAY.payment_method,
    PAY.payment_status,
    PAY.paid_at
FROM Applications A
JOIN Payments PAY ON A.application_id = PAY.application_id
JOIN Projects P   ON PAY.project_id = P.project_id
WHERE A.user_id = @uid;

-- Q14: Calculate total successful earnings.
SELECT
    A.user_id,
    SUM(PAY.amount) AS total_earnings
FROM Applications A
JOIN Payments PAY ON A.application_id = PAY.application_id
WHERE A.user_id = @uid
  AND PAY.payment_status = 'Paid'
GROUP BY A.user_id;

-- Q15: Calculate total pending payment amount.
SELECT
    A.user_id,
    SUM(PAY.amount) AS pending_amount
FROM Applications A
JOIN Payments PAY ON A.application_id = PAY.application_id
WHERE A.user_id = @uid
  AND PAY.payment_status = 'Pending'
GROUP BY A.user_id;

-- Q16: Calculate total amount of failed payments.
SELECT
    A.user_id,
    SUM(PAY.amount) AS failed_payment_amount
FROM Applications A
JOIN Payments PAY ON A.application_id = PAY.application_id
WHERE A.user_id = @uid
  AND PAY.payment_status = 'Failed'
GROUP BY A.user_id;

-- Q17: Find the highest successful payment received.
SELECT
    A.user_id,
    MAX(PAY.amount) AS highest_payment
FROM Applications A
JOIN Payments PAY ON A.application_id = PAY.application_id
WHERE A.user_id = @uid
  AND PAY.payment_status = 'Paid'
GROUP BY A.user_id;

-- Q18: Calculate average successful payment amount.
SELECT
    A.user_id,
    ROUND(AVG(PAY.amount), 2) AS average_payment
FROM Applications A
JOIN Payments PAY ON A.application_id = PAY.application_id
WHERE A.user_id = @uid
  AND PAY.payment_status = 'Paid'
GROUP BY A.user_id;

-- Q19: Show project-wise successful earnings.
SELECT
    P.project_id,
    P.title,
    SUM(PAY.amount) AS project_earnings
FROM Applications A
JOIN Payments PAY ON A.application_id = PAY.application_id
JOIN Projects P   ON PAY.project_id = P.project_id
WHERE A.user_id = @uid
  AND PAY.payment_status = 'Paid'
GROUP BY P.project_id, P.title;

-- Q20: Count successful, pending and failed transactions.
SELECT
    A.user_id,
    COUNT(PAY.payment_id) AS total_transactions,
    SUM(CASE WHEN PAY.payment_status = 'Paid'    THEN 1 ELSE 0 END) AS successful_transactions,
    SUM(CASE WHEN PAY.payment_status = 'Pending' THEN 1 ELSE 0 END) AS pending_transactions,
    SUM(CASE WHEN PAY.payment_status = 'Failed'  THEN 1 ELSE 0 END) AS failed_transactions
FROM Applications A
LEFT JOIN Payments PAY ON A.application_id = PAY.application_id
WHERE A.user_id = @uid
GROUP BY A.user_id;


-- ============================================================
-- PART D: MY VERIFIED CERTIFICATES (Q21-Q28)
-- (Certificates table uses user_id, not freelancer_id)
-- ============================================================

-- Q21: Show all verified certificates of the freelancer.
SELECT
    certificate_id,
    project_id,
    certificate_code,
    issued_at,
    certificate_url
FROM Certificates
WHERE user_id = @uid;

-- Q22: Display certificate codes for verification.
SELECT
    certificate_id,
    certificate_code,
    project_id
FROM Certificates
WHERE user_id = @uid;

-- Q23: Show certificate issue dates (latest first).
SELECT
    certificate_id,
    certificate_code,
    issued_at
FROM Certificates
WHERE user_id = @uid
ORDER BY issued_at DESC;

-- Q24: Display certificates along with project names.
SELECT
    C.certificate_id,
    C.certificate_code,
    P.title,
    C.issued_at
FROM Certificates C
JOIN Projects P ON C.project_id = P.project_id
WHERE C.user_id = @uid;

-- Q25: Count total verified certificates.
SELECT
    user_id,
    COUNT(certificate_id) AS total_certificates
FROM Certificates
WHERE user_id = @uid
GROUP BY user_id;

-- Q26: Show the latest certificate issued.
SELECT
    certificate_id,
    certificate_code,
    project_id,
    issued_at
FROM Certificates
WHERE user_id = @uid
ORDER BY issued_at DESC
LIMIT 1;

-- Q27: Show project-wise certificate details.
SELECT
    P.project_id,
    P.title,
    COUNT(C.certificate_id) AS certificates_issued,
    MAX(C.issued_at)        AS latest_issue_date
FROM Projects P
JOIN Certificates C ON P.project_id = C.project_id
WHERE C.user_id = @uid
GROUP BY P.project_id, P.title;

-- Q28: Show certificate verification status and details.
SELECT
    C.certificate_id,
    C.certificate_code,
    P.title,
    V.verification_status,
    V.verification_notes,
    V.verified_at
FROM Certificates C
JOIN Projects P      ON C.project_id = P.project_id
JOIN Verifications V ON C.verification_id = V.verification_id
WHERE C.user_id = @uid;


-- ============================================================
-- PART E: MY REVIEWS & RATINGS (Q29-Q35)
-- (rating is DECIMAL(2,1), e.g. 4.8, so star buckets use ranges)
-- ============================================================

-- Q29: Show all reviews received by the freelancer.
SELECT
    R.review_id,
    P.title,
    R.reviewer_id,
    U.full_name AS reviewer_name,
    R.rating,
    R.review_text,
    R.created_at
FROM Reviews R
JOIN Projects P ON R.project_id = P.project_id
JOIN Users U    ON R.reviewer_id = U.user_id
WHERE R.reviewee_id = @uid;

-- Q30: Calculate average rating received.
SELECT
    reviewee_id,
    ROUND(AVG(rating), 2) AS average_rating,
    COUNT(review_id)      AS total_reviews
FROM Reviews
WHERE reviewee_id = @uid
GROUP BY reviewee_id;

-- Q31: Show all 5-star reviews received.
SELECT
    review_id,
    project_id,
    reviewer_id,
    rating,
    review_text,
    created_at
FROM Reviews
WHERE reviewee_id = @uid
  AND rating = 5.0;

-- Q32: Show all 4-star reviews received (4.0 to 4.9).
SELECT
    review_id,
    project_id,
    reviewer_id,
    rating,
    review_text,
    created_at
FROM Reviews
WHERE reviewee_id = @uid
  AND rating >= 4.0
  AND rating <  5.0;

-- Q33: Count total reviews received.
SELECT
    reviewee_id,
    COUNT(review_id) AS total_reviews
FROM Reviews
WHERE reviewee_id = @uid
GROUP BY reviewee_id;

-- Q34: Display project-wise reviews and ratings.
SELECT
    P.project_id,
    P.title,
    R.rating,
    R.review_text,
    R.created_at
FROM Reviews R
JOIN Projects P ON R.project_id = P.project_id
WHERE R.reviewee_id = @uid
ORDER BY R.created_at DESC;

-- Q35: Find the highest-rated projects of the freelancer.
SELECT
    P.project_id,
    P.title,
    ROUND(AVG(R.rating), 2) AS average_rating,
    COUNT(R.review_id)      AS total_reviews
FROM Reviews R
JOIN Projects P ON R.project_id = P.project_id
WHERE R.reviewee_id = @uid
GROUP BY P.project_id, P.title
ORDER BY average_rating DESC;


-- ============================================================
-- PART F: PERSONALIZED PROJECT RECOMMENDATIONS (Q36-Q40)
-- (Projects have no skill mapping table, so skills are matched
--  against project title/description text with LIKE)
-- ============================================================

-- Q36: Recommend projects matching freelancer's registered skills.
SELECT DISTINCT
    P.project_id,
    P.title,
    P.category,
    P.budget,
    P.status,
    S.skill_name AS matching_skill
FROM UserSkills US
JOIN Skills S   ON US.skill_id = S.skill_id
JOIN Projects P ON P.title       LIKE CONCAT('%', S.skill_name, '%')
                OR P.description LIKE CONCAT('%', S.skill_name, '%')
WHERE US.user_id = @uid
ORDER BY P.budget DESC;

-- Q37: Find open projects matching freelancer's skills.
SELECT DISTINCT
    P.project_id,
    P.title,
    P.category,
    P.budget,
    S.skill_name AS matching_skill
FROM UserSkills US
JOIN Skills S   ON US.skill_id = S.skill_id
JOIN Projects P ON P.title       LIKE CONCAT('%', S.skill_name, '%')
                OR P.description LIKE CONCAT('%', S.skill_name, '%')
WHERE US.user_id = @uid
  AND LOWER(P.status) = 'open'
ORDER BY P.budget DESC;

-- Q38: Recommend projects matching expert-level skills.
SELECT DISTINCT
    P.project_id,
    P.title,
    P.category,
    P.budget,
    S.skill_name,
    US.proficiency_level
FROM UserSkills US
JOIN Skills S   ON US.skill_id = S.skill_id
JOIN Projects P ON P.title       LIKE CONCAT('%', S.skill_name, '%')
                OR P.description LIKE CONCAT('%', S.skill_name, '%')
WHERE US.user_id = @uid
  AND US.proficiency_level = 'Expert'
ORDER BY P.budget DESC;

-- Q39: Count matching projects for each freelancer skill.
SELECT
    S.skill_name,
    COUNT(DISTINCT P.project_id) AS matching_projects
FROM UserSkills US
JOIN Skills S ON US.skill_id = S.skill_id
LEFT JOIN Projects P ON P.title       LIKE CONCAT('%', S.skill_name, '%')
                     OR P.description LIKE CONCAT('%', S.skill_name, '%')
WHERE US.user_id = @uid
GROUP BY S.skill_id, S.skill_name
ORDER BY matching_projects DESC;

-- Q40: Show top recommended open projects by number of matching skills
--      (excludes projects the freelancer has already applied to).
SELECT
    P.project_id,
    P.title,
    P.category,
    P.budget,
    COUNT(DISTINCT S.skill_id)             AS matched_skills,
    GROUP_CONCAT(DISTINCT S.skill_name)    AS matching_skill_names
FROM UserSkills US
JOIN Skills S   ON US.skill_id = S.skill_id
JOIN Projects P ON P.title       LIKE CONCAT('%', S.skill_name, '%')
                OR P.description LIKE CONCAT('%', S.skill_name, '%')
WHERE US.user_id = @uid
  AND LOWER(P.status) = 'open'
  AND NOT EXISTS (
        SELECT 1
        FROM Applications A
        WHERE A.project_id = P.project_id
          AND A.user_id = @uid
  )
GROUP BY P.project_id, P.title, P.category, P.budget
ORDER BY matched_skills DESC, P.budget DESC
LIMIT 10;

-- ============================================================
-- END OF MEMBER 5 - TOTAL 40 QUERIES
-- ============================================================
