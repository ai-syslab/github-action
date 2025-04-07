# microservice/test_app.py

import pytest
from fastapi.testclient import TestClient
from .app import app

client = TestClient(app)

def test_hello():
    response = client.get("/")
    assert response.status_code == 200
    assert response.text == "Hello World!\n"
