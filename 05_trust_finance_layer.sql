-- ============================================
-- ProofWork - Member 4: Trust & Finance Layer
-- Module: Verifications, Reviews, Payments, Certificates
-- Author: Member 4 (Kalpana)
-- Total Rows: 350 (100+100+100+50)
-- Date: 2026-08-10
-- Description: Production-ready with FK constraints, business logic validation
-- Dependencies: Users, Projects, Submissions, Milestones, Applications
-- ============================================
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS Certificates, Payments, Reviews, Verifications;
SET FOREIGN_KEY_CHECKS=1;

-- 1. Verifications Table (Trust Layer)
CREATE TABLE Verifications (
  verification_id INT PRIMARY KEY,
  submission_id INT NOT NULL,
  verifier_id INT NOT NULL,
  verification_status ENUM('Verified','Rejected','Under Review') NOT NULL,
  verification_notes TEXT,
  verified_at DATETIME NOT NULL,
  FOREIGN KEY (submission_id) REFERENCES Submissions(submission_id),
  FOREIGN KEY (verifier_id) REFERENCES Users(user_id)
);

-- 2. Reviews Table (Trust Layer)
CREATE TABLE Reviews (
  review_id INT PRIMARY KEY,
  project_id INT NOT NULL,
  reviewer_id INT NOT NULL,
  reviewee_id INT NOT NULL,
  rating DECIMAL(2,1) CHECK (rating >= 1.0 AND rating <= 5.0),
  review_text TEXT,
  created_at DATETIME NOT NULL,
  FOREIGN KEY (project_id) REFERENCES Projects(project_id),
  FOREIGN KEY (reviewer_id) REFERENCES Users(user_id),
  FOREIGN KEY (reviewee_id) REFERENCES Users(user_id)
);

-- 3. Payments Table (Finance Layer)
CREATE TABLE Payments (
  payment_id INT PRIMARY KEY,
  project_id INT NOT NULL,
  milestone_id INT NOT NULL,
  application_id INT NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  payment_method ENUM('UPI','Razorpay','Bank Transfer','PayPal') NOT NULL,
  payment_status ENUM('Paid','Pending','Failed') NOT NULL,
  paid_at DATETIME,
  FOREIGN KEY (project_id) REFERENCES Projects(project_id),
  FOREIGN KEY (milestone_id) REFERENCES Milestones(milestone_id),
  FOREIGN KEY (application_id) REFERENCES Applications(application_id)
);

-- 4. Certificates Table (Trust Layer)
CREATE TABLE Certificates (
  certificate_id INT PRIMARY KEY,
  verification_id INT NOT NULL,
  project_id INT NOT NULL,
  user_id INT NOT NULL, -- CHANGED: was freelancer_id, now user_id to match Users table and Member 3 fix
  certificate_code VARCHAR(50) UNIQUE NOT NULL,
  issued_at DATETIME NOT NULL,
  certificate_url VARCHAR(255),
  FOREIGN KEY (verification_id) REFERENCES Verifications(verification_id),
  FOREIGN KEY (project_id) REFERENCES Projects(project_id),
  FOREIGN KEY (user_id) REFERENCES Users(user_id) -- CHANGED: FK now uses user_id
);

-- ============================================
-- DATA INSERTION - 350 ROWS
-- ============================================

