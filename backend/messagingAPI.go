package marketplace

import (
	"encoding/json"
	"net/http"

	"github.com/cosmos/cosmos-sdk/types"
	"github.com/gorilla/mux"
)

type Message struct {
	Sender    string `json:"sender"`
	Recipient string `json:"recipient"`
	Content   string `json:"content"`
}

var messages = make(map[string][]Message)

func SendMessageHandler(w http.ResponseWriter, r *http.Request) {
	var msg Message
	err := json.NewDecoder(r.Body).Decode(&msg)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	gc, err := NewGarbledCircuit()
	if err != nil {
		http.Error(w, "Failed to create garbled circuit", http.StatusInternalServerError)
		return
	}

	encryptedContent, err := gc.Encrypt(msg.Content)
	if err != nil {
		http.Error(w, "Failed to encrypt message", http.StatusInternalServerError)
		return
	}

	msg.Content = encryptedContent
	messages[msg.Recipient] = append(messages[msg.Recipient], msg)

	w.WriteHeader(http.StatusOK)
}

func GetMessagesHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	recipient := vars["recipient"]

	gc, err := NewGarbledCircuit()
	if err != nil {
		http.Error(w, "Failed to create garbled circuit", http.StatusInternalServerError)
		return
	}

	userMessages := messages[recipient]
	for i, msg := range userMessages {
		decryptedContent, err := gc.Decrypt(msg.Content)
		if err != nil {
			http.Error(w, "Failed to decrypt message", http.StatusInternalServerError)
			return
		}
		userMessages[i].Content = decryptedContent
	}

	json.NewEncoder(w).Encode(userMessages)
}

func SetupMessagingRoutes(router *mux.Router) {
	router.HandleFunc("/send-message", SendMessageHandler).Methods("POST")
	router.HandleFunc("/get-messages/{recipient}", GetMessagesHandler).Methods("GET")
}