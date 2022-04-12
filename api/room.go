package api

import (
	db "Cinema/db/sqlc"
	"Cinema/utils"
	"context"
	"fmt"
	"github.com/labstack/echo/v4"
	"log"
	"net/http"
)

type RoomParams struct {
	RoomName string `json:"room_name" form:"room_name" validate:"required"`
}

func (s *Server) CreateNewRoomRoute(ctx echo.Context) error {
	var newRoom = new(RoomParams)
	err := Bind(ctx, newRoom)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	arg := db.CreateNewRoomParams{
		RoomID:   utils.RandomID("R", 5),
		RoomName: newRoom.RoomName,
		Active:   true,
	}

	room, err := s.CreateNewRoom(context.Background(), arg)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	err = GenerateSeat(room.RoomID)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	// Auto create new seat for room
	return ctx.JSON(http.StatusCreated, room)
}

func GenerateSeat(roomID string) error {
	ROW := []string{"A", "B", "C", "D", "E", "F", "G", "H", "J"}
	MaxCol := 12
	allTier, err := store.GetAllTier(context.Background())
	if err != nil {
		log.Fatal(err)
	}
	// create a map
	var m = map[string]string{}
	for _, e := range allTier {
		m[e.TierName] = e.TierID
	}
	tier := "NORMAL"
	for pos, e := range ROW {
		if pos > 3 && pos < 8 {
			tier = "VIP"
		} else if pos >= 8 {
			tier = "SWEET BOX"
		}
		for i := 1; i <= MaxCol; i++ {
			arg := db.CreatNewSeatParams{
				SeatID: utils.RandomID("S", 5),
				RoomID: roomID,
				TierID: m[tier],
				Row:    e,
				Column: int32(i),
				Active: true,
			}
			seat, err := store.CreatNewSeat(context.Background(), arg)
			fmt.Println(seat)
			if err != nil {
				return err
			}
		}
	}
	return nil
}

type RoomAvailableParams struct {
	TimeStart int64  `json:"time_start" form:"time_start" validate:"required"`
	MovieId   string `json:"movie_id" form:"movie_id" validate:"required"`
}

func (s *Server) GetAvailableRooms(ctx echo.Context) error {
	var newRoomAvailableParams = new(RoomAvailableParams)
	err := Bind(ctx, newRoomAvailableParams)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	timeStart := utils.ParseTimeFromEpoch(newRoomAvailableParams.TimeStart)
	movie, err := s.GetMovieById(context.Background(), newRoomAvailableParams.MovieId)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	timeEnd := utils.AddTime(timeStart, movie.Runtime)
	arg := db.GetAllAvailableRoomParams{
		TimeStart: timeStart,
		TimeEnd:   timeEnd,
	}
	rooms, err := s.GetAllAvailableRoom(context.Background(), arg)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	return ctx.JSON(http.StatusOK, rooms)
}

type UpdateRoomParams struct {
	RoomName string `json:"room_name" form:"room_name" validate:"required"`
	Active   bool   `json:"active" form:"active" validate:"required"`
}

func (s *Server) UpdateRoomRoute(ctx echo.Context) error {
	roomId := ctx.Param("room_id")
	var params = new(UpdateRoomParams)
	err := Bind(ctx, params)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	arg := db.UpdateRoomParams{
		RoomID:   roomId,
		RoomName: params.RoomName,
		Active:   params.Active,
	}

	room, err := s.UpdateRoom(context.Background(), arg)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}

	return ctx.JSON(http.StatusOK, room)
}

func (s *Server) DeleteRoomRoute(ctx echo.Context) error {
	roomId := ctx.Param("room_id")
	err := s.DeleteRoom(context.Background(), roomId)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	return ctx.JSON(http.StatusOK, echo.Map{
		"message": "Deleted",
	})
}
