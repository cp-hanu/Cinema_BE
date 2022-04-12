// Code generated by sqlc. DO NOT EDIT.
// source: drink.sql

package db

import (
	"context"
)

const createNewDrink = `-- name: CreateNewDrink :one
INSERT INTO "Drink"(drink_id, name, price, image_url)
VALUES ($1, $2, $3, $4)
RETURNING id, drink_id, name, price, image_url
`

type CreateNewDrinkParams struct {
	DrinkID  string `json:"drink_id"`
	Name     string `json:"name"`
	Price    int64  `json:"price"`
	ImageUrl string `json:"image_url"`
}

func (q *Queries) CreateNewDrink(ctx context.Context, arg CreateNewDrinkParams) (Drink, error) {
	row := q.db.QueryRowContext(ctx, createNewDrink,
		arg.DrinkID,
		arg.Name,
		arg.Price,
		arg.ImageUrl,
	)
	var i Drink
	err := row.Scan(
		&i.ID,
		&i.DrinkID,
		&i.Name,
		&i.Price,
		&i.ImageUrl,
	)
	return i, err
}

const deleteDrink = `-- name: DeleteDrink :exec
DELETE
FROM "Drink"
WHERE drink_id = $1
`

func (q *Queries) DeleteDrink(ctx context.Context, drinkID string) error {
	_, err := q.db.ExecContext(ctx, deleteDrink, drinkID)
	return err
}

const getAllDrink = `-- name: GetAllDrink :one
SELECT id, drink_id, name, price, image_url
FROM "Drink"
`

func (q *Queries) GetAllDrink(ctx context.Context) (Drink, error) {
	row := q.db.QueryRowContext(ctx, getAllDrink)
	var i Drink
	err := row.Scan(
		&i.ID,
		&i.DrinkID,
		&i.Name,
		&i.Price,
		&i.ImageUrl,
	)
	return i, err
}

const getDrinkById = `-- name: GetDrinkById :one
SELECT id, drink_id, name, price, image_url
FROM "Drink"
WHERE drink_id = $1
`

func (q *Queries) GetDrinkById(ctx context.Context, drinkID string) (Drink, error) {
	row := q.db.QueryRowContext(ctx, getDrinkById, drinkID)
	var i Drink
	err := row.Scan(
		&i.ID,
		&i.DrinkID,
		&i.Name,
		&i.Price,
		&i.ImageUrl,
	)
	return i, err
}

const updateDrink = `-- name: UpdateDrink :one
UPDATE "Drink"
SET name      = $2,
    price     = $3,
    image_url = $4
WHERE drink_id = $1
RETURNING id, drink_id, name, price, image_url
`

type UpdateDrinkParams struct {
	DrinkID  string `json:"drink_id"`
	Name     string `json:"name"`
	Price    int64  `json:"price"`
	ImageUrl string `json:"image_url"`
}

func (q *Queries) UpdateDrink(ctx context.Context, arg UpdateDrinkParams) (Drink, error) {
	row := q.db.QueryRowContext(ctx, updateDrink,
		arg.DrinkID,
		arg.Name,
		arg.Price,
		arg.ImageUrl,
	)
	var i Drink
	err := row.Scan(
		&i.ID,
		&i.DrinkID,
		&i.Name,
		&i.Price,
		&i.ImageUrl,
	)
	return i, err
}
