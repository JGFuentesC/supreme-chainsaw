import sys
import os
from dotenv import load_dotenv

# Load environment variables from .env file
# This should be done before any other imports that need the variables
load_dotenv()

# This is a bit of a hack to make the imports work correctly
# when running from the command line. It adds the project directory
# to the Python path.
sys.path.append(os.path.dirname(__file__))

from .runners.cli_runner import run_cli
from .runners.web_runner import run_web

def main():
    """
    Main entry point for the ADK project.
    Runs the CLI or Web runner based on command-line arguments.
    """
    if len(sys.argv) > 1:
        runner_type = sys.argv[1]
        if runner_type == 'cli':
            print("Starting CLI runner...")
            run_cli()
        elif runner_type == 'web':
            print("Starting Web runner...")
            run_web()
        else:
            print(f"Unknown runner type: '{runner_type}'. Use 'cli' or 'web'.")
    else:
        print("No runner specified. Defaulting to CLI runner.")
        print("Use 'python -m my_adk_project.main cli' or 'python -m my_adk_project.main web' to choose a runner.")
        run_cli()

if __name__ == '__main__':
    # To run, stand in the root of the project (adk) and run:
    # python -m my_adk_project.main cli
    # or
    # python -m my_adk_project.main web
    main() 