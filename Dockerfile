FROM python:3.9

WORKDIR /app

EXPOSE 5000

COPY pyproject.toml /app

ENV PYTHONPATH=${PYTHONPATH}:${PWD} 
ENV FLASK_APP=app.py

RUN pip3 install poetry
RUN poetry config virtualenvs.create false
RUN poetry install --no-dev

COPY . /app
CMD [ "flask", "run", "--host", "0.0.0.0", "--port", "5000" ]
