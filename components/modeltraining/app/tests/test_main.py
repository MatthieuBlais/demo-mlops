from main import training_model


def test_training_model():
    """Dummy test function"""
    assert training_model("location") is False
    assert training_model("s3://mybucket/data/") is True