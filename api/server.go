package api

import (
	"Cinema/auth"
	db "Cinema/db/sqlc"
	"Cinema/utils"
	"github.com/casbin/casbin/v2"
	"github.com/go-playground/validator"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	echoSwagger "github.com/swaggo/echo-swagger"
	_ "github.com/swaggo/echo-swagger/example/docs"
	"log"
)

type Server struct {
	*echo.Echo
	*db.Store
}

var store *db.Store

var tokenManager = auth.TokenManager{}

func (s *Server) StartServer(address string) {
	s.Logger.Fatal(s.Start(address))
}

func NewServer() *Server {
	conn, err := utils.InitDB()
	if err != nil {
		log.Fatal(err)
	}
	store = db.NewStore(conn)

	server := Server{echo.New(), store}
	server.Validator = &CustomValidator{Validator: validator.New()}
	//e := echo.New()

	server.Use(middleware.Logger())
	server.Use(middleware.Recover())

	server.Use(middleware.CORSWithConfig(middleware.CORSConfig{
		AllowOrigins: []string{"*"},
		AllowHeaders: []string{echo.HeaderOrigin, echo.HeaderContentType, echo.HeaderAccept},
	}))

	authEnforcer, err := casbin.NewEnforcer("auth_model.conf", "policy.csv")
	if err != nil {
		log.Fatal(err)
	}
	enforcer := Enforcer{Enforcer: authEnforcer}

	server.POST("api/v1/login", server.Login)
	//server.POST("register", server.Register)
	server.GET("/swagger/*", echoSwagger.WrapHandler)

	server.POST("/test", server.TestRoute)

	api := server.Group("/api/v1")
	api.Use(middleware.JWTWithConfig(tokenManager.CreateJWTConfig()))
	api.Use(enforcer.Enforce)

	// api admin GET
	apiGet := api.Group("/get")
	apiCreate := api.Group("/create")
	apiUpdate := api.Group("/update")
	apiDelete := api.Group("/delete")

	apiGet.GET("/seat/schedule/:schedule_id", server.GetSeatInformation)
	api.POST("/create/ticket", server.CreateNewTicketRoute)

	// Schedule API
	// GET : for all
	// api/v1/get/schedule
	apiCreate.POST("/schedule/create", server.CreateNewScheduleRoute)
	apiGet.GET("/schedule/getAll", server.GetAllSchedule)
	apiGet.GET("/schedule/:schedule_id", server.GetScheduleDetailsByScheduleID)
	apiGet.GET("/schedule/movie_selection", server.GetMovieSelections)
	apiGet.GET("/schedule/movie/:movie_id", server.GetAllScheduleByMovieID)
	apiGet.GET("/schedule/seat/:schedule_id", server.GetSeatInformation)

	apiUpdate.PUT("/schedule/:schedule_id", server.UpdateScheduleRoute)

	// Schedule create
	apiCreate.POST("/schedule", server.CreateNewScheduleRoute)
	//apiGetSchedule.PUT("/update/:schedule_id", server.UpdateSchedule)

	// Movie API
	apiCreate.POST("/movie", server.CreateNewMovieRoute)
	apiGet.GET("/movie/:movie_id", server.GetMovieDetails)
	apiGet.GET("/movie/all_available", server.GetCurrentRunningMovie)
	apiUpdate.PUT("/movie/:movie_id", server.UpdateMovieRoute)
	apiDelete.DELETE("/movie/:movie_id", server.DeleteMovieRoute)

	// Ticket API
	apiCreate.POST("/ticket", server.CreateNewTicketRoute)
	apiGet.GET("/ticket/:ticket_id", server.GetTicketRoute)
	apiDelete.DELETE("/ticket/:ticket_id", server.DeleteTicketRoute)

	// Room API
	apiCreate.POST("/room", server.CreateNewRoomRoute)
	apiGet.GET("/room/available", server.GetAvailableRooms)
	apiUpdate.PUT("/room/:room_id", server.UpdateRoomRoute)
	apiDelete.DELETE("/room/:rood_id", server.DeleteRoomRoute)

	// Seat API
	apiUpdate.PUT("/seat/:seat_id", server.UpdateSeatAvailabilityRoute)

	// Food API
	apiCreate.POST("/food", server.CreateNewFoodRoute)
	apiGet.GET("/food/:food_id", server.GetFoodDetailRoute)
	apiUpdate.PUT("/food/:food_id", server.UpdateFoodRoute)
	apiDelete.DELETE("/food/:food_id", server.DeleteFoodRoute)

	// Drink API
	apiCreate.POST("/drink", server.CreateNewDrinkRoute)
	apiGet.GET("/drink/:drink_id", server.GetDrinkDetailRoute)
	apiUpdate.PUT("/drink/:drink_id", server.UpdateDrinkRoute)
	apiDelete.DELETE("/drink/:drink_id", server.DeleteDrinkRoute)

	apiUpdate.PUT("/food/:food_id", server.UpdateFoodRoute)
	apiDelete.DELETE("/food/:food_id", server.DeleteFoodRoute)

	return &server
}
