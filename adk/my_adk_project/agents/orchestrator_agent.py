import os
import json
import google.generativeai as genai
from ..tools.bq_tools import query_bigquery
from ..tools.math_tools import calculate
from ..tools.pokeapi_tools import get_pokemon_stats

class OrchestratorAgent:
    """
    An orchestrator agent that uses a Large Language Model (LLM) 
    to understand user prompts and delegate tasks to the appropriate tools.
    """

    def __init__(self):
        """
        Initializes the agent, setting up the Gemini model and the available tools.
        """
        self.api_key = os.getenv("GEMINI_API_KEY")
        if not self.api_key:
            raise ValueError("GEMINI_API_KEY environment variable not found. Please set it in your .env file.")
        
        genai.configure(api_key=self.api_key)
        
        # Define the tools (functions) the model can call
        self.tools = {
            "get_pokemon_stats": get_pokemon_stats,
            "calculate": calculate,
            "query_bigquery": query_bigquery,
        }
        
        # Initialize the Gemini model with the available tools
        self.model = genai.GenerativeModel(
            model_name="gemini-1.5-flash-latest",
            tools=list(self.tools.values()),
        )

    def run_task(self, task_string: str) -> str:
        """
        Runs the main agent loop. It sends the user's prompt to the LLM,
        handles the LLM's function calls, and returns the final result.
        """
        try:
            chat_session = self.model.start_chat()
            response = chat_session.send_message(task_string)

            # Check for function calls and handle them in a loop
            while response.candidates[0].content.parts[0].function_call:
                function_call = response.candidates[0].content.parts[0].function_call
                func_name = function_call.name
                args = function_call.args

                if func_name not in self.tools:
                    return f"Error: The model tried to call an unknown function: {func_name}"

                # Call the tool and get the result
                func_to_call = self.tools[func_name]
                result = func_to_call(**dict(args))

                # Send the tool's output back to the model
                response = chat_session.send_message(
                    [
                        {
                            "function_response": {
                                "name": func_name,
                                "response": {"result": json.dumps(result)},
                            }
                        }
                    ]
                )

            # Once the model is done with function calls, return its final text response
            if response.candidates[0].content.parts[0].text:
                return response.candidates[0].content.parts[0].text
            
            return "The agent executed a tool but did not provide a final response."

        except Exception as e:
            return f"An error occurred: {e}" 