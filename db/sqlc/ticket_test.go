package db

import (
	"Cinema/utils"
	"context"
	"database/sql"
	"github.com/stretchr/testify/require"
	"testing"
)

func TestQueries_CreateNewTicket(t *testing.T) {
	createRandomTicket(t)
}
func createRandomTicket(t *testing.T) {
	newSchedule := createRandomSchedule(t)
	var orderId sql.NullString
	err := orderId.Scan(utils.RandomID("O", 5))
	if err != nil {
		return
	}
	arg := CreateNewTicketParams{
		TicketID:   utils.RandomID("T", 5),
		ScheduleID: newSchedule.ScheduleID,
		OrderID:    orderId,
	}

	newTicket, err := testQueries.CreateNewTicket(context.Background(), arg)
	require.NoError(t, err)
	require.NotZero(t, newTicket)
}
