package routes

import (
	"net/http"
	"github.com/gin-gonic/gin"
)

// TODO: add the following to the liveness reponse
	// "version": settings.version,
	// "releaseId": settings.releaseId,
	// "time": datetime.now().isoformat()
func HealthLiveness(client *gin.Context) {
	client.JSON(http.StatusOK, gin.H{
		"status":      "ok",
		"description": "health of guestbook api",
	})
}

// TODO: test for redis access
func HealthReadiness(client *gin.Context) {
	client.JSON(http.StatusOK, gin.H{
		"status":      "ok",
		"description": "hredis available",
	})
}
