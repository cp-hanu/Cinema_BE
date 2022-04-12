// Code generated by sqlc. DO NOT EDIT.
// source: food.sql

package db

import (
	"context"
)

const createNewFood = `-- name: CreateNewFood :one
INSERT INTO "Food"(food_id, name, price, image_url)
VALUES ($1, $2, $3, $4)
RETURNING id, food_id, name, price, image_url
`

type CreateNewFoodParams struct {
	FoodID   string `json:"food_id"`
	Name     string `json:"name"`
	Price    int64  `json:"price"`
	ImageUrl string `json:"image_url"`
}

func (q *Queries) CreateNewFood(ctx context.Context, arg CreateNewFoodParams) (Food, error) {
	row := q.db.QueryRowContext(ctx, createNewFood,
		arg.FoodID,
		arg.Name,
		arg.Price,
		arg.ImageUrl,
	)
	var i Food
	err := row.Scan(
		&i.ID,
		&i.FoodID,
		&i.Name,
		&i.Price,
		&i.ImageUrl,
	)
	return i, err
}

const deleteFood = `-- name: DeleteFood :exec
DELETE
FROM "Food"
WHERE food_id = $1
`

func (q *Queries) DeleteFood(ctx context.Context, foodID string) error {
	_, err := q.db.ExecContext(ctx, deleteFood, foodID)
	return err
}

const getAllFood = `-- name: GetAllFood :one
SELECT id, food_id, name, price, image_url
FROM "Food"
`

func (q *Queries) GetAllFood(ctx context.Context) (Food, error) {
	row := q.db.QueryRowContext(ctx, getAllFood)
	var i Food
	err := row.Scan(
		&i.ID,
		&i.FoodID,
		&i.Name,
		&i.Price,
		&i.ImageUrl,
	)
	return i, err
}

const getFoodById = `-- name: GetFoodById :one
SELECT id, food_id, name, price, image_url
FROM "Food"
WHERE food_id = $1
`

func (q *Queries) GetFoodById(ctx context.Context, foodID string) (Food, error) {
	row := q.db.QueryRowContext(ctx, getFoodById, foodID)
	var i Food
	err := row.Scan(
		&i.ID,
		&i.FoodID,
		&i.Name,
		&i.Price,
		&i.ImageUrl,
	)
	return i, err
}

const updateFood = `-- name: UpdateFood :one
UPDATE "Food"
SET name=$2,
    price=$3,
    image_url=$4
WHERE food_id = $1
RETURNING id, food_id, name, price, image_url
`

type UpdateFoodParams struct {
	FoodID   string `json:"food_id"`
	Name     string `json:"name"`
	Price    int64  `json:"price"`
	ImageUrl string `json:"image_url"`
}

func (q *Queries) UpdateFood(ctx context.Context, arg UpdateFoodParams) (Food, error) {
	row := q.db.QueryRowContext(ctx, updateFood,
		arg.FoodID,
		arg.Name,
		arg.Price,
		arg.ImageUrl,
	)
	var i Food
	err := row.Scan(
		&i.ID,
		&i.FoodID,
		&i.Name,
		&i.Price,
		&i.ImageUrl,
	)
	return i, err
}