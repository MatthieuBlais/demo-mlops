from main import prepare_data


def test_prepare_data():
    """Dummy test function"""
    assert prepare_data("location") is False
    assert prepare_data("s3://mybucket/data/") is True