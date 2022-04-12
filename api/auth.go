package api

import (
	db "Cinema/db/sqlc"
	"Cinema/utils"
	"context"
	"github.com/labstack/echo/v4"
	"net/http"
)

type UserLogin struct {
	UserName string `json:"username" form:"username"`
	Password string `json:"password" form:"password" `
}

func (s *Server) Login(ctx echo.Context) error {
	userLogin := new(UserLogin)
	if err := ctx.Bind(userLogin); err != nil {
		return err
	}

	if err := ctx.Validate(userLogin); err != nil {
		return err
	}

	user, err := s.GetUserByUserName(context.Background(), userLogin.UserName)
	if err != nil {
		return ctx.JSON(http.StatusNotFound, echo.Map{
			"message": "Cannot not found username",
		})
	}
	if !utils.ComparePassword(user.Password, userLogin.Password) {
		return ctx.JSON(http.StatusUnauthorized, "The password not match")
	}

	token, err := tokenManager.CreateToken(user.UserID, user.Role)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	return ctx.JSON(http.StatusOK, echo.Map{
		"token": token,
	})
}

type UserRegister struct {
	UserName  string `json:"username" form:"username" validate:"required"`
	FirstName string `json:"firstname" form:"firstname" validate:"required"`
	LastName  string `json:"lastname" form:"lastname"  validate:"required"`
	Password  string `json:"password" form:"password"  validate:"required" `
	Role      string `json:"role" form:"role"  validate:"required" `
}

func (s *Server) Register(ctx echo.Context) error {
	userRegister := new(UserRegister)
	var err error
	if err = ctx.Bind(userRegister); err != nil {
		return err
	}
	if err = ctx.Validate(userRegister); err != nil {
		return err
	}

	hashedPassword, err := utils.HashPassword(userRegister.Password)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	arg := db.CreateNewUserParams{
		UserID:    utils.RandomID("U", 5),
		UserName:  userRegister.UserName,
		FirstName: userRegister.FirstName,
		LastName:  userRegister.LastName,
		Password:  hashedPassword,
		Role:      userRegister.Role,
	}
	var newUser db.User
	newUser, err = s.CreateNewUser(context.Background(), arg)
	if err != nil {
		return err
	}
	token, err := tokenManager.CreateToken(newUser.UserID, newUser.Role)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}

	return ctx.JSON(http.StatusOK, echo.Map{
		"token": token,
	})
}

type UpdatePassword struct {
	OldPassword string `json:"old_password" form:"old_password" validate:"required"`
	NewPassword string `json:"new_password" form:"new_password" validate:"required"`
}

func (s *Server) UpdateUserPassword(ctx echo.Context) error {
	updatePassword := new(UpdatePassword)
	err := Bind(ctx, updatePassword)
	if err != nil {
		return err
	}
	//var user db.User
	user, ok := ctx.Get("user").(db.User)
	if !ok {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	if !utils.ComparePassword(user.Password, updatePassword.OldPassword) {
		return ctx.JSON(http.StatusUnauthorized, echo.Map{
			"message": "Wrong password",
		})
	}
	newPasswordHashed, err := utils.HashPassword(updatePassword.NewPassword)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	arg := db.UpdatePasswordParams{
		UserID:   user.UserID,
		Password: newPasswordHashed,
	}

	user, err = s.UpdatePassword(context.Background(), arg)
	if err != nil {
		return ctx.JSON(http.StatusInternalServerError, err)
	}
	return ctx.JSON(http.StatusOK, echo.Map{
		"message": "Update password successfully",
	})
}

func Bind(ctx echo.Context, request interface{}) error {
	if err := ctx.Bind(request); err != nil {
		return err
	}

	if err := ctx.Validate(request); err != nil {
		return err
	}
	return nil
}
