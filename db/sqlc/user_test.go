package db

import (
	"Cinema/utils"
	"context"
	"github.com/stretchr/testify/require"
	"testing"
)

func TestQueries_CreateNewUser(t *testing.T) {
	createRandomUser(t)
}
func createRandomUser(t *testing.T) User {
	arg := CreateNewUserParams{
		UserID:    utils.RandomID("U", 5),
		UserName:  utils.RandomID("U", 5),
		FirstName: utils.RandomID("F", 5),
		LastName:  utils.RandomID("L", 4),
		Password:  utils.RandomID("P", 10),
		Role:      "staff",
	}

	user, err := testQueries.CreateNewUser(context.Background(), arg)

	require.NoError(t, err)
	require.NotZero(t, user)

	require.Equal(t, arg.UserID, user.UserID)
	require.Equal(t, arg.UserName, user.UserName)
	require.Equal(t, arg.FirstName, user.FirstName)
	require.Equal(t, arg.LastName, user.LastName)
	require.Equal(t, arg.Password, user.Password)
	require.Equal(t, arg.Role, user.Role)

	require.NotZero(t, user.ID)

	return user
}
