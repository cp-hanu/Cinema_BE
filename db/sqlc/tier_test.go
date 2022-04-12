package db

import (
	"Cinema/utils"
	"context"
	"github.com/stretchr/testify/require"
	"testing"
)

func TestQueries_CreateNewTier(t *testing.T) {
	createRandomTier(t)
}
func createRandomTier(t *testing.T) Tier {
	arg := CreateNewTierParams{
		TierID:   utils.RandomID("T", 5),
		TierName: "SWEET BOX",
		Price:    140000,
	}
	tier, err := testQueries.CreateNewTier(context.Background(), arg)

	require.NoError(t, err)
	require.NotZero(t, tier)
	return tier
}
