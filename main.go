package main

import (
	"net/http"
	"github.com/gin-gonic/gin"
	//"github.com/gin-gonic/contrib/static"
)

func main() {
	router := gin.New()

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

	router.Run()
}