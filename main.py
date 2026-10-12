import json
from fastapi import FastAPI
from lda.summary import full_summary
from lda.llm import llm_debug
# from dotenv import load_dotenv


# load_dotenv()

app = FastAPI(title="Linux Debug Assistant")

@app.get('/')
async def to_check():
    return ('Hello')

@app.get("/summary")
async def get_summary():
    return await full_summary()

@app.get("/debug")
async def debug():
    summary = await full_summary()
    return {"analysis": await llm_debug(json.dumps(summary))}