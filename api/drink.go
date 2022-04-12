package api

import (
	db "Cinema/db/sqlc"
	"Cinema/utils"
	"context"
	"github.com/labstack/echo/v4"
	"net/http"
)

type DrinkParams struct {
	DrinkName string `json:"drink_name" form:"drink_name" validate:"required"`
	ImageUrl  string `json:"image_url" form:"image_url" validate:"required"`
	Price     int64  `json:"price" form:"price" validate:"required"`
}

func (s *Server) CreateNewDrinkRoute(ctx echo.Context) error {
	var newDrinkParams = new(DrinkParams)

	err := Bind(ctx, newDrinkParams)
	if err != nil {
		return err
	}
	arg := db.CreateNewDrinkParams{
		DrinkID:  utils.RandomID("D", 5),
		Name:     newDrinkParams.DrinkName,
		Price:    newDrinkParams.Price,
		ImageUrl: newDrinkParams.ImageUrl,
	}
	drink, err := s.CreateNewDrink(context.Background(), arg)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	return ctx.JSON(http.StatusCreated, drink)
}

func (s *Server) GetAllDrinkRoute(ctx echo.Context) error {
	allDrink, err := s.GetAllDrink(context.Background())
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	return ctx.JSON(http.StatusOK, allDrink)
}

func (s *Server) GetDrinkDetailRoute(ctx echo.Context) error {
	drinkId := ctx.Param("drink_id")
	drink, err := s.GetDrinkById(context.Background(), drinkId)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	return ctx.JSON(http.StatusOK, drink)
}

func (s *Server) UpdateDrinkRoute(ctx echo.Context) error {
	drinkId := ctx.Param("drink_id")
	// validate if this id has drink...

	var drinkParams = new(DrinkParams)
	err := Bind(ctx, drinkParams)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}

	arg := db.UpdateDrinkParams{
		DrinkID:  drinkId,
		Name:     drinkParams.DrinkName,
		Price:    drinkParams.Price,
		ImageUrl: drinkParams.ImageUrl,
	}
	updatedDrink, err := s.UpdateDrink(context.Background(), arg)

	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	return ctx.JSON(http.StatusOK, updatedDrink)
}

func (s *Server) DeleteDrinkRoute(ctx echo.Context) error {
	drinkId := ctx.Param("drink_id")

	err := s.DeleteDrink(context.Background(), drinkId)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	return ctx.JSON(http.StatusOK, echo.Map{
		"message": "Deleted",
	})
}
