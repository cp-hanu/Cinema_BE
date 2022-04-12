package api

import (
	db "Cinema/db/sqlc"
	"context"
	"fmt"
	"github.com/labstack/echo/v4"
	"net/http"
)

type SeatResult struct {
	AllSeat    []db.GetAllSeatByScheduleIdRow    `json:"all_seat"`
	SeatInUsed []db.GetSeatInUsedByScheduleIdRow `json:"seat_in_used"`
}

type UpdateSeatParams struct {
	Active bool `json:"active" form:"active" validate:"required"`
}

func (s *Server) GetSeatInformation(ctx echo.Context) error {
	scheduleId := ctx.Param("schedule_id")
	fmt.Println(scheduleId)

	allSeats, err := s.GetAllSeatByScheduleId(context.Background(), scheduleId)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	seatInUsed, err := s.GetSeatInUsedByScheduleId(context.Background(), scheduleId)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	fmt.Println(seatInUsed, allSeats)
	return ctx.JSON(http.StatusAccepted, &SeatResult{AllSeat: allSeats, SeatInUsed: seatInUsed})
}

func (s *Server) UpdateSeatAvailabilityRoute(ctx echo.Context) error {
	seatId := ctx.Param("seat_id")
	var params = new(UpdateSeatParams)
	err := Bind(ctx, params)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	arg := db.UpdateSeatAvailabilityParams{
		SeatID: seatId,
		Active: params.Active,
	}
	seat, err := s.UpdateSeatAvailability(context.Background(), arg)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}

	return ctx.JSON(http.StatusOK, seat)
}
