-- name: CreateNewSchedule :one
INSERT INTO "Schedule"(schedule_id, movie_id, room_id, time_start, time_end)
VALUES ($1, $2, $3, $4, $5)
RETURNING *;

-- name: GetScheduleByID :one
SELECT *
FROM "Schedule"
WHERE schedule_id = $1;

-- name: GetAllAvailableSchedule :many
SELECT S.schedule_id, S.time_start, S.time_end,
       M.movie_id, M.movie_name, M.runtime, M.genre, M.image_url,
       R.room_id,R.room_name
FROM "Schedule" S
         JOIN "Movie" M on M.movie_id = S.movie_id
         JOIN "Room" R on R.room_id = S.room_id
WHERE now() < time_end;

-- name: GetAllScheduleByMovieId :many
SELECT S.schedule_id, S.time_start, S.time_end,
       M.movie_id, M.movie_name, M.runtime, M.genre, M.image_url,
       R.room_id,R.room_name
FROM "Schedule" S
         JOIN "Movie" M on M.movie_id = S.movie_id
         JOIN "Room" R on R.room_id = S.room_id
WHERE now() < time_end AND M.movie_id = $1;

-- name: GetListPriceByScheduleId :many
SELECT * FROM "Schedule_Tier"
INNER JOIN "Tier" T on T.tier_id = "Schedule_Tier".tier_id
WHERE schedule_id = $1;

-- name: UpdateSchedule :one
UPDATE "Schedule"
SET movie_id = $2,
    room_id = $3,
    time_start = $4,
    time_end = $5
WHERE schedule_id = $1
RETURNING *;

-- name: DeleteSchedule :exec
DELETE
FROM "Schedule"
WHERE schedule_id = $1;