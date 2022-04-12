-- name: CreateNewTicket :one
INSERT INTO "Ticket"(ticket_id, schedule_id, order_id)
VALUES ($1, $2, $3)
RETURNING *;

-- name: CreateTicketSeat :one
INSERT INTO "Ticket_Seat"(ticket_id, seat_id)
VALUES ($1, $2)
RETURNING *;

-- name: GetTicketDetail :one
SELECT TS.ticket_id,
       S.seat_id,row,"column",
       R.room_id,room_name,
       M.movie_id, movie_name, runtime, genre, status, image_url,
       S2.schedule_id,time_start,time_end
FROM "Ticket"
         INNER JOIN "Ticket_Seat" TS on "Ticket".ticket_id = TS.ticket_id
         INNER JOIN "Seat" S on S.seat_id = TS.seat_id
         INNER JOIN "Schedule" S2 on S2.schedule_id = "Ticket".schedule_id
         INNER JOIN "Movie" M on M.movie_id = S2.movie_id
         INNER JOIN "Room" R on R.room_id = S2.room_id
WHERE TS.ticket_id = $1;

-- name: UpdateTicket :one
UPDATE "Ticket"
SET schedule_id=$2,
    order_id=$3
WHERE ticket_id = $1
RETURNING *;

-- name: DeleteTicket :exec
DELETE
FROM "Ticket"
WHERE ticket_id = $1;