CREATE FUNCTION
    assessment_instances_ensure_open (
        assessment_instance_id bigint
    ) RETURNS void
AS $$
DECLARE
    current_open boolean;
    deleted_at TIMESTAMPTZ;
BEGIN
    SELECT open, deleted_at
    INTO current_open, deleted_at
    FROM assessment_instances
    WHERE id = assessment_instance_id;

    IF NOT FOUND THEN RAISE EXCEPTION 'no such assessment_instance_id: %', assessment_instance_id USING ERRCODE = 'ST404'; END IF;

    IF NOT current_open THEN RAISE EXCEPTION 'assessment instance is not open: %', assessment_instance_id USING ERRCODE = 'ST403'; END IF;

    IF deleted_at IS NOT NULL THEN RAISE EXCEPTION 'assessment instance has been deleted: %', assessment_instance_id USING ERRCODE = 'ST410'; END IF;
END;
$$ LANGUAGE plpgsql VOLATILE;