INSERT INTO Verifications VALUES (1,1,2,'Verified','QA passed, approved for payout','2026-08-21 10:00:00');
INSERT INTO Verifications VALUES (2,2,3,'Verified','QA passed, approved for payout','2026-08-22 10:00:00');
INSERT INTO Verifications VALUES (3,3,4,'Verified','QA passed, approved for payout','2026-08-23 10:00:00');
INSERT INTO Verifications VALUES (4,4,5,'Verified','QA passed, approved for payout','2026-08-24 10:00:00');
INSERT INTO Verifications VALUES (5,5,6,'Verified','QA passed, approved for payout','2026-08-25 10:00:00');
INSERT INTO Verifications VALUES (6,6,7,'Verified','QA passed, approved for payout','2026-08-26 10:00:00');
INSERT INTO Verifications VALUES (7,7,8,'Verified','QA passed, approved for payout','2026-08-27 10:00:00');
INSERT INTO Verifications VALUES (8,8,9,'Verified','QA passed, approved for payout','2026-08-28 10:00:00');
INSERT INTO Verifications VALUES (9,9,10,'Verified','QA passed, approved for payout','2026-08-29 10:00:00');
INSERT INTO Verifications VALUES (10,10,11,'Verified','QA passed, approved for payout','2026-08-20 10:00:00');
INSERT INTO Verifications VALUES (11,11,12,'Verified','QA passed, approved for payout','2026-08-21 10:00:00');
INSERT INTO Verifications VALUES (12,12,13,'Verified','QA passed, approved for payout','2026-08-22 10:00:00');
INSERT INTO Verifications VALUES (13,13,14,'Verified','QA passed, approved for payout','2026-08-23 10:00:00');
INSERT INTO Verifications VALUES (14,14,15,'Verified','QA passed, approved for payout','2026-08-24 10:00:00');
INSERT INTO Verifications VALUES (15,15,16,'Verified','QA passed, approved for payout','2026-08-25 10:00:00');
INSERT INTO Verifications VALUES (16,16,17,'Verified','QA passed, approved for payout','2026-08-26 10:00:00');
INSERT INTO Verifications VALUES (17,17,18,'Verified','QA passed, approved for payout','2026-08-27 10:00:00');
INSERT INTO Verifications VALUES (18,18,19,'Verified','QA passed, approved for payout','2026-08-28 10:00:00');
INSERT INTO Verifications VALUES (19,19,20,'Verified','QA passed, approved for payout','2026-08-29 10:00:00');
INSERT INTO Verifications VALUES (20,20,1,'Verified','QA passed, approved for payout','2026-08-20 10:00:00');
INSERT INTO Verifications VALUES (21,21,2,'Verified','QA passed, approved for payout','2026-08-21 10:00:00');
INSERT INTO Verifications VALUES (22,22,3,'Verified','QA passed, approved for payout','2026-08-22 10:00:00');
INSERT INTO Verifications VALUES (23,23,4,'Verified','QA passed, approved for payout','2026-08-23 10:00:00');
INSERT INTO Verifications VALUES (24,24,5,'Verified','QA passed, approved for payout','2026-08-24 10:00:00');
INSERT INTO Verifications VALUES (25,25,6,'Verified','QA passed, approved for payout','2026-08-25 10:00:00');
INSERT INTO Verifications VALUES (26,26,7,'Verified','QA passed, approved for payout','2026-08-26 10:00:00');
INSERT INTO Verifications VALUES (27,27,8,'Verified','QA passed, approved for payout','2026-08-27 10:00:00');
INSERT INTO Verifications VALUES (28,28,9,'Verified','QA passed, approved for payout','2026-08-28 10:00:00');
INSERT INTO Verifications VALUES (29,29,10,'Verified','QA passed, approved for payout','2026-08-29 10:00:00');
INSERT INTO Verifications VALUES (30,30,11,'Verified','QA passed, approved for payout','2026-08-20 10:00:00');
INSERT INTO Verifications VALUES (31,31,12,'Verified','QA passed, approved for payout','2026-08-21 10:00:00');
INSERT INTO Verifications VALUES (32,32,13,'Verified','QA passed, approved for payout','2026-08-22 10:00:00');
INSERT INTO Verifications VALUES (33,33,14,'Verified','QA passed, approved for payout','2026-08-23 10:00:00');
INSERT INTO Verifications VALUES (34,34,15,'Verified','QA passed, approved for payout','2026-08-24 10:00:00');
INSERT INTO Verifications VALUES (35,35,16,'Verified','QA passed, approved for payout','2026-08-25 10:00:00');
INSERT INTO Verifications VALUES (36,36,17,'Verified','QA passed, approved for payout','2026-08-26 10:00:00');
INSERT INTO Verifications VALUES (37,37,18,'Verified','QA passed, approved for payout','2026-08-27 10:00:00');
INSERT INTO Verifications VALUES (38,38,19,'Verified','QA passed, approved for payout','2026-08-28 10:00:00');
INSERT INTO Verifications VALUES (39,39,20,'Verified','QA passed, approved for payout','2026-08-29 10:00:00');
INSERT INTO Verifications VALUES (40,40,1,'Verified','QA passed, approved for payout','2026-08-20 10:00:00');
INSERT INTO Verifications VALUES (41,41,2,'Verified','QA passed, approved for payout','2026-08-21 10:00:00');
INSERT INTO Verifications VALUES (42,42,3,'Verified','QA passed, approved for payout','2026-08-22 10:00:00');
INSERT INTO Verifications VALUES (43,43,4,'Verified','QA passed, approved for payout','2026-08-23 10:00:00');
INSERT INTO Verifications VALUES (44,44,5,'Verified','QA passed, approved for payout','2026-08-24 10:00:00');
INSERT INTO Verifications VALUES (45,45,6,'Verified','QA passed, approved for payout','2026-08-25 10:00:00');
INSERT INTO Verifications VALUES (46,46,7,'Verified','QA passed, approved for payout','2026-08-26 10:00:00');
INSERT INTO Verifications VALUES (47,47,8,'Verified','QA passed, approved for payout','2026-08-27 10:00:00');
INSERT INTO Verifications VALUES (48,48,9,'Verified','QA passed, approved for payout','2026-08-28 10:00:00');
INSERT INTO Verifications VALUES (49,49,10,'Verified','QA passed, approved for payout','2026-08-29 10:00:00');
INSERT INTO Verifications VALUES (50,50,11,'Verified','QA passed, approved for payout','2026-08-20 10:00:00');
INSERT INTO Verifications VALUES (51,51,12,'Verified','QA passed, approved for payout','2026-08-21 10:00:00');
INSERT INTO Verifications VALUES (52,52,13,'Verified','QA passed, approved for payout','2026-08-22 10:00:00');
INSERT INTO Verifications VALUES (53,53,14,'Verified','QA passed, approved for payout','2026-08-23 10:00:00');
INSERT INTO Verifications VALUES (54,54,15,'Verified','QA passed, approved for payout','2026-08-24 10:00:00');
INSERT INTO Verifications VALUES (55,55,16,'Verified','QA passed, approved for payout','2026-08-25 10:00:00');
INSERT INTO Verifications VALUES (56,56,17,'Verified','QA passed, approved for payout','2026-08-26 10:00:00');
INSERT INTO Verifications VALUES (57,57,18,'Verified','QA passed, approved for payout','2026-08-27 10:00:00');
INSERT INTO Verifications VALUES (58,58,19,'Verified','QA passed, approved for payout','2026-08-28 10:00:00');
INSERT INTO Verifications VALUES (59,59,20,'Verified','QA passed, approved for payout','2026-08-29 10:00:00');
INSERT INTO Verifications VALUES (60,60,1,'Verified','QA passed, approved for payout','2026-08-20 10:00:00');
INSERT INTO Verifications VALUES (61,61,2,'Verified','QA passed, approved for payout','2026-08-21 10:00:00');
INSERT INTO Verifications VALUES (62,62,3,'Verified','QA passed, approved for payout','2026-08-22 10:00:00');
INSERT INTO Verifications VALUES (63,63,4,'Verified','QA passed, approved for payout','2026-08-23 10:00:00');
INSERT INTO Verifications VALUES (64,64,5,'Verified','QA passed, approved for payout','2026-08-24 10:00:00');
INSERT INTO Verifications VALUES (65,65,6,'Verified','QA passed, approved for payout','2026-08-25 10:00:00');
INSERT INTO Verifications VALUES (66,66,7,'Verified','QA passed, approved for payout','2026-08-26 10:00:00');
INSERT INTO Verifications VALUES (67,67,8,'Verified','QA passed, approved for payout','2026-08-27 10:00:00');
INSERT INTO Verifications VALUES (68,68,9,'Verified','QA passed, approved for payout','2026-08-28 10:00:00');
INSERT INTO Verifications VALUES (69,69,10,'Verified','QA passed, approved for payout','2026-08-29 10:00:00');
INSERT INTO Verifications VALUES (70,70,11,'Verified','QA passed, approved for payout','2026-08-20 10:00:00');
INSERT INTO Verifications VALUES (71,71,12,'Rejected','QA failed, needs rework','2026-08-21 10:00:00');
INSERT INTO Verifications VALUES (72,72,13,'Rejected','QA failed, needs rework','2026-08-22 10:00:00');
INSERT INTO Verifications VALUES (73,73,14,'Rejected','QA failed, needs rework','2026-08-23 10:00:00');
INSERT INTO Verifications VALUES (74,74,15,'Rejected','QA failed, needs rework','2026-08-24 10:00:00');
INSERT INTO Verifications VALUES (75,75,16,'Rejected','QA failed, needs rework','2026-08-25 10:00:00');
INSERT INTO Verifications VALUES (76,76,17,'Rejected','QA failed, needs rework','2026-08-26 10:00:00');
INSERT INTO Verifications VALUES (77,77,18,'Rejected','QA failed, needs rework','2026-08-27 10:00:00');
INSERT INTO Verifications VALUES (78,78,19,'Rejected','QA failed, needs rework','2026-08-28 10:00:00');
INSERT INTO Verifications VALUES (79,79,20,'Rejected','QA failed, needs rework','2026-08-29 10:00:00');
INSERT INTO Verifications VALUES (80,80,1,'Rejected','QA failed, needs rework','2026-08-20 10:00:00');
INSERT INTO Verifications VALUES (81,81,2,'Rejected','QA failed, needs rework','2026-08-21 10:00:00');
INSERT INTO Verifications VALUES (82,82,3,'Rejected','QA failed, needs rework','2026-08-22 10:00:00');
INSERT INTO Verifications VALUES (83,83,4,'Rejected','QA failed, needs rework','2026-08-23 10:00:00');
INSERT INTO Verifications VALUES (84,84,5,'Rejected','QA failed, needs rework','2026-08-24 10:00:00');
INSERT INTO Verifications VALUES (85,85,6,'Rejected','QA failed, needs rework','2026-08-25 10:00:00');
INSERT INTO Verifications VALUES (86,86,7,'Rejected','QA failed, needs rework','2026-08-26 10:00:00');
INSERT INTO Verifications VALUES (87,87,8,'Rejected','QA failed, needs rework','2026-08-27 10:00:00');
INSERT INTO Verifications VALUES (88,88,9,'Rejected','QA failed, needs rework','2026-08-28 10:00:00');
INSERT INTO Verifications VALUES (89,89,10,'Rejected','QA failed, needs rework','2026-08-29 10:00:00');
INSERT INTO Verifications VALUES (90,90,11,'Rejected','QA failed, needs rework','2026-08-20 10:00:00');
INSERT INTO Verifications VALUES (91,91,12,'Under Review','Under client review','2026-08-21 10:00:00');
INSERT INTO Verifications VALUES (92,92,13,'Under Review','Under client review','2026-08-22 10:00:00');
INSERT INTO Verifications VALUES (93,93,14,'Under Review','Under client review','2026-08-23 10:00:00');
INSERT INTO Verifications VALUES (94,94,15,'Under Review','Under client review','2026-08-24 10:00:00');
INSERT INTO Verifications VALUES (95,95,16,'Under Review','Under client review','2026-08-25 10:00:00');
INSERT INTO Verifications VALUES (96,96,17,'Under Review','Under client review','2026-08-26 10:00:00');
INSERT INTO Verifications VALUES (97,97,18,'Under Review','Under client review','2026-08-27 10:00:00');
INSERT INTO Verifications VALUES (98,98,19,'Under Review','Under client review','2026-08-28 10:00:00');
INSERT INTO Verifications VALUES (99,99,20,'Under Review','Under client review','2026-08-29 10:00:00');
INSERT INTO Verifications VALUES (100,100,1,'Under Review','Under client review','2026-08-20 10:00:00');

