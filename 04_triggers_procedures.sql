DELIMITER //
CREATE TRIGGER before_submission_insert
BEFORE INSERT ON Submissions FOR EACH ROW
BEGIN SET NEW.submitted_at = NOW(); END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE IssueCertificate(IN p_user_id INT, IN p_project_id INT)
BEGIN
INSERT INTO VerifiedExperience (user_id, project_id, certificate_url)
VALUES (p_user_id, p_project_id, CONCAT('https://proofwork.com/cert/', p_user_id, '-', p_project_id, '.pdf'));
END //
DELIMITER ;
