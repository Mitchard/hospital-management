CREATE OR REPLACE TRIGGER trg_examine_require_comment_on_icu
    BEFORE INSERT OR UPDATE ON Examine
    FOR EACH ROW
DECLARE
    icuCount INTEGER;
BEGIN
    SELECT COUNT(*) INTO icuCount
    FROM StayIn S JOIN RoomService RS ON RS.RoomNum = S.RoomNum
    WHERE S.AdmissionNum = :NEW.AdmissionNum AND RS.Service = 'ICU';

    IF icuCount > 0 THEN
        IF :NEW.DoctorNotes IS NULL OR TRIM(:NEW.DoctorNotes) = '' THEN
            raise_application_error(-20001, 'Doctor must leave a comment when admission included an ICU stay.');
        END IF;
    END IF;
END;
/
