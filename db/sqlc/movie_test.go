package db

import (
	"Cinema/utils"
	"context"
	"github.com/stretchr/testify/require"
	"testing"
)

func TestQueries_CreateNewMovie(t *testing.T) {
	createRandomMovie(t)
}

func createRandomMovie(t *testing.T) Movie {
	arg := CreateNewMovieParams{
		MovieID:   utils.RandomID("M", 5),
		MovieName: utils.RandomID("P", 10),
		ImageUrl:  utils.RandomID("IMG", 20),
		Runtime:   180,
		Genre:     utils.RandomID("G", 5),
		Status:    "ON_GOING",
	}

	newMovie, err := testQueries.CreateNewMovie(context.Background(), arg)

	require.NoError(t, err)
	require.NotZero(t, newMovie)
	return newMovie
}
