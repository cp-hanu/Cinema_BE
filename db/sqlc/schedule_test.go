package db

import (
	"Cinema/utils"
	"context"
	"github.com/stretchr/testify/require"
	"log"
	"testing"
)

func TestQueries_CreateNewSchedule(t *testing.T) {
	createRandomSchedule(t)
}

func createRandomSchedule(t *testing.T) Schedule {
	newMovie := createRandomMovie(t)
	newRoom := createRandomRoom(t)
	timeStart := "2022-03-30 9:30:20"
	runtime := 180

	start, err := utils.ParseDate(timeStart)
	if err != nil {
		log.Fatalln(err)
	}
	end := utils.AddTime(start, int32(runtime))
	arg := CreateNewScheduleParams{
		ScheduleID: utils.RandomID("S", 5),
		MovieID:    newMovie.MovieID,
		RoomID:     newRoom.RoomID,
		TimeStart:  start,
		TimeEnd:    end,
	}

	newSchedule, err := testQueries.CreateNewSchedule(context.Background(), arg)
	require.NoError(t, err)
	require.NotZero(t, newSchedule)

	return newSchedule

}
