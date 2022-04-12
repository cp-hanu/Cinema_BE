-- name: CreateNewDrink :one
INSERT INTO "Drink"(drink_id, name, price, image_url)
VALUES ($1, $2, $3, $4)
RETURNING *;

-- name: GetDrinkById :one
SELECT *
FROM "Drink"
WHERE drink_id = $1;

-- name: GetAllDrink :one
SELECT *
FROM "Drink";

-- name: UpdateDrink :one
UPDATE "Drink"
SET name      = $2,
    price     = $3,
    image_url = $4
WHERE drink_id = $1
RETURNING *;

-- name: DeleteDrink :exec
DELETE
FROM "Drink"
WHERE drink_id = $1;