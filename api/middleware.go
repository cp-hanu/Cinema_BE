package api

import (
	"context"
	"github.com/casbin/casbin/v2"
	"github.com/go-playground/validator"
	"github.com/labstack/echo/v4"
	"net/http"
)

type CustomValidator struct {
	Validator *validator.Validate
}

type Enforcer struct {
	Enforcer *casbin.Enforcer
}

func (cv *CustomValidator) Validate(i interface{}) error {
	if err := cv.Validator.Struct(i); err != nil {
		// Optionally, you could return the error to give each route more control over the status code
		return echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}
	return nil
}
func (e *Enforcer) Enforce(next echo.HandlerFunc) echo.HandlerFunc {
	return func(ctx echo.Context) error {
		//accessDetails := tokenManager.ExtractTokenMetadata(ctx)
		userAccess := tokenManager.ExtractTokenMetadata(ctx)
		user, err := store.GetUserByUserID(context.Background(), userAccess.UserId)
		if err != nil {
			return err
		}
		path := ctx.Request().URL.Path
		method := ctx.Request().Method
		res, err := e.Enforcer.Enforce(user.Role, path, method)
		if err != nil {
			return ctx.JSON(http.StatusInternalServerError, err)
		}
		ctx.Set("user", user)
		if res {
			err := next(ctx)
			if err != nil {
				return err
			}
		}
		return echo.ErrForbidden
	}
}
