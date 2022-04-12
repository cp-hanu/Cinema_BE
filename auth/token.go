package auth

import (
	"github.com/golang-jwt/jwt"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"time"
)

type AccessDetails struct {
	UserId string `json:"user_id"`
	Role   string `json:"role"`
	jwt.StandardClaims
}

type TokenManager struct{}

func NewTokenService() *TokenManager {
	return &TokenManager{}
}

type TokenInterface interface {
	CreateJWTConfig()
	CreateToken(userId, role string) (jwt.Token, error)
	ExtractTokenMetadata(ctx echo.Context) (AccessDetails, error)
}

//var _ TokenInterface = &TokenManager{}

func (t *TokenManager) CreateJWTConfig() middleware.JWTConfig {
	return middleware.JWTConfig{
		Claims:     &AccessDetails{},
		SigningKey: []byte("secret"),
	}
}

func (t *TokenManager) CreateToken(userId, role string) (string, error) {
	claims := AccessDetails{
		UserId: userId,
		Role:   role,
		StandardClaims: jwt.StandardClaims{
			ExpiresAt: time.Now().Add(time.Hour * 24 * 5).Unix(),
		},
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)

	tokenString, err := token.SignedString([]byte("secret"))
	if err != nil {
		return "", err
	}
	return tokenString, err
}

func (t TokenManager) ExtractTokenMetadata(ctx echo.Context) *AccessDetails {
	user := ctx.Get("user").(*jwt.Token)
	claims := user.Claims.(*AccessDetails)
	return claims
}
