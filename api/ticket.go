package api

import (
	db "Cinema/db/sqlc"
	"Cinema/utils"
	"context"
	"database/sql"
	"github.com/labstack/echo/v4"
	"net/http"
)

type NewTicketParams struct {
	ScheduleId string   `json:"schedule_id" form:"schedule_id" validate:"required"`
	SeatID     string   `json:"seat_id" form:"seat_id" validate:"required"`
	FoodID     []string `json:"food_id" form:"food_id"`
	DrinkID    []string `json:"drink_id" form:"drink_id"`
	//ScheduleId string `json:"schedule_id" form:"schedule_id" validate:"required"`
}

type TicketTxResult struct {
	Ticket   db.Ticket
	Schedule db.Schedule
	Order    db.Order
}

func (s *Server) CreateNewTicketRoute(ctx echo.Context) error {
	var newTicketParams = new(NewTicketParams)
	err := Bind(ctx, newTicketParams)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	c := context.Background()
	//var result = new(TicketTxResult)
	var ticketDetail db.GetTicketDetailRow
	err = s.ExecTx(c, func(q *db.Queries) error {
		// create orderID
		var err error
		orderID := utils.RandomID("O", 5)
		var order sql.NullString
		if len(newTicketParams.FoodID) > 0 || len(newTicketParams.DrinkID) > 0 {
			err = order.Scan(orderID)
			if err != nil {
				return err
			}
			_, err := s.CreateNewOrder(context.Background(), orderID)
			if err != nil {
				return err
			}

		}

		if len(newTicketParams.FoodID) > 0 {
			for _, e := range newTicketParams.FoodID {
				arg := db.CreateOrderFoodParams{
					OrderID: orderID,
					FoodID:  e,
				}
				_, err := q.CreateOrderFood(context.Background(), arg)
				if err != nil {
					return err
				}
			}
		}
		if len(newTicketParams.DrinkID) > 0 {
			for _, e := range newTicketParams.DrinkID {
				arg := db.CreateOrderDrinkParams{
					OrderID: orderID,
					DrinkID: e,
				}
				_, err := q.CreateOrderDrink(context.Background(), arg)
				if err != nil {
					return err
				}
			}
		}
		//ticketID := utils.RandomID("T", 5)
		arg := db.CreateNewTicketParams{
			TicketID:   utils.RandomID("T", 5),
			ScheduleID: newTicketParams.ScheduleId,
			OrderID:    order,
		}

		ticket, err := q.CreateNewTicket(c, arg)
		if err != nil {
			return err
		}
		// using go channel here
		//var wg sync.WaitGroup
		//wg.Add(1)
		//go func() {
		//	defer wg.Done()
		//	_, err := q.CreateNewTicket(c, arg)
		//	if err != nil {
		//		log.Fatal(err.Error())
		//	}
		//}()
		//wg.Wait()

		ticketSeatArg := db.CreateTicketSeatParams{
			TicketID: ticket.TicketID,
			SeatID:   newTicketParams.SeatID,
		}
		_, err = q.CreateTicketSeat(context.Background(), ticketSeatArg)
		if err != nil {
			return err
		}

		ticketDetail, err = q.GetTicketDetail(context.Background(), ticket.TicketID)
		if err != nil {
			return err
		}
		return err
	})
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	return ctx.JSON(http.StatusCreated, ticketDetail)
}

type TicketDetails struct {
	db.GetTicketDetailRow
	Order OrderDetail
}

type OrderDetail struct {
	Food  []db.GetListOrderFoodRow
	Drink []db.GetListOrderDrinkRow
}

func (s *Server) GetTicketRoute(ctx echo.Context) error {
	ticketId := ctx.Param("ticket_id")
	ticketDetails, err := s.GetTicketDetail(context.Background(), ticketId)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}

	// order by ticket
	orderId, err := s.GetOrderIdByTicketId(context.Background(), ticketId)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	if !orderId.Valid {
		return ctx.JSON(http.StatusOK, TicketDetails{
			GetTicketDetailRow: ticketDetails,
			Order:              OrderDetail{},
		})
	}
	orderFoodList, err := s.GetListOrderFood(context.Background(), orderId.String)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	orderDrinkList, err := s.GetListOrderDrink(context.Background(), orderId.String)

	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	orderResult := OrderDetail{
		Food:  orderFoodList,
		Drink: orderDrinkList,
	}
	return ctx.JSON(http.StatusOK, TicketDetails{
		GetTicketDetailRow: ticketDetails,
		Order:              orderResult,
	})
}

func (s *Server) DeleteTicketRoute(ctx echo.Context) error {
	ticketId := ctx.Param("ticket_id")
	err := s.DeleteTicket(context.Background(), ticketId)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	return ctx.JSON(http.StatusOK, echo.Map{
		"message": "Deleted",
	})
}
