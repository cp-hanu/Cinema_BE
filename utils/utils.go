package utils

import (
	"database/sql"
	_ "github.com/lib/pq"
	nanoid "github.com/matoous/go-nanoid"
	"golang.org/x/crypto/bcrypt"
	"log"
	"time"
)

func InitDB() (*sql.DB, error) {
	config, err := LoadConfig("../../")
	if err != nil {
		return nil, err
	}
	conn, err := sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		return nil, err
	}
	return conn, nil
}
func RandomID(prefix string, num int) string {
	res, err := nanoid.Nanoid(num)
	if err != nil {
		log.Fatalln(err)
	}
	return prefix + "_" + res
}

func HashPassword(password string) (string, error) {
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)

	return string(hashedPassword), err
}

func ComparePassword(hashedPassword, password string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(hashedPassword), []byte(password))
	return err == nil
}

// ParseDate handle time start and time end
func ParseDate(timeStart string) (time.Time, error) {
	layout := "2006-01-02 15:04:05"
	t, err := time.Parse(layout, timeStart)
	loc, _ := time.LoadLocation("Asia/Ho_Chi_Minh")
	if err != nil {
		return time.Time{}, err
	}
	return t.In(loc), nil
}

func ParseTimeFromEpoch(epoch int64) time.Time {
	return time.Unix(epoch, 0).UTC()
}

func AddTime(timeStart time.Time, runtime int32) time.Time {
	return timeStart.Add(time.Minute * time.Duration(runtime)).UTC()
}
