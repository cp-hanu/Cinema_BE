-- name: CreateNewRoom :one
INSERT INTO "Room"
    (room_id, room_name, active)
VALUES ($1, $2, $3)
RETURNING *;

-- name: GetRoom :one
SELECT *
FROM "Room"
WHERE room_id = $1;

-- name: GetAllAvailableRoom :many
SELECT *
FROM "Room"
WHERE room_id NOT IN (
    SELECT r.room_id
    FROM "Schedule" as s
             INNER JOIN "Room" as r ON s.room_id = r.room_id
    WHERE @time_start between s.time_start and s.time_end
       OR @time_end between s.time_start and s.time_end
);
-- name: UpdateRoom :one
UPDATE "Room"
SET room_name = $2,
    active = $3
WHERE room_id = $1
RETURNING *;

-- name: DeleteRoom :exec
DELETE
FROM "Room"
WHERE room_id = $1;