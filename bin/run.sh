#!/bin/bash
dotnet run > stdout.txt & (sleep 3 && curl -s http://localhost:5000/api/todo | jq .)
