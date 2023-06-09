package main

import (
	"log"
	"net/http"
	"github.com/gin-gonic/gin"
	"github.com/gin-contrib/cors"
)

func main() {
	router := gin.New()
	router.Use(gin.Logger())

	router.Use(cors.Default())

	// TODO: add the following to the liveness reponse
	// "version": settings.version,
	// "releaseId": settings.releaseId,
	// "time": datetime.now().isoformat()

	router.GET("/health/liveness", func(client *gin.Context) {
		client.JSON(http.StatusOK, gin.H{
			"status": "ok",
			"description": "health of guestbook api",
		})
	})

	err := router.Run()
	if err != nil {
    	log.Fatal(err)
	}
}