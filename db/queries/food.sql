-- name: CreateNewFood :one
INSERT INTO "Food"(food_id, name, price, image_url)
VALUES ($1, $2, $3, $4)
RETURNING *;

-- name: GetFoodById :one
SELECT *
FROM "Food"
WHERE food_id = $1;

-- name: GetAllFood :one
SELECT *
FROM "Food";

-- name: UpdateFood :one
UPDATE "Food"
SET name=$2,
    price=$3,
    image_url=$4
WHERE food_id = $1
RETURNING *;

-- name: DeleteFood :exec
DELETE
FROM "Food"
WHERE food_id = $1;