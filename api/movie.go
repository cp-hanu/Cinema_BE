package api

import (
	db "Cinema/db/sqlc"
	"Cinema/utils"
	"context"
	"github.com/labstack/echo/v4"
	"net/http"
)

type MovieParams struct {
	MovieName string `json:"movie_name" form:"movie_name" validate:"required" `
	ImageUrl  string `json:"image_url" form:"image_url" validate:"required"`
	Runtime   int32  `json:"runtime" form:"runtime" validate:"required"`
	Genre     string `json:"genre" form:"genre" validate:"required"`
	Status    string `json:"status" form:"status" validate:"required"`
}

func (s *Server) CreateNewMovieRoute(ctx echo.Context) error {
	var newMovie = new(MovieParams)
	err := Bind(ctx, newMovie)

	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}

	arg := db.CreateNewMovieParams{
		MovieID:   utils.RandomID("M", 5),
		MovieName: newMovie.MovieName,
		ImageUrl:  newMovie.ImageUrl,
		Runtime:   newMovie.Runtime,
		Genre:     newMovie.Genre,
		Status:    newMovie.Status,
	}

	movie, err := store.CreateNewMovie(context.Background(), arg)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	return ctx.JSON(http.StatusCreated, movie)
}

func (s *Server) GetCurrentRunningMovie(ctx echo.Context) error {
	allMovie, err := s.GetAllMovieAvailable(context.Background())
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	return ctx.JSON(http.StatusAccepted, allMovie)
}

func (s *Server) GetMovieDetails(ctx echo.Context) error {
	movieId := ctx.Param("movie_id")
	movie, err := s.GetMovieById(context.Background(), movieId)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	return ctx.JSON(http.StatusOK, movie)
}

func (s *Server) UpdateMovieRoute(ctx echo.Context) error {
	movieId := ctx.Param("movie_id")
	var movieParams = new(MovieParams)
	err := Bind(ctx, movieParams)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	arg := db.UpdateMovieParams{
		MovieID:   movieId,
		MovieName: movieParams.MovieName,
		Runtime:   movieParams.Runtime,
		Status:    movieParams.Status,
		ImageUrl:  movieParams.ImageUrl,
	}
	updatedMovie, err := s.UpdateMovie(context.Background(), arg)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	return ctx.JSON(http.StatusOK, updatedMovie)

}

func (s *Server) DeleteMovieRoute(ctx echo.Context) error {
	movieId := ctx.Param("movie_id")
	err := s.DeleteMovie(context.Background(), movieId)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	return ctx.JSON(http.StatusOK, echo.Map{
		"message": "Deleted",
	})
}
