package db

import (
	"Cinema/utils"
	"context"
	"github.com/stretchr/testify/require"
	"testing"
)

var tierIdCreated []string

func TestQueries_CreateNewTier(t *testing.T) {
	createRandomTier(t)
}
func createRandomTier(t *testing.T) Tier {
	id := utils.RandomID("T", 5)
	tierIdCreated = append(tierIdCreated, id)
	arg := CreateNewTierParams{
		TierID:   id,
		TierName: "SWEET BOX",
	}
	tier, err := testQueries.CreateNewTier(context.Background(), arg)

	require.NoError(t, err)
	require.NotZero(t, tier)
	return tier
}

func TestQueries_GetTierById(t *testing.T) {
	var id = utils.RandomID("T", 5)
	tierIdCreated = append(tierIdCreated, id)
	newTier := createRandomTier(t)
	tier, err := testQueries.GetTierById(context.Background(), newTier.TierID)

	require.NoError(t, err)
	require.NotZero(t, tier)
}

func TestQueries_DeleteTierByTierID(t *testing.T) {
	for _, id := range tierIdCreated {
		err := testQueries.DeleteTierByTierID(context.Background(), id)
		require.NoError(t, err)
	}
}