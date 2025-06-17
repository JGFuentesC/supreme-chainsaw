import sys
import os

from ..agents.orchestrator_agent import OrchestratorAgent

def run_cli():
    """
    Runs a command-line interface to interact with the Orchestrator Agent.
    """
    orchestrator = OrchestratorAgent()
    
    print("Orchestrator Agent CLI (Powered by Gemini)")
    print("Enter a natural language command, or 'exit' to quit.")
    print('Examples:')
    print('  Run a BigQuery query for me')
    print('  What is 55 times 123?')
    print('  dame las estadísticas de charmander')
    print('-' * 20)

    while True:
        try:
            task_string = input("> ")
            if task_string.lower() == 'exit':
                break
            if not task_string:
                continue
            
            result = orchestrator.run_task(task_string)
            print(result)

        except (KeyboardInterrupt, EOFError):
            print("\nExiting.")
            break 