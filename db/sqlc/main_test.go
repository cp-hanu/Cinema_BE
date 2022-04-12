package db

import (
	"Cinema/utils"
	"database/sql"
	_ "github.com/lib/pq"
	"log"
	"os"
	"testing"
)

var testQueries *Queries
var testDb *sql.DB

func TestMain(m *testing.M) {
	var err error
	testDb, err = utils.InitDB()
	if err != nil {
		log.Fatal(err)
	}
	testQueries = New(testDb)
	os.Exit(m.Run())
}
