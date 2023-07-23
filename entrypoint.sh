#!/bin/bash

# Start the Rasa server
rasa run -m models --enable-api --cors "*" --debug --port 5005 &

# Start the Rasa Actions server
rasa run actions --actions actions --debug --port 5055 &

# Wait for processes to finish
wait
