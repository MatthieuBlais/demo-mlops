FROM python:3.8-slim

ENV PYTHONPATH /app

COPY requirements.txt .

RUN pip3 install -r requirements.txt

COPY service.py .

RUN pip3 install Flask

WORKDIR /app

COPY app/ .

ENTRYPOINT [ "python3", "../service.py" ]




# "python", "-m", "http.server", "1337", ">&/dev/null" "&&" "python" "main.py" "--data-location" "s3://mylocation" "&&" "echo" "\"{\\"status\\":\\"complete\\", \\"exitcode\\": $?}\"" ">" "index.html"


# "python -m http.server 1337 & && python main.py --data-location s3://mylocation && echo \"{\\"status\\":\\"complete\\", \\"exitcode\\": $?}\" > index.html"

# "python -m http.server 1337 &" && "python main.py --data-location s3://mylocation"

# "python -m http.server 1337 &" && ls