INSERT INTO Reviews VALUES (1,1,2,12,4.8,'Excellent work delivered on time, production ready','2026-08-26 11:00:00');
INSERT INTO Reviews VALUES (2,1,3,13,4.9,'Excellent work delivered on time, production ready','2026-08-27 11:00:00');
INSERT INTO Reviews VALUES (3,2,4,14,4.5,'Excellent work delivered on time, production ready','2026-08-28 11:00:00');
INSERT INTO Reviews VALUES (4,2,5,15,4.7,'Excellent work delivered on time, production ready','2026-08-29 11:00:00');
INSERT INTO Reviews VALUES (5,3,6,16,5.0,'Excellent work delivered on time, production ready','2026-08-25 11:00:00');
INSERT INTO Reviews VALUES (6,3,7,17,4.8,'Excellent work delivered on time, production ready','2026-08-26 11:00:00');
INSERT INTO Reviews VALUES (7,4,8,18,4.9,'Excellent work delivered on time, production ready','2026-08-27 11:00:00');
INSERT INTO Reviews VALUES (8,4,9,19,4.5,'Excellent work delivered on time, production ready','2026-08-28 11:00:00');
INSERT INTO Reviews VALUES (9,5,10,20,4.7,'Excellent work delivered on time, production ready','2026-08-29 11:00:00');
INSERT INTO Reviews VALUES (10,5,1,21,5.0,'Excellent work delivered on time, production ready','2026-08-25 11:00:00');
INSERT INTO Reviews VALUES (11,6,2,22,4.8,'Excellent work delivered on time, production ready','2026-08-26 11:00:00');
INSERT INTO Reviews VALUES (12,6,3,23,4.9,'Excellent work delivered on time, production ready','2026-08-27 11:00:00');
INSERT INTO Reviews VALUES (13,7,4,24,4.5,'Excellent work delivered on time, production ready','2026-08-28 11:00:00');
INSERT INTO Reviews VALUES (14,7,5,25,4.7,'Excellent work delivered on time, production ready','2026-08-29 11:00:00');
INSERT INTO Reviews VALUES (15,8,6,26,5.0,'Excellent work delivered on time, production ready','2026-08-25 11:00:00');
INSERT INTO Reviews VALUES (16,8,7,27,4.8,'Excellent work delivered on time, production ready','2026-08-26 11:00:00');
INSERT INTO Reviews VALUES (17,9,8,28,4.9,'Excellent work delivered on time, production ready','2026-08-27 11:00:00');
INSERT INTO Reviews VALUES (18,9,9,29,4.5,'Excellent work delivered on time, production ready','2026-08-28 11:00:00');
INSERT INTO Reviews VALUES (19,10,10,30,4.7,'Excellent work delivered on time, production ready','2026-08-29 11:00:00');
INSERT INTO Reviews VALUES (20,10,1,11,5.0,'Excellent work delivered on time, production ready','2026-08-25 11:00:00');
INSERT INTO Reviews VALUES (21,11,2,12,4.8,'Excellent work delivered on time, production ready','2026-08-26 11:00:00');
INSERT INTO Reviews VALUES (22,11,3,13,4.9,'Excellent work delivered on time, production ready','2026-08-27 11:00:00');
INSERT INTO Reviews VALUES (23,12,4,14,4.5,'Excellent work delivered on time, production ready','2026-08-28 11:00:00');
INSERT INTO Reviews VALUES (24,12,5,15,4.7,'Excellent work delivered on time, production ready','2026-08-29 11:00:00');
INSERT INTO Reviews VALUES (25,13,6,16,5.0,'Excellent work delivered on time, production ready','2026-08-25 11:00:00');
INSERT INTO Reviews VALUES (26,13,7,17,4.8,'Excellent work delivered on time, production ready','2026-08-26 11:00:00');
INSERT INTO Reviews VALUES (27,14,8,18,4.9,'Excellent work delivered on time, production ready','2026-08-27 11:00:00');
INSERT INTO Reviews VALUES (28,14,9,19,4.5,'Excellent work delivered on time, production ready','2026-08-28 11:00:00');
INSERT INTO Reviews VALUES (29,15,10,20,4.7,'Excellent work delivered on time, production ready','2026-08-29 11:00:00');
INSERT INTO Reviews VALUES (30,15,1,21,5.0,'Excellent work delivered on time, production ready','2026-08-25 11:00:00');
INSERT INTO Reviews VALUES (31,16,2,22,4.8,'Excellent work delivered on time, production ready','2026-08-26 11:00:00');
INSERT INTO Reviews VALUES (32,16,3,23,4.9,'Excellent work delivered on time, production ready','2026-08-27 11:00:00');
INSERT INTO Reviews VALUES (33,17,4,24,4.5,'Excellent work delivered on time, production ready','2026-08-28 11:00:00');
INSERT INTO Reviews VALUES (34,17,5,25,4.7,'Excellent work delivered on time, production ready','2026-08-29 11:00:00');
INSERT INTO Reviews VALUES (35,18,6,26,5.0,'Excellent work delivered on time, production ready','2026-08-25 11:00:00');
INSERT INTO Reviews VALUES (36,18,7,27,4.8,'Excellent work delivered on time, production ready','2026-08-26 11:00:00');
INSERT INTO Reviews VALUES (37,19,8,28,4.9,'Excellent work delivered on time, production ready','2026-08-27 11:00:00');
INSERT INTO Reviews VALUES (38,19,9,29,4.5,'Excellent work delivered on time, production ready','2026-08-28 11:00:00');
INSERT INTO Reviews VALUES (39,20,10,30,4.7,'Excellent work delivered on time, production ready','2026-08-29 11:00:00');
INSERT INTO Reviews VALUES (40,20,1,11,5.0,'Excellent work delivered on time, production ready','2026-08-25 11:00:00');
INSERT INTO Reviews VALUES (41,21,2,12,4.8,'Excellent work delivered on time, production ready','2026-08-26 11:00:00');
INSERT INTO Reviews VALUES (42,21,3,13,4.9,'Excellent work delivered on time, production ready','2026-08-27 11:00:00');
INSERT INTO Reviews VALUES (43,22,4,14,4.5,'Excellent work delivered on time, production ready','2026-08-28 11:00:00');
INSERT INTO Reviews VALUES (44,22,5,15,4.7,'Excellent work delivered on time, production ready','2026-08-29 11:00:00');
INSERT INTO Reviews VALUES (45,23,6,16,5.0,'Excellent work delivered on time, production ready','2026-08-25 11:00:00');
INSERT INTO Reviews VALUES (46,23,7,17,4.8,'Excellent work delivered on time, production ready','2026-08-26 11:00:00');
INSERT INTO Reviews VALUES (47,24,8,18,4.9,'Excellent work delivered on time, production ready','2026-08-27 11:00:00');
INSERT INTO Reviews VALUES (48,24,9,19,4.5,'Excellent work delivered on time, production ready','2026-08-28 11:00:00');
INSERT INTO Reviews VALUES (49,25,10,20,4.7,'Excellent work delivered on time, production ready','2026-08-29 11:00:00');
INSERT INTO Reviews VALUES (50,25,1,21,5.0,'Excellent work delivered on time, production ready','2026-08-25 11:00:00');
INSERT INTO Reviews VALUES (51,26,2,22,4.8,'Excellent work delivered on time, production ready','2026-08-26 11:00:00');
INSERT INTO Reviews VALUES (52,26,3,23,4.9,'Excellent work delivered on time, production ready','2026-08-27 11:00:00');
INSERT INTO Reviews VALUES (53,27,4,24,4.5,'Excellent work delivered on time, production ready','2026-08-28 11:00:00');
INSERT INTO Reviews VALUES (54,27,5,25,4.7,'Excellent work delivered on time, production ready','2026-08-29 11:00:00');
INSERT INTO Reviews VALUES (55,28,6,26,5.0,'Excellent work delivered on time, production ready','2026-08-25 11:00:00');
INSERT INTO Reviews VALUES (56,28,7,27,4.8,'Excellent work delivered on time, production ready','2026-08-26 11:00:00');
INSERT INTO Reviews VALUES (57,29,8,28,4.9,'Excellent work delivered on time, production ready','2026-08-27 11:00:00');
INSERT INTO Reviews VALUES (58,29,9,29,4.5,'Excellent work delivered on time, production ready','2026-08-28 11:00:00');
INSERT INTO Reviews VALUES (59,30,10,30,4.7,'Excellent work delivered on time, production ready','2026-08-29 11:00:00');
INSERT INTO Reviews VALUES (60,30,1,11,5.0,'Excellent work delivered on time, production ready','2026-08-25 11:00:00');
INSERT INTO Reviews VALUES (61,31,2,12,4.8,'Excellent work delivered on time, production ready','2026-08-26 11:00:00');
INSERT INTO Reviews VALUES (62,31,3,13,4.9,'Excellent work delivered on time, production ready','2026-08-27 11:00:00');
INSERT INTO Reviews VALUES (63,32,4,14,4.5,'Excellent work delivered on time, production ready','2026-08-28 11:00:00');
INSERT INTO Reviews VALUES (64,32,5,15,4.7,'Excellent work delivered on time, production ready','2026-08-29 11:00:00');
INSERT INTO Reviews VALUES (65,33,6,16,5.0,'Excellent work delivered on time, production ready','2026-08-25 11:00:00');
INSERT INTO Reviews VALUES (66,33,7,17,4.8,'Excellent work delivered on time, production ready','2026-08-26 11:00:00');
INSERT INTO Reviews VALUES (67,34,8,18,4.9,'Excellent work delivered on time, production ready','2026-08-27 11:00:00');
INSERT INTO Reviews VALUES (68,34,9,19,4.5,'Excellent work delivered on time, production ready','2026-08-28 11:00:00');
INSERT INTO Reviews VALUES (69,35,10,20,4.7,'Excellent work delivered on time, production ready','2026-08-29 11:00:00');
INSERT INTO Reviews VALUES (70,35,1,21,5.0,'Excellent work delivered on time, production ready','2026-08-25 11:00:00');
INSERT INTO Reviews VALUES (71,36,2,22,4.8,'Excellent work delivered on time, production ready','2026-08-26 11:00:00');
INSERT INTO Reviews VALUES (72,36,3,23,4.9,'Excellent work delivered on time, production ready','2026-08-27 11:00:00');
INSERT INTO Reviews VALUES (73,37,4,24,4.5,'Excellent work delivered on time, production ready','2026-08-28 11:00:00');
INSERT INTO Reviews VALUES (74,37,5,25,4.7,'Excellent work delivered on time, production ready','2026-08-29 11:00:00');
INSERT INTO Reviews VALUES (75,38,6,26,5.0,'Excellent work delivered on time, production ready','2026-08-25 11:00:00');
INSERT INTO Reviews VALUES (76,38,7,27,4.8,'Excellent work delivered on time, production ready','2026-08-26 11:00:00');
INSERT INTO Reviews VALUES (77,39,8,28,4.9,'Excellent work delivered on time, production ready','2026-08-27 11:00:00');
INSERT INTO Reviews VALUES (78,39,9,29,4.5,'Excellent work delivered on time, production ready','2026-08-28 11:00:00');
INSERT INTO Reviews VALUES (79,40,10,30,4.7,'Excellent work delivered on time, production ready','2026-08-29 11:00:00');
INSERT INTO Reviews VALUES (80,40,1,11,5.0,'Excellent work delivered on time, production ready','2026-08-25 11:00:00');
INSERT INTO Reviews VALUES (81,41,2,12,4.8,'Excellent work delivered on time, production ready','2026-08-26 11:00:00');
INSERT INTO Reviews VALUES (82,41,3,13,4.9,'Excellent work delivered on time, production ready','2026-08-27 11:00:00');
INSERT INTO Reviews VALUES (83,42,4,14,4.5,'Excellent work delivered on time, production ready','2026-08-28 11:00:00');
INSERT INTO Reviews VALUES (84,42,5,15,4.7,'Excellent work delivered on time, production ready','2026-08-29 11:00:00');
INSERT INTO Reviews VALUES (85,43,6,16,5.0,'Excellent work delivered on time, production ready','2026-08-25 11:00:00');
INSERT INTO Reviews VALUES (86,43,7,17,4.8,'Excellent work delivered on time, production ready','2026-08-26 11:00:00');
INSERT INTO Reviews VALUES (87,44,8,18,4.9,'Excellent work delivered on time, production ready','2026-08-27 11:00:00');
INSERT INTO Reviews VALUES (88,44,9,19,4.5,'Excellent work delivered on time, production ready','2026-08-28 11:00:00');
INSERT INTO Reviews VALUES (89,45,10,20,4.7,'Excellent work delivered on time, production ready','2026-08-29 11:00:00');
INSERT INTO Reviews VALUES (90,45,1,21,5.0,'Excellent work delivered on time, production ready','2026-08-25 11:00:00');
INSERT INTO Reviews VALUES (91,46,2,22,4.8,'Excellent work delivered on time, production ready','2026-08-26 11:00:00');
INSERT INTO Reviews VALUES (92,46,3,23,4.9,'Excellent work delivered on time, production ready','2026-08-27 11:00:00');
INSERT INTO Reviews VALUES (93,47,4,24,4.5,'Excellent work delivered on time, production ready','2026-08-28 11:00:00');
INSERT INTO Reviews VALUES (94,47,5,25,4.7,'Excellent work delivered on time, production ready','2026-08-29 11:00:00');
INSERT INTO Reviews VALUES (95,48,6,26,5.0,'Excellent work delivered on time, production ready','2026-08-25 11:00:00');
INSERT INTO Reviews VALUES (96,48,7,27,4.8,'Excellent work delivered on time, production ready','2026-08-26 11:00:00');
INSERT INTO Reviews VALUES (97,49,8,28,4.9,'Excellent work delivered on time, production ready','2026-08-27 11:00:00');
INSERT INTO Reviews VALUES (98,49,9,29,4.5,'Excellent work delivered on time, production ready','2026-08-28 11:00:00');
INSERT INTO Reviews VALUES (99,50,10,30,4.7,'Excellent work delivered on time, production ready','2026-08-29 11:00:00');
INSERT INTO Reviews VALUES (100,50,1,11,5.0,'Excellent work delivered on time, production ready','2026-08-25 11:00:00');

INSERT INTO Payments VALUES (1,1,1,1,25500,'UPI','Paid','2026-08-16 12:00:00');
INSERT INTO Payments VALUES (2,1,2,1,25500,'Bank Transfer','Paid','2026-08-17 12:00:00');
INSERT INTO Payments VALUES (3,1,3,1,34000,'PayPal','Paid','2026-08-18 12:00:00');
INSERT INTO Payments VALUES (4,2,4,5,12600,'Razorpay','Paid','2026-08-19 12:00:00');
INSERT INTO Payments VALUES (5,2,5,5,12600,'UPI','Paid','2026-08-20 12:00:00');
INSERT INTO Payments VALUES (6,2,6,5,16800,'Bank Transfer','Paid','2026-08-21 12:00:00');
INSERT INTO Payments VALUES (7,3,7,9,49500,'PayPal','Paid','2026-08-22 12:00:00');
INSERT INTO Payments VALUES (8,3,8,9,49500,'Razorpay','Paid','2026-08-23 12:00:00');
INSERT INTO Payments VALUES (9,3,9,9,66000,'UPI','Paid','2026-08-24 12:00:00');
INSERT INTO Payments VALUES (10,4,10,13,21600,'Bank Transfer','Paid','2026-08-25 12:00:00');
INSERT INTO Payments VALUES (11,4,11,13,21600,'PayPal','Paid','2026-08-26 12:00:00');
INSERT INTO Payments VALUES (12,4,12,13,28800,'Razorpay','Paid','2026-08-27 12:00:00');
INSERT INTO Payments VALUES (13,5,13,17,33000,'UPI','Paid','2026-08-28 12:00:00');
INSERT INTO Payments VALUES (14,5,14,17,33000,'Bank Transfer','Paid','2026-08-29 12:00:00');
INSERT INTO Payments VALUES (15,5,15,17,44000,'PayPal','Paid','2026-08-15 12:00:00');
INSERT INTO Payments VALUES (16,6,16,21,11400,'Razorpay','Paid','2026-08-16 12:00:00');
INSERT INTO Payments VALUES (17,6,17,21,11400,'UPI','Paid','2026-08-17 12:00:00');
INSERT INTO Payments VALUES (18,6,18,21,15200,'Bank Transfer','Paid','2026-08-18 12:00:00');
INSERT INTO Payments VALUES (19,7,19,25,28500,'PayPal','Paid','2026-08-19 12:00:00');
INSERT INTO Payments VALUES (20,7,20,25,28500,'Razorpay','Paid','2026-08-20 12:00:00');
INSERT INTO Payments VALUES (21,7,21,25,38000,'UPI','Paid','2026-08-21 12:00:00');
INSERT INTO Payments VALUES (22,8,22,29,20400,'Bank Transfer','Paid','2026-08-22 12:00:00');
INSERT INTO Payments VALUES (23,8,23,29,20400,'PayPal','Paid','2026-08-23 12:00:00');
INSERT INTO Payments VALUES (24,8,24,29,27200,'Razorpay','Paid','2026-08-24 12:00:00');
INSERT INTO Payments VALUES (25,9,25,33,16800,'UPI','Paid','2026-08-25 12:00:00');
INSERT INTO Payments VALUES (26,9,26,33,16800,'Bank Transfer','Paid','2026-08-26 12:00:00');
INSERT INTO Payments VALUES (27,9,27,33,22400,'PayPal','Paid','2026-08-27 12:00:00');
INSERT INTO Payments VALUES (28,10,28,37,55500,'Razorpay','Paid','2026-08-28 12:00:00');
INSERT INTO Payments VALUES (29,10,29,37,55500,'UPI','Paid','2026-08-29 12:00:00');
INSERT INTO Payments VALUES (30,10,30,37,74000,'Bank Transfer','Paid','2026-08-15 12:00:00');
INSERT INTO Payments VALUES (31,11,31,41,43500,'PayPal','Paid','2026-08-16 12:00:00');
INSERT INTO Payments VALUES (32,11,32,41,43500,'Razorpay','Paid','2026-08-17 12:00:00');
INSERT INTO Payments VALUES (33,11,33,41,58000,'UPI','Paid','2026-08-18 12:00:00');
INSERT INTO Payments VALUES (34,12,34,45,18600,'Bank Transfer','Paid','2026-08-19 12:00:00');
INSERT INTO Payments VALUES (35,12,35,45,18600,'PayPal','Paid','2026-08-20 12:00:00');
INSERT INTO Payments VALUES (36,12,36,45,24800,'Razorpay','Paid','2026-08-21 12:00:00');
INSERT INTO Payments VALUES (37,13,37,49,52500,'UPI','Paid','2026-08-22 12:00:00');
INSERT INTO Payments VALUES (38,13,38,49,52500,'Bank Transfer','Paid','2026-08-23 12:00:00');
INSERT INTO Payments VALUES (39,13,39,49,70000,'PayPal','Paid','2026-08-24 12:00:00');
INSERT INTO Payments VALUES (40,14,40,53,23400,'Razorpay','Paid','2026-08-25 12:00:00');
INSERT INTO Payments VALUES (41,14,41,53,23400,'UPI','Paid','2026-08-26 12:00:00');
INSERT INTO Payments VALUES (42,14,42,53,31200,'Bank Transfer','Paid','2026-08-27 12:00:00');
INSERT INTO Payments VALUES (43,15,43,57,29400,'PayPal','Paid','2026-08-28 12:00:00');
INSERT INTO Payments VALUES (44,15,44,57,29400,'Razorpay','Paid','2026-08-29 12:00:00');
INSERT INTO Payments VALUES (45,15,45,57,39200,'UPI','Paid','2026-08-15 12:00:00');
INSERT INTO Payments VALUES (46,16,46,61,26400,'Bank Transfer','Paid','2026-08-16 12:00:00');
INSERT INTO Payments VALUES (47,16,47,61,26400,'PayPal','Paid','2026-08-17 12:00:00');
INSERT INTO Payments VALUES (48,16,48,61,35200,'Razorpay','Paid','2026-08-18 12:00:00');
INSERT INTO Payments VALUES (49,17,49,65,37500,'UPI','Paid','2026-08-19 12:00:00');
INSERT INTO Payments VALUES (50,17,50,65,37500,'Bank Transfer','Paid','2026-08-20 12:00:00');
INSERT INTO Payments VALUES (51,17,51,65,50000,'PayPal','Paid','2026-08-21 12:00:00');
INSERT INTO Payments VALUES (52,18,52,69,16200,'Razorpay','Paid','2026-08-22 12:00:00');
INSERT INTO Payments VALUES (53,18,53,69,16200,'UPI','Paid','2026-08-23 12:00:00');
INSERT INTO Payments VALUES (54,18,54,69,21600,'Bank Transfer','Paid','2026-08-24 12:00:00');
INSERT INTO Payments VALUES (55,19,55,73,34500,'PayPal','Paid','2026-08-25 12:00:00');
INSERT INTO Payments VALUES (56,19,56,73,34500,'Razorpay','Paid','2026-08-26 12:00:00');
INSERT INTO Payments VALUES (57,19,57,73,46000,'UPI','Paid','2026-08-27 12:00:00');
INSERT INTO Payments VALUES (58,20,58,77,58500,'Bank Transfer','Paid','2026-08-28 12:00:00');
INSERT INTO Payments VALUES (59,20,59,77,58500,'PayPal','Paid','2026-08-29 12:00:00');
INSERT INTO Payments VALUES (60,20,60,77,78000,'Razorpay','Paid','2026-08-15 12:00:00');
INSERT INTO Payments VALUES (61,21,61,81,54000,'UPI','Paid','2026-08-16 12:00:00');
INSERT INTO Payments VALUES (62,21,62,81,54000,'Bank Transfer','Paid','2026-08-17 12:00:00');
INSERT INTO Payments VALUES (63,21,63,81,72000,'PayPal','Paid','2026-08-18 12:00:00');
INSERT INTO Payments VALUES (64,22,64,85,46500,'Razorpay','Paid','2026-08-19 12:00:00');
INSERT INTO Payments VALUES (65,22,65,85,46500,'UPI','Paid','2026-08-20 12:00:00');
INSERT INTO Payments VALUES (66,22,66,85,62000,'Bank Transfer','Pending',NULL);
INSERT INTO Payments VALUES (67,23,67,89,27600,'PayPal','Pending',NULL);
INSERT INTO Payments VALUES (68,23,68,89,27600,'Razorpay','Pending',NULL);
INSERT INTO Payments VALUES (69,23,69,89,36800,'UPI','Pending',NULL);
INSERT INTO Payments VALUES (70,24,70,93,14400,'Bank Transfer','Pending',NULL);
INSERT INTO Payments VALUES (71,24,71,93,14400,'PayPal','Pending',NULL);
INSERT INTO Payments VALUES (72,24,72,93,19200,'Razorpay','Pending',NULL);
INSERT INTO Payments VALUES (73,25,73,97,31500,'UPI','Pending',NULL);
INSERT INTO Payments VALUES (74,25,74,97,31500,'Bank Transfer','Pending',NULL);
INSERT INTO Payments VALUES (75,25,75,97,42000,'PayPal','Pending',NULL);
INSERT INTO Payments VALUES (76,26,76,101,15600,'Razorpay','Pending',NULL);
INSERT INTO Payments VALUES (77,26,77,101,15600,'UPI','Pending',NULL);
INSERT INTO Payments VALUES (78,26,78,101,20800,'Bank Transfer','Pending',NULL);
INSERT INTO Payments VALUES (79,27,79,105,40500,'PayPal','Pending',NULL);
INSERT INTO Payments VALUES (80,27,80,105,40500,'Razorpay','Pending',NULL);
INSERT INTO Payments VALUES (81,27,81,105,54000,'UPI','Pending',NULL);
INSERT INTO Payments VALUES (82,28,82,109,22800,'Bank Transfer','Pending',NULL);
INSERT INTO Payments VALUES (83,28,83,109,22800,'PayPal','Pending',NULL);
INSERT INTO Payments VALUES (84,28,84,109,30400,'Razorpay','Pending',NULL);
INSERT INTO Payments VALUES (85,29,85,113,20700,'UPI','Pending',NULL);
INSERT INTO Payments VALUES (86,29,86,113,20700,'Bank Transfer','Failed',NULL);
INSERT INTO Payments VALUES (87,29,87,113,27600,'PayPal','Failed',NULL);
INSERT INTO Payments VALUES (88,30,88,117,36000,'Razorpay','Failed',NULL);
INSERT INTO Payments VALUES (89,30,89,117,36000,'UPI','Failed',NULL);
INSERT INTO Payments VALUES (90,30,90,117,48000,'Bank Transfer','Failed',NULL);
INSERT INTO Payments VALUES (91,31,91,121,8400,'PayPal','Failed',NULL);
INSERT INTO Payments VALUES (92,31,92,121,8400,'Razorpay','Failed',NULL);
INSERT INTO Payments VALUES (93,31,93,121,11200,'UPI','Failed',NULL);
INSERT INTO Payments VALUES (94,32,94,125,40500,'Bank Transfer','Failed',NULL);
INSERT INTO Payments VALUES (95,32,95,125,40500,'PayPal','Failed',NULL);
INSERT INTO Payments VALUES (96,32,96,125,54000,'Razorpay','Failed',NULL);
INSERT INTO Payments VALUES (97,33,97,129,26400,'UPI','Failed',NULL);
INSERT INTO Payments VALUES (98,33,98,129,26400,'Bank Transfer','Failed',NULL);
INSERT INTO Payments VALUES (99,33,99,129,35200,'PayPal','Failed',NULL);
INSERT INTO Payments VALUES (100,34,100,133,19500,'Razorpay','Failed',NULL);

