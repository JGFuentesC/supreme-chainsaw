from google.cloud import bigquery
from google.api_core import exceptions

def query_bigquery() -> str:
    """
    Executes a simple 'SELECT 1' query against Google BigQuery.
    This function is designed to be used as a tool by an LLM agent.
    It assumes default application credentials are set up.
    
    Returns:
        A string containing the single result from the query, or an error message.
    """
    try:
        client = bigquery.Client()
        query = "SELECT 1"
        query_job = client.query(query)
        results = query_job.result()  # Waits for the job to complete.
        
        for row in results:
            return f"Query returned: {row[0]}"
            
    except exceptions.GoogleAPICallError as e:
        return f"BigQuery API Error: {e}"
    except Exception as e:
        return f"An unexpected error occurred: {e}"

if __name__ == '__main__':
    print(query_bigquery()) 