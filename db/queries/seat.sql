-- name: CreatNewSeat :one
INSERT INTO "Seat"(seat_id, room_id, tier_id, row, "column", active)
VALUES ($1, $2, $3, $4, $5, $6)
RETURNING *;

-- name: GetAllSeatByScheduleId :many
SELECT S.seat_id,
       row,
       "column",
       T.tier_name as "tier",
       ST.price
FROM "Schedule" S2
         INNER JOIN "Room" R on R.room_id = S2.room_id
         INNER JOIN "Seat" S on R.room_id = S.room_id
         INNER JOIN "Tier" T on S.tier_id = T.tier_id
         INNER JOIN "Schedule_Tier" ST on T.tier_id = ST.tier_id
WHERE ST.schedule_id = $1
  AND S2.schedule_id = $1;

-- name: GetSeatInUsedByScheduleId :many
SELECT S.seat_id, row, "column"
FROM "Ticket" T
         INNER JOIN "Ticket_Seat" TS on T.ticket_id = TS.ticket_id
         INNER JOIN "Seat" S ON TS.seat_id = S.seat_id
WHERE schedule_id = $1;

-- name: UpdateSeatAvailability :one
UPDATE "Seat"
SET active=$2
WHERE seat_id = $1
RETURNING *;

-- name: DeleteSeat :exec
DELETE
FROM "Seat"
WHERE seat_id = $1;