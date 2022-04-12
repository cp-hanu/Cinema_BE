package db

import (
	"Cinema/utils"
	"context"
	"github.com/stretchr/testify/require"
	"testing"
)

func TestQueries_CreateNewFood(t *testing.T) {
	createRandomFood(t)
}

func createRandomFood(t *testing.T) Food {
	arg := CreateNewFoodParams{
		FoodID:   utils.RandomID("F", 5),
		Name:     utils.RandomID("FN", 10),
		Price:    100,
		ImageUrl: utils.RandomID("PF", 5),
	}
	food, err := testQueries.CreateNewFood(context.Background(), arg)

	require.NoError(t, err)
	require.NotZero(t, food)
	return food
}
