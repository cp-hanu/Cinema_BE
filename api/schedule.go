package api

import (
	db "Cinema/db/sqlc"
	"Cinema/utils"
	"context"
	"fmt"
	"github.com/labstack/echo/v4"
	"net/http"
)

type ScheduleParams struct {
	MovieId   string    `json:"movie_id" form:"movie_id" validate:"required"`
	RoomId    string    `json:"room_id" form:"room_id" validate:"required"`
	TimeStart int64     `json:"time_start" form:"time_start" validate:"required"`
	Price     ListPrice `json:"price" form:"price"`
}

type ListPrice struct {
	Normal   int64 `json:"normal"`
	VIP      int64 `json:"vip"`
	SweetBox int64 `json:"sweet_box"`
}

func (s *Server) TestRoute(ctx echo.Context) error {
	var scheduleParams = new(ScheduleParams)
	err := Bind(ctx, scheduleParams)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	fmt.Println(scheduleParams.Price.VIP)
	return ctx.JSON(http.StatusOK, scheduleParams)
}

func (s *Server) CreateNewScheduleRoute(ctx echo.Context) error {
	var newScheduleParams = new(ScheduleParams)
	err := Bind(ctx, newScheduleParams)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	// optional to check
	movie, err := s.GetMovieById(context.Background(), newScheduleParams.MovieId)

	if err != nil {
		return ctx.JSON(http.StatusNotFound, err)
	}

	timeStart := utils.ParseTimeFromEpoch(newScheduleParams.TimeStart)
	if err != nil {
		return ctx.JSON(http.StatusNotAcceptable, err)
	}
	timeEnd := utils.AddTime(timeStart, movie.Runtime)
	var c = context.Background()
	var newSchedule db.Schedule
	var DEFAULT_PRICE_NORMAL, DEFAULT_PRICE_VIP, DEFAULT_PRICE_SWEETBOX = 100000, 120000, 140000

	fmt.Println(DEFAULT_PRICE_SWEETBOX, DEFAULT_PRICE_NORMAL, DEFAULT_PRICE_VIP)

	err = s.ExecTx(c, func(q *db.Queries) error {
		arg := db.CreateNewScheduleParams{
			ScheduleID: utils.RandomID("S", 5),
			MovieID:    movie.MovieID,
			RoomID:     newScheduleParams.RoomId,
			TimeStart:  timeStart,
			TimeEnd:    timeEnd,
		}
		newSchedule, err = s.CreateNewSchedule(context.Background(), arg)
		if err != nil {
			return err
		}

		allTier, err := s.GetAllTier(c)
		if err != nil {
			return err
		}
		for _, tier := range allTier {
			var price int64
			switch tier.TierName {
			case "NORMAL":
				if newScheduleParams.Price.Normal == 0 {
					price = int64(DEFAULT_PRICE_NORMAL)
				} else {
					price = newScheduleParams.Price.Normal
				}
				arg := db.CreateScheduleTierParams{
					ScheduleID: newSchedule.ScheduleID,
					TierID:     tier.TierID,
					Price:      price,
				}
				_, err := s.CreateScheduleTier(c, arg)
				if err != nil {
					return err
				}
			case "VIP":
				if newScheduleParams.Price.VIP == 0 {
					price = int64(DEFAULT_PRICE_VIP)
				} else {
					price = newScheduleParams.Price.VIP
				}
				arg := db.CreateScheduleTierParams{
					ScheduleID: newSchedule.ScheduleID,
					TierID:     tier.TierID,
					Price:      price,
				}
				_, err := s.CreateScheduleTier(c, arg)
				if err != nil {
					return err
				}
			case "SWEET BOX":
				if newScheduleParams.Price.SweetBox == 0 {
					price = int64(DEFAULT_PRICE_SWEETBOX)
				} else {
					price = newScheduleParams.Price.SweetBox
				}
				arg := db.CreateScheduleTierParams{
					ScheduleID: newSchedule.ScheduleID,
					TierID:     tier.TierID,
					Price:      price,
				}
				_, err := s.CreateScheduleTier(c, arg)
				if err != nil {
					return err
				}
			}
		}
		return nil
	})
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	return ctx.JSON(http.StatusCreated, newSchedule)
}

func (s *Server) GetAllSchedule(ctx echo.Context) error {
	allSchedule, err := s.GetAllAvailableSchedule(context.Background())
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	return ctx.JSON(http.StatusAccepted, allSchedule)
}

func (s *Server) GetScheduleDetailsByScheduleID(ctx echo.Context) error {
	scheduleID := ctx.Param("schedule_id")
	scheduleDetails, err := s.GetScheduleByID(context.Background(), scheduleID)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	return ctx.JSON(http.StatusAccepted, scheduleDetails)
}

func (s *Server) GetMovieSelections(ctx echo.Context) error {
	movieSections, err := s.GetMovieSelection(context.Background())
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	return ctx.JSON(http.StatusAccepted, movieSections)
}

func (s *Server) GetAllScheduleByMovieID(ctx echo.Context) error {

	movieId := ctx.Param("movie_id")
	fmt.Println(movieId)
	allSchedule, err := s.GetAllScheduleByMovieId(context.Background(), movieId)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	return ctx.JSON(http.StatusAccepted, allSchedule)
}

func (s *Server) UpdateScheduleRoute(ctx echo.Context) error {
	scheduleId := ctx.Param("schedule_id")
	var scheduleParams = new(ScheduleParams)
	err := Bind(ctx, scheduleParams)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	var c = context.Background()
	err = s.ExecTx(c, func(qTx *db.Queries) error {
		var err error
		if err != nil {
			return ctx.JSON(http.StatusInternalServerError, err)
		}
		// optional to check
		movie, err := s.GetMovieById(context.Background(), scheduleParams.MovieId)

		if err != nil {
			return ctx.JSON(http.StatusNotFound, err)
		}

		timeStart := utils.ParseTimeFromEpoch(scheduleParams.TimeStart)
		if err != nil {
			return ctx.JSON(http.StatusNotAcceptable, err)
		}
		timeEnd := utils.AddTime(timeStart, movie.Runtime)

		argSchedule := db.UpdateScheduleParams{
			ScheduleID: scheduleId,
			MovieID:    movie.MovieID,
			RoomID:     scheduleParams.RoomId,
			TimeStart:  timeStart,
			TimeEnd:    timeEnd,
		}

		updatedSchedule, err := s.UpdateSchedule(c, argSchedule)
		if err != nil {
			return err
		}
		// update price, required have all field
		allTier, err := s.GetAllTier(c)
		if err != nil {
			return err
		}
		for _, tier := range allTier {
			switch tier.TierName {
			case "NORMAL":
				arg := db.UpdateTierPriceParams{
					ScheduleID: updatedSchedule.ScheduleID,
					TierID:     tier.TierID,
					Price:      scheduleParams.Price.Normal,
				}
				_, err := s.UpdateTierPrice(c, arg)
				if err != nil {
					return err
				}
			case "VIP":
				arg := db.UpdateTierPriceParams{
					ScheduleID: updatedSchedule.ScheduleID,
					TierID:     tier.TierID,
					Price:      scheduleParams.Price.VIP,
				}
				_, err := s.UpdateTierPrice(c, arg)
				if err != nil {
					return err
				}
			case "SWEET BOX":
				arg := db.UpdateTierPriceParams{
					ScheduleID: updatedSchedule.ScheduleID,
					TierID:     tier.TierID,
					Price:      scheduleParams.Price.SweetBox,
				}
				_, err := s.UpdateTierPrice(c, arg)
				if err != nil {
					return err
				}
			}
		}

		return err
	})
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	scheduleDetails, err := s.GetScheduleByID(c, scheduleId)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	return ctx.JSON(http.StatusOK, scheduleDetails)

}
