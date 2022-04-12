package db

import (
	"Cinema/utils"
	"context"
	"github.com/stretchr/testify/require"
	"testing"
)

func TestQueries_CreateNewDrink(t *testing.T) {
	createRandomDrink(t)
}

func createRandomDrink(t *testing.T) Drink {
	arg := CreateNewDrinkParams{
		DrinkID:  utils.RandomID("D", 5),
		Name:     utils.RandomID("DN", 5),
		Price:    100,
		ImageUrl: utils.RandomID("IMG", 20),
	}
	drink, err := testQueries.CreateNewDrink(context.Background(), arg)

	require.NoError(t, err)
	require.NotZero(t, drink)

	return drink
}
