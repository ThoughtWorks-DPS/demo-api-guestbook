package main

import (
	"log"
	//"net/http"
	"github.com/gin-gonic/gin"
	"github.com/gin-contrib/cors"

	"src/github/ThoughtWorks-DPS/demo-api-guestbook/routes/health"
)

func main() {
	router := gin.New()
	router.Use(gin.Logger())
	router.Use(cors.Default())

	router.GET("/health/liveness", HealthLiveness)
	router.GET("/health/readiness", HealthReadiness)

	router.GET("/signatures", GetSignatures)

	err := router.Run()
	if err != nil {
    	log.Fatal(err)
	}
}
