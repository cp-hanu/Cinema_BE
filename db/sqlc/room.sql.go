// Code generated by sqlc. DO NOT EDIT.
// source: room.sql

package db

import (
	"context"
)

const createNewRoom = `-- name: CreateNewRoom :one
INSERT INTO "Room"
    (room_id, room_name, active)
VALUES ($1, $2, $3)
RETURNING id, room_id, room_name, active
`

type CreateNewRoomParams struct {
	RoomID   string `json:"room_id"`
	RoomName string `json:"room_name"`
	Active   bool   `json:"active"`
}

func (q *Queries) CreateNewRoom(ctx context.Context, arg CreateNewRoomParams) (Room, error) {
	row := q.db.QueryRowContext(ctx, createNewRoom, arg.RoomID, arg.RoomName, arg.Active)
	var i Room
	err := row.Scan(
		&i.ID,
		&i.RoomID,
		&i.RoomName,
		&i.Active,
	)
	return i, err
}

const deleteRoom = `-- name: DeleteRoom :exec
DELETE
FROM "Room"
WHERE room_id = $1
`

func (q *Queries) DeleteRoom(ctx context.Context, roomID string) error {
	_, err := q.db.ExecContext(ctx, deleteRoom, roomID)
	return err
}

const getAllAvailableRoom = `-- name: GetAllAvailableRoom :many
SELECT id, room_id, room_name, active
FROM "Room"
WHERE room_id NOT IN (
    SELECT r.room_id
    FROM "Schedule" as s
             INNER JOIN "Room" as r ON s.room_id = r.room_id
    WHERE $1 between s.time_start and s.time_end
       OR $2 between s.time_start and s.time_end
)
`

type GetAllAvailableRoomParams struct {
	TimeStart interface{} `json:"time_start"`
	TimeEnd   interface{} `json:"time_end"`
}

func (q *Queries) GetAllAvailableRoom(ctx context.Context, arg GetAllAvailableRoomParams) ([]Room, error) {
	rows, err := q.db.QueryContext(ctx, getAllAvailableRoom, arg.TimeStart, arg.TimeEnd)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	items := []Room{}
	for rows.Next() {
		var i Room
		if err := rows.Scan(
			&i.ID,
			&i.RoomID,
			&i.RoomName,
			&i.Active,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const getRoom = `-- name: GetRoom :one
SELECT id, room_id, room_name, active
FROM "Room"
WHERE room_id = $1
`

func (q *Queries) GetRoom(ctx context.Context, roomID string) (Room, error) {
	row := q.db.QueryRowContext(ctx, getRoom, roomID)
	var i Room
	err := row.Scan(
		&i.ID,
		&i.RoomID,
		&i.RoomName,
		&i.Active,
	)
	return i, err
}

const updateRoom = `-- name: UpdateRoom :one
UPDATE "Room"
SET room_name = $2,
    active = $3
WHERE room_id = $1
RETURNING id, room_id, room_name, active
`

type UpdateRoomParams struct {
	RoomID   string `json:"room_id"`
	RoomName string `json:"room_name"`
	Active   bool   `json:"active"`
}

func (q *Queries) UpdateRoom(ctx context.Context, arg UpdateRoomParams) (Room, error) {
	row := q.db.QueryRowContext(ctx, updateRoom, arg.RoomID, arg.RoomName, arg.Active)
	var i Room
	err := row.Scan(
		&i.ID,
		&i.RoomID,
		&i.RoomName,
		&i.Active,
	)
	return i, err
}