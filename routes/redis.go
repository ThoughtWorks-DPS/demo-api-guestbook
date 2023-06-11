package routes

import (
	"net/http"
	"github.com/gin-gonic/gin"
)

// Basically a mock to start
func GetSignatures(client *gin.Context) {
	client.JSON(http.StatusOK, gin.H{
		"status":      "ok",
		"description": "read redis mock",
	})
}
