#!/usr/bin/python3

########################################################
# Health check for gifmachine api
# Usage:
#   ./health_check.py --base_url=http://localhost:4567
#
# The gifmachine API password should be set
# as an environment variable. Example:
#   export GIFMACHINE_PASSWORD=1234  
########################################################

import requests
import os
import argparse

def parse_args():
    parser_description = f"""
    Health check for gifmachine API. Important! The api password should be set as env var before
    running the script.

    Example: export GIFMACHINE_PASSWORD=1234"""
    
    parser = argparse.ArgumentParser(description=parser_description)

    parser.add_argument('--base_url', default='http://localhost:4567', help='Base URL for the gifmachine API. Defaults to: http://localhost:4567')
    return parser.parse_args()


def check_endpoint(url: str, method: str = 'get', data: dict = None) -> str:
    try:
        if method == 'get':
            response = requests.get(url)
        elif method == 'post':
            response = requests.post(url, data=data)
        else:
            return f"Invalid method for {url}"

        return response.status_code

    except Exception as e:
        return f"Exception occurred for {url}: {str(e)}"

def main():
    args = parse_args()
    BASE_URL = args.base_url
    GIFMACHINE_PASSWORD = os.environ.get("GIFMACHINE_PASSWORD", '')

    endpoints = [
        {'url': BASE_URL + '/', 'method': 'get'},
        {'url': BASE_URL + '/gif', 'method': 'get'},
        {'url': BASE_URL + '/gif', 'method': 'post', 'data': {'secret': GIFMACHINE_PASSWORD, 'url': 'http://somenicegifurl/with/a/nice/path', 'who': 'test', 'meme_top': 'top', 'meme_bottom': 'bottom'}},
        {'url': BASE_URL + '/reload', 'method': 'post', 'data': {'secret': GIFMACHINE_PASSWORD}},
        {'url': BASE_URL + '/history', 'method': 'get'},
        {'url': BASE_URL + '/search', 'method': 'get', 'data': {'query': 'test', 'page': 1}},
        {'url': BASE_URL + '/view/1', 'method': 'get'}
    ]

    for endpoint in endpoints:
        status = check_endpoint(**endpoint)
        assert status >= 200 and status <= 299, f"Endpoint {endpoint['url']} not healthy. HTTP status = {status}"
        print(f"{endpoint['url']}  OK")
        

if __name__ == "__main__":
    main()
