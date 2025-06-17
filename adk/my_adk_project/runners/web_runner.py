import sys
import os
import uvicorn
from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
from pydantic import BaseModel
from typing import List, Union
from fastapi.requests import Request

from ..agents.orchestrator_agent import OrchestratorAgent

app = FastAPI()

# Mount static files
app.mount("/static", StaticFiles(directory=os.path.join(os.path.dirname(__file__), "static")), name="static")
templates = Jinja2Templates(directory=os.path.join(os.path.dirname(__file__), "static"))

orchestrator = OrchestratorAgent()

class TaskRequest(BaseModel):
    prompt: str

@app.get("/")
async def read_root(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})

@app.post("/run_task")
async def run_task_endpoint(request: TaskRequest):
    """
    Exposes a POST endpoint to run a task on the Orchestrator Agent.
    The payload should be a JSON with a "prompt" containing the natural language request.
    
    Example Payloads:
    - {"prompt": "run a bigquery query"}
    - {"prompt": "what is 25 divided by 5?"}
    - {"prompt": "dame las estadísticas de mew"}
    """
    result = orchestrator.run_task(request.prompt)
    return {"result": result}

def run_web():
    """
    Runs the web server.
    """
    uvicorn.run(app, host="0.0.0.0", port=8000) 