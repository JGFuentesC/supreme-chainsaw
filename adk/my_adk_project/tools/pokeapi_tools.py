import requests
from typing import Union, Dict

API_URL = "https://pokeapi.co/api/v2/pokemon/{pokemon_name_or_id}/"

def get_pokemon_stats(pokemon_name: str) -> Dict[str, Union[str, int, None]]:
    """
    Retrieves core stats for a specified Pokémon from the PokeAPI.
    This function is designed to be used as a tool by an LLM agent.

    Args:
        pokemon_name: The name or ID of the Pokémon to look up.

    Returns:
        A dictionary containing the Pokémon's stats, or an error message.
    """
    try:
        response = requests.get(API_URL.format(pokemon_name_or_id=pokemon_name.lower()))

        if response.status_code == 200:
            data = response.json()
            stats = {stat['stat']['name']: stat['base_stat'] for stat in data['stats']}
            return {
                'name': data['name'],
                'hp': stats.get('hp'),
                'attack': stats.get('attack'),
                'defense': stats.get('defense'),
                'special-attack': stats.get('special-attack'),
                'special-defense': stats.get('special-defense'),
                'speed': stats.get('speed'),
            }
        elif response.status_code == 404:
            return {"error": f"Pokémon '{pokemon_name}' not found."}
        else:
            return {"error": f"API request failed with status code {response.status_code}."}
            
    except requests.RequestException as e:
        return {"error": f"An error occurred during the API request: {e}"}

if __name__ == '__main__':
    print(f"Stats for Pikachu: {get_pokemon_stats('pikachu')}")
    print(f"Stats for a non-existent Pokémon: {get_pokemon_stats('notapokemon')}") 