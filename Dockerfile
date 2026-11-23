FROM python:3.11-slim-bookworm@sha256:a83ba18aef0f865b1a4a611c2cf460fe446f2795673bbb9fe43be570439e3b39
WORKDIR /app
COPY requirements.txt ./
RUN python3 -m pip install --no-cache-dir -r requirements.txt
COPY source_check.py ./
COPY ["资料", "资料"]
COPY tests ./tests
USER 1000:1000
CMD ["python3", "source_check.py"]
