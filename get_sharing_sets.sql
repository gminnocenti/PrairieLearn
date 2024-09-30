-- docker exec -it mypl psql postgres -f PrairieLearn/get_sharing_sets.sql > sharing_sets.csv
COPY (
  SELECT
    ss.course_id,
    ss.name
  FROM
    sharing_sets AS ss
) TO STDOUT
With
  (FORMAT CSV, HEADER);
