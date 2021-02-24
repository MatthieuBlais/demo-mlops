FROM python:3.8-slim

ENV PYTHONPATH /app

COPY requirements.txt .

RUN pip3 install -r requirements.txt

WORKDIR /app

COPY app/ .

ENTRYPOINT [ "/bin/bash" ]




# "python", "-m", "http.server", "1337", ">&/dev/null" "&&" "python" "main.py" "--data-location" "s3://mylocation" "&&" "echo" "\"{\\"status\\":\\"complete\\", \\"exitcode\\": $?}\"" ">" "index.html"


# "python -m http.server 1337 & && python main.py --data-location s3://mylocation && echo \"{\\"status\\":\\"complete\\", \\"exitcode\\": $?}\" > index.html"

# "python -m http.server 1337 &" && "python main.py --data-location s3://mylocation"

# "python -m http.server 1337 &" && ls