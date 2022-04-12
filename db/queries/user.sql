-- name: CreateNewUser :one
INSERT INTO "User"(user_id, user_name, first_name, last_name, password, role)
VALUES ($1, $2, $3, $4, $5, $6)
RETURNING *;

-- name: GetUserByUserName :one
SELECT *
FROM "User"
WHERE user_name = $1;

-- name: GetUserByUserID :one
SELECT *
FROM "User"
WHERE user_id = $1;

-- name: UpdatePassword :one
UPDATE "User"
SET password=$2
WHERE user_id = $1
RETURNING *;