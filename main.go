package main

import (
	"log"
	//"net/http"
	"github.com/gin-gonic/gin"
	"github.com/gin-contrib/cors"

	"demo-api-guestbook/routes"
)

func main() {
	router := gin.New()
	router.Use(gin.Logger())
	router.Use(cors.Default())

	router.GET("/health/liveness", routes.HealthLiveness)
	router.GET("/health/readiness", routes.HealthReadiness)

	router.GET("/signatures", routes.GetSignatures)

	err := router.Run()
	if err != nil {
    	log.Fatal(err)
	}
}
