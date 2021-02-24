# demo-mlops

Demo app to set-up a CI pipeline for ML. [See notebook for more details](notebooks/get_started_with_cicd_ml.ipynb)



gcloud run deploy servelessml --region asia-southeast1 --platform managed --no-allow-unauthenticated --image gcr.io/freeldom/demo-mlops/dataprep:master-latest --args "python" --args="main.py" --args="--data-location" --args="s3://mylocation" --port 1443 [--async]


gcloud run deploy servelessml --region asia-southeast1 --platform managed --no-allow-unauthenticated --image gcr.io/freeldom/demo-mlops/dataprep:master-latest --args="../service.py" --args "python" --args="main.py" --args="--data-location" --args="s3://mylocation" --port 8080

curl -H "Authorization: Bearer $(gcloud auth print-identity-token)" https://servelessml-43pp7afxlq-as.a.run.app/status