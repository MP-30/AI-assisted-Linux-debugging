import argparse
import asyncio
import json
from lda.summary import full_summary
from lda.llm import llm_debug

parser = argparse.ArgumentParser()
parser.add_argument("command", choices=["summary", "debug"])

args = parser.parse_args()

if args.command == 'summary':
    print(json.dumps(asyncio.run(full_summary()), indent=4))

elif args.command == "debug":
    summary = asyncio.run(full_summary())
    print(asyncio.run(llm_debug(json.dumps(summary))))