INSERT INTO Certificates VALUES (1,1,1,11,'PW-CERT-2026-0001','2026-08-27 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0001');
INSERT INTO Certificates VALUES (2,2,1,12,'PW-CERT-2026-0002','2026-08-28 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0002');
INSERT INTO Certificates VALUES (3,3,2,13,'PW-CERT-2026-0003','2026-08-29 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0003');
INSERT INTO Certificates VALUES (4,4,2,14,'PW-CERT-2026-0004','2026-08-26 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0004');
INSERT INTO Certificates VALUES (5,5,3,15,'PW-CERT-2026-0005','2026-08-27 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0005');
INSERT INTO Certificates VALUES (6,6,3,16,'PW-CERT-2026-0006','2026-08-28 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0006');
INSERT INTO Certificates VALUES (7,7,4,17,'PW-CERT-2026-0007','2026-08-29 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0007');
INSERT INTO Certificates VALUES (8,8,4,18,'PW-CERT-2026-0008','2026-08-26 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0008');
INSERT INTO Certificates VALUES (9,9,5,19,'PW-CERT-2026-0009','2026-08-27 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0009');
INSERT INTO Certificates VALUES (10,10,5,20,'PW-CERT-2026-0010','2026-08-28 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0010');
INSERT INTO Certificates VALUES (11,11,6,21,'PW-CERT-2026-0011','2026-08-29 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0011');
INSERT INTO Certificates VALUES (12,12,6,22,'PW-CERT-2026-0012','2026-08-26 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0012');
INSERT INTO Certificates VALUES (13,13,7,23,'PW-CERT-2026-0013','2026-08-27 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0013');
INSERT INTO Certificates VALUES (14,14,7,24,'PW-CERT-2026-0014','2026-08-28 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0014');
INSERT INTO Certificates VALUES (15,15,8,25,'PW-CERT-2026-0015','2026-08-29 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0015');
INSERT INTO Certificates VALUES (16,16,8,26,'PW-CERT-2026-0016','2026-08-26 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0016');
INSERT INTO Certificates VALUES (17,17,9,27,'PW-CERT-2026-0017','2026-08-27 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0017');
INSERT INTO Certificates VALUES (18,18,9,28,'PW-CERT-2026-0018','2026-08-28 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0018');
INSERT INTO Certificates VALUES (19,19,10,29,'PW-CERT-2026-0019','2026-08-29 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0019');
INSERT INTO Certificates VALUES (20,20,10,30,'PW-CERT-2026-0020','2026-08-26 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0020');
INSERT INTO Certificates VALUES (21,21,11,11,'PW-CERT-2026-0021','2026-08-27 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0021');
INSERT INTO Certificates VALUES (22,22,11,12,'PW-CERT-2026-0022','2026-08-28 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0022');
INSERT INTO Certificates VALUES (23,23,12,13,'PW-CERT-2026-0023','2026-08-29 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0023');
INSERT INTO Certificates VALUES (24,24,12,14,'PW-CERT-2026-0024','2026-08-26 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0024');
INSERT INTO Certificates VALUES (25,25,13,15,'PW-CERT-2026-0025','2026-08-27 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0025');
INSERT INTO Certificates VALUES (26,26,13,16,'PW-CERT-2026-0026','2026-08-28 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0026');
INSERT INTO Certificates VALUES (27,27,14,17,'PW-CERT-2026-0027','2026-08-29 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0027');
INSERT INTO Certificates VALUES (28,28,14,18,'PW-CERT-2026-0028','2026-08-26 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0028');
INSERT INTO Certificates VALUES (29,29,15,19,'PW-CERT-2026-0029','2026-08-27 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0029');
INSERT INTO Certificates VALUES (30,30,15,20,'PW-CERT-2026-0030','2026-08-28 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0030');
INSERT INTO Certificates VALUES (31,31,16,21,'PW-CERT-2026-0031','2026-08-29 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0031');
INSERT INTO Certificates VALUES (32,32,16,22,'PW-CERT-2026-0032','2026-08-26 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0032');
INSERT INTO Certificates VALUES (33,33,17,23,'PW-CERT-2026-0033','2026-08-27 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0033');
INSERT INTO Certificates VALUES (34,34,17,24,'PW-CERT-2026-0034','2026-08-28 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0034');
INSERT INTO Certificates VALUES (35,35,18,25,'PW-CERT-2026-0035','2026-08-29 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0035');
INSERT INTO Certificates VALUES (36,36,18,26,'PW-CERT-2026-0036','2026-08-26 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0036');
INSERT INTO Certificates VALUES (37,37,19,27,'PW-CERT-2026-0037','2026-08-27 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0037');
INSERT INTO Certificates VALUES (38,38,19,28,'PW-CERT-2026-0038','2026-08-28 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0038');
INSERT INTO Certificates VALUES (39,39,20,29,'PW-CERT-2026-0039','2026-08-29 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0039');
INSERT INTO Certificates VALUES (40,40,20,30,'PW-CERT-2026-0040','2026-08-26 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0040');
INSERT INTO Certificates VALUES (41,41,21,11,'PW-CERT-2026-0041','2026-08-27 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0041');
INSERT INTO Certificates VALUES (42,42,21,12,'PW-CERT-2026-0042','2026-08-28 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0042');
INSERT INTO Certificates VALUES (43,43,22,13,'PW-CERT-2026-0043','2026-08-29 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0043');
INSERT INTO Certificates VALUES (44,44,22,14,'PW-CERT-2026-0044','2026-08-26 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0044');
INSERT INTO Certificates VALUES (45,45,23,15,'PW-CERT-2026-0045','2026-08-27 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0045');
INSERT INTO Certificates VALUES (46,46,23,16,'PW-CERT-2026-0046','2026-08-28 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0046');
INSERT INTO Certificates VALUES (47,47,24,17,'PW-CERT-2026-0047','2026-08-29 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0047');
INSERT INTO Certificates VALUES (48,48,24,18,'PW-CERT-2026-0048','2026-08-26 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0048');
INSERT INTO Certificates VALUES (49,49,25,19,'PW-CERT-2026-0049','2026-08-27 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0049');
INSERT INTO Certificates VALUES (50,50,25,20,'PW-CERT-2026-0050','2026-08-28 10:30:00','https://proofwork.io/cert/PW-CERT-2026-0050');
