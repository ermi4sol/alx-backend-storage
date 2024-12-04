-- Advanced
DELIMITER $$

CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
    DECLARE total_weight INT;
    DECLARE total_weighted_score FLOAT;

    -- Calculate the total weight of the projects for the given user
    SELECT SUM(weight)
    INTO total_weight
    FROM projects
    WHERE id IN (SELECT project_id FROM corrections WHERE user_id = user_id);

    -- Calculate the total weighted score
    SELECT SUM(c.score * p.weight)
    INTO total_weighted_score
    FROM corrections c
    JOIN projects p ON c.project_id = p.id
    WHERE c.user_id = user_id;

    -- Update the user's average_score
    UPDATE users
    SET average_score = IF(total_weight > 0, total_weighted_score / total_weight, 0)
    WHERE id = user_id;
END$$

DELIMITER ;
