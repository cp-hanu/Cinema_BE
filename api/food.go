package api

import (
	db "Cinema/db/sqlc"
	"Cinema/utils"
	"context"
	"github.com/labstack/echo/v4"
	"net/http"
)

type FoodParams struct {
	FoodName string `json:"food_name" form:"food_name" validate:"required"`
	ImageUrl string `json:"image_url" form:"image_url" validate:"required"`
	Price    int64  `json:"price" form:"price" validate:"required"`
}

func (s *Server) CreateNewFoodRoute(ctx echo.Context) error {
	var newFoodParams = new(FoodParams)

	err := Bind(ctx, newFoodParams)
	if err != nil {
		return err
	}
	arg := db.CreateNewFoodParams{
		FoodID:   utils.RandomID("D", 5),
		Name:     newFoodParams.FoodName,
		Price:    newFoodParams.Price,
		ImageUrl: newFoodParams.ImageUrl,
	}
	drink, err := s.CreateNewFood(context.Background(), arg)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	return ctx.JSON(http.StatusCreated, drink)
}

func (s *Server) GetAllFoodRoute(ctx echo.Context) error {
	allFood, err := s.GetAllFood(context.Background())
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	return ctx.JSON(http.StatusOK, allFood)
}

func (s *Server) GetFoodDetailRoute(ctx echo.Context) error {
	foodId := ctx.Param("food_id")
	food, err := s.GetFoodById(context.Background(), foodId)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	return ctx.JSON(http.StatusOK, food)
}

func (s *Server) UpdateFoodRoute(ctx echo.Context) error {
	foodId := ctx.Param("food_id")
	// validate if this id has food ...

	var foodParams = new(FoodParams)
	err := Bind(ctx, foodParams)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}

	arg := db.UpdateFoodParams{
		FoodID:   foodId,
		Name:     foodParams.FoodName,
		Price:    foodParams.Price,
		ImageUrl: foodParams.ImageUrl,
	}
	updatedFood, err := s.UpdateFood(context.Background(), arg)

	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	return ctx.JSON(http.StatusOK, updatedFood)
}

func (s *Server) DeleteFoodRoute(ctx echo.Context) error {
	foodId := ctx.Param("food_id")

	err := s.DeleteFood(context.Background(), foodId)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	return ctx.JSON(http.StatusOK, echo.Map{
		"message": "Deleted",
	})
}
