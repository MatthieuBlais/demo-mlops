import argparse
import time

def parse_inputs():
    """Parsing job input. data-location required"""
    parser = argparse.ArgumentParser()
    parser.add_argument("--data-location", help="Location of the data to prepare for the training", required=True)
    return parser.parse_args()

def prepare_data(data_location):
    """DUMMY Preparing data"""
    print(f"Preparing data from {data_location}")
    time.sleep(3)
    if (
        not data_location.startswith("s3://")
        and not data_location.startswith("gs://")
    ):
        return False
    return True

if __name__ == "__main__":
    """Dummy job"""
    args = parse_inputs()
    prepare_data(args.data_location)
    print(f"Done.")