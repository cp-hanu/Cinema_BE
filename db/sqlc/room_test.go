package db

import (
	"Cinema/utils"
	"context"
	"github.com/stretchr/testify/require"
	"testing"
)

func TestQueries_CreateNewRoom(t *testing.T) {
	createRandomRoom(t)
}

func createRandomRoom(t *testing.T) Room {
	arg := CreateNewRoomParams{
		RoomID:   utils.RandomID("R", 5),
		RoomName: utils.RandomID("RN", 3),
		Active:   true,
	}

	newRoom, err := testQueries.CreateNewRoom(context.Background(), arg)

	require.NoError(t, err)
	require.NotZero(t, newRoom)
	return newRoom
}
