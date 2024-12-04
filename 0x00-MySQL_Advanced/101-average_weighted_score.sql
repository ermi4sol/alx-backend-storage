-- Advanced
DELIMITER $$

CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE finished INT DEFAULT 0;
    DECLARE current_user_id INT;

    -- Cursor to iterate over all user IDs
    DECLARE user_cursor CURSOR FOR SELECT id FROM users;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

    OPEN user_cursor;

    fetch_loop: LOOP
        FETCH user_cursor INTO current_user_id;
        IF finished THEN
            LEAVE fetch_loop;
        END IF;

        -- Call the single user procedure for each user
        CALL ComputeAverageWeightedScoreForUser(current_user_id);
    END LOOP;

    CLOSE user_cursor;
END$$

DELIMITER ;